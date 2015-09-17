From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: Asus N751JK - push/merge patches on mailinglist
Date: Thu, 17 Sep 2015 11:29:04 +0200
Message-ID: <CALUcmU=6mdyxzWtk=-XN3QchJS-23dm9fV-C6DumJUwXwrDvCQ@mail.gmail.com>
References: <CALUcmU=PksErKgSpf5Rn-ZkbfSPS5Y_jW+E=phy4VUsKicWG7Q@mail.gmail.com>
 <s5hfv2izqi5.wl-tiwai@suse.de>
 <CAN8cciZbNnBFnWrOhALJ4W6h9pb4i-2voj7Rj1K-_M-w+XR31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AB7B265289
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 11:29:24 +0200 (CEST)
Received: by oixx17 with SMTP id x17so6462464oix.0
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 02:29:23 -0700 (PDT)
In-Reply-To: <CAN8cciZbNnBFnWrOhALJ4W6h9pb4i-2voj7Rj1K-_M-w+XR31g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I do have the hardware including the headset (combo jack), headphones
(single jack), microphone (single jack).
Can you specify accurately what and how I need to test?

On 17 September 2015 at 11:24, Raymond Yau <superquad.vortex2@gmail.com>
wrote:

>
>
> 2015-09-13 16:13 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
>
>> On Sat, 12 Sep 2015 23:09:43 +0200,
>> Arthur Borsboom wrote:
>> >
>> > Hi Takashi,
>> >
>> > Previous month Raymond Yau has done great work to get the audio working
>> for
>> > the Asus N751JK laptop.
>> > He developed 7 patches, which I have tested and confirmed working on
>> this
>> > laptop.
>> >
>> > Raymond is not responding for about two weeks (maybe on holiday?).
>> > Would you mind to post these patches on the mailinglist (the correct
>> way)
>> > and/or merge them in a way the get into the mainline kernel a.s.a.p?
>>
>> Sorry, it can't be done like that.  The patches aren't yet in
>> acceptable forms, and it needs more changes to be merged to mainline.
>> It must be done by someone who did it originally or who has the
>> hardware and test.
>>
>
> I don't have the hardware, the alternate approach is to create headset
> jack (SND_JACK_HEADSET) and skip the creation of headset mic phanton jack
> instead of headphone jack and headset mic jack since implement sense_nid
> and slave_nid is not easy to debug
>
> What you need is adding "Jack Headset" to pulseaudio
> analog-input-headset-mic.conf since "Headset Jack" kctl already in
> analog-out-headphones.conf
>
>  static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
>  {
> +    struct hda_gen_spec *spec = codec->spec;
> +    struct auto_pin_cfg *cfg = &spec->autocfg;
>      unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
>      switch (get_defcfg_device(def_conf)) {
>      case AC_JACK_LINE_OUT:
>      case AC_JACK_SPEAKER:
>          return SND_JACK_LINEOUT;
>      case AC_JACK_HP_OUT:
> +        if (spec->hs_mic_use_hp_sense &&
> +            (nid == auto_cfg_hp_pins(cfg)[0]))
> +            return SND_JACK_HEADSET;
>          return SND_JACK_HEADPHONE;
>      case AC_JACK_SPDIF_OUT:
>      case AC_JACK_DIG_OTHER_OUT:
>
>
>
>                const struct auto_pin_cfg *cfg)
>  {
>      const hda_nid_t *p;
> +    struct hda_gen_spec *spec = codec->spec;
>      int i, err;
>
>      for (i = 0; i < cfg->num_inputs; i++) {
> @@ -482,6 +499,12 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
>                  err = add_jack_kctl(codec, cfg->inputs[i].pin,
>                              cfg, "Headphone Mic");
>          } else
> +        if (cfg->inputs[i].is_headset_mic &&
> +            spec->hs_mic_use_hp_sense &&
> +            !is_jack_detectable(codec, cfg->inputs[i].pin)) {
> +            err = 0;
> +
> +        } else
>              err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
>                          NULL);
>          if (err < 0)
> @@ -489,14 +512,21 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
>      }
>
>      for (i = 0, p = cfg->line_out_pins; i < cfg->line_outs; i++, p++) {
> -        err = add_jack_kctl(codec, *p, cfg, NULL);
> +        if (is_subwoofer(codec, *p, i, cfg->line_outs) &&
> +            is_external_pin(codec, *p))
> +            err = add_jack_kctl(codec, *p, cfg, "Ext Subwoofer");
> +        else
> +            err = add_jack_kctl(codec, *p, cfg, NULL);
>          if (err < 0)
>              return err;
>      }
>      for (i = 0, p = cfg->hp_pins; i < cfg->hp_outs; i++, p++) {
>          if (*p == *cfg->line_out_pins) /* might be duplicated */
>              break;
> -        err = add_jack_kctl(codec, *p, cfg, NULL);
> +        if (i == 0 && spec->hs_mic_use_hp_sense)
> +            err = add_jack_kctl(codec, *p, cfg, "Headset");
> +        else
> +            err = add_jack_kctl(codec, *p, cfg, NULL);
>          if (err < 0)
>              return err;
>      }
>
>
> change the pin to hp pin when mic pin is headset mic
>
> +bool is_headset_mic(struct hda_codec *codec, hda_nid_t nid)
> +{
> +    struct hda_gen_spec *spec = codec->spec;
> +    struct auto_pin_cfg *cfg = &spec->autocfg;
> +    int i;
> +
> +    for (i = 0; i < cfg->num_inputs; i++)
> +        if (nid == cfg->inputs[i].pin)
> +            return cfg->inputs[i].is_headset_mic;
> +    return false;
> +}
> +
>
>
> @@ -4384,6 +4399,8 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec
> *codec,
>          /* don't detect pins retasked as outputs */
>          if (snd_hda_codec_get_pin_target(codec, pin) & AC_PINCTL_OUT_EN)
>              continue;
> +        if (is_headset_mic(codec, pin) && spec->hs_mic_use_hp_sense)
> +            pin = auto_cfg_hp_pins(cfg)[0];
>          if (snd_hda_jack_detect_state(codec, pin) == HDA_JACK_PRESENT) {
>              mux_select(codec, 0, spec->am_entry[i].idx);
>              return;
>
>
>


-- 
Arthur Borsboom
Lieven de Keystraat 77
3067 KG, Rotterdam
The Netherlands
Mob: +31629089953
Email: arthurborsboom@gmail.com
Skype: Arthur Borsboom, The Hague, The Netherlands

[image: View Arthur's LinkedIn profile]
<http://uk.linkedin.com/in/arthurborsboom>
