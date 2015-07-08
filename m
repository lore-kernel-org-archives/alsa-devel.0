From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - Incorrect default pin
 assignment for external base speaker and external microphone not working
Date: Wed, 8 Jul 2015 08:51:30 +0200
Message-ID: <CALUcmU=vP4B=agrO6XDhsPiPOTCnqudtNsT0W49YheHn9ypzDg@mail.gmail.com>
References: <CALUcmU=aB1oXFA7E3A2uPiu_3+--9OqkQPvo3hq0JCtNcPY5UA@mail.gmail.com>
 <CAN8cciZZ+akLsv=oz3SN0YD-mHhUJ+WZujQmTsEbw_PMgiVYYw@mail.gmail.com>
 <CALUcmUkeDRgu0+kzCVp_RP1ZBkFRQbifU456HNY7vf9H_SHhuQ@mail.gmail.com>
 <CAN8cciYgkzGxdUwi0DbifZRsGDvwPwuVMvaKVJ-k-kWAdzwQMw@mail.gmail.com>
 <CALUcmUmR3XCaQFjEbPtsPYS6QcRdkWFdtry+x3uWP7qLE07ePg@mail.gmail.com>
 <CAN8cciZ6GAWoad8OMzJOFzUwAQkjJAUS86NV3EbJNpvC3WhPow@mail.gmail.com>
 <CALUcmUk6niiT2aU2e4FcPDk_rxOf54F-g10ePCjgTQg38zuP6g@mail.gmail.com>
 <CAN8cciajhQsvasRPJuBGp9Hsj5vaiaczczDPAz5dR03UAad2Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D7C4261B07
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 08:51:50 +0200 (CEST)
Received: by oiab3 with SMTP id b3so40854488oia.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 23:51:49 -0700 (PDT)
In-Reply-To: <CAN8cciajhQsvasRPJuBGp9Hsj5vaiaczczDPAz5dR03UAad2Sg@mail.gmail.com>
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
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

First I think I am going to split this mail into two topics, starting with
the easiest one, the External Base speaker.

The code above added two new options: Surround 2.1 and Surround 4.0.
After plugging in the base speaker:

- The Base speaker plays without this code (but the previous code was
necessary) on the Speakers.
- The Base speaker does not play on Surround 2.1
- The Base speaker does play on Surround 4.0
- The Base speaker does not switch automatically to any Surround when
plugged in.

Recently I have been developing against the mainline Kernel 4.2-rc1, but it
gives me only kernel panics.
Than I realized that I should develop against the Alsa tree. What is the
best tree to develop patches against?

On 6 July 2015 at 05:19, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> >
> > I have tested the patch by manually adding the lines of code into
> mainline kernel 4.1.1.
> >
> > The base speakers works.
>
> Do you need special name for the external subwoofer jack detect control
> for pulseaudio automatically switch from stereo profile to 2.1 profile ?
>
> int snd_hda_jack_add_kctls(struct hda_codec *codec,
>    const struct auto_pin_cfg *cfg)
> {
> const hda_nid_t *p;
> int i, err;
>
> ...
>
> for (i = 0, p = cfg->line_out_pins; i < cfg->line_outs; i++, p++) {
> +     if (cfg->line_outs == 2 && i == 1)
> +         err = add_jack_kctl(codec, *p, cfg, "External Subwoofer");
> +     else
> err = add_jack_kctl(codec, *p, cfg, NULL);
> if (err < 0)
> return err;
> }
>
> > The headset microphone works.
> > The headphone, headset microphone and microphone jack detection seems to
> work in PulseAudio (showing by plugged or unplugged status).
> > However it does not automatically switch the (un)plugged microphone.
> > My guess is that it does not know if it should use the headset
> microphone or the microphone (instead of the default internal microphone).
> >
> > Do you think there is a way to automate the forward and backward
> switching between the internal microphone and headset microphone?
> >
>
>
> http://bazaar.launchpad.net/~unity-settings-daemon-team/unity-settings-daemon/trunk/view/head:/plugins/media-keys/what-did-you-plug-in/pa-backend.c
>
>   Headphone Mic Jack - indicates headphone and mic-in mode share the same
> jack,  i e, not two separate jacks. Hardware cannot distinguish between
> headphone and a mic.
>    Headset Mic Phantom Jack - indicates headset jack where hardware can
> not distinguish between headphones and headsets
>    Headset Mic Jack - indicates headset jack where hardware can
> distinguish between headphones and headsets. There is no use popping up a
> dialog in this case, unless we already need to do this for the mic-in mode.
>
> Auto mic need headset mic support jack detection
>
> There are two methods, both methods need to give up the capability of
> using headphone and mic
>
> cannot use hint for user to select this feature since user hint is applied
> after pin fixup
>
> 1) create headset mic jack as slave of headphone jack , this use headphone
> jack sense for the jack state of headset mic
>
>         spec->gen.combo_use_only_as_headset = 0;
>
> 2) change headphone jack to headset jack, this require add [Element
> Headset] to pulseaudio conf files
>
>         spec->gen.headset_and_no_hp = 0;
>
> Method 1 -
>
> Cons - hda-emu cannot emulate this master slave jack ctl and gated/gating
> jack ctl
>
> Method 2
>
> Cons - some notebook has
>
> a) headset and headphone jacks
>
> b)r headset and dock headset
>
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index ac0db16..7e9b7ae 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -4384,6 +4384,9 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec
> *codec,
>          /* don't detect pins retasked as outputs */
>          if (snd_hda_codec_get_pin_target(codec, pin) & AC_PINCTL_OUT_EN)
>              continue;
> +        if (pin == spec->headset_mic_pin)
> +            if (spec->headset_and_no_hp)
> +                pin = spec->autocfg.hp_pins[0];
>          if (snd_hda_jack_detect_state(codec, pin) == HDA_JACK_PRESENT) {
>              mux_select(codec, 0, spec->am_entry[i].idx);
>              return;
> diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
> index 56e4139..4c3e043 100644
> --- a/sound/pci/hda/hda_generic.h
> +++ b/sound/pci/hda/hda_generic.h
> @@ -236,6 +236,10 @@ struct hda_gen_spec {
>      unsigned int indep_hp_enabled:1; /* independent HP enabled */
>      unsigned int have_aamix_ctl:1;
>      unsigned int hp_mic_jack_modes:1;
> +    unsigned int combo_use_only_as_headset:1;  /* headphone mic jack -
> slave of headphone jack */
> +    unsigned int headset_and_no_hp:1;  /* headset jack */
> +
> +    hda_nid_t headset_mic_pin;
>
>      /* additional mute flags (only effective with auto_mute_via_amp=1) */
>      u64 mute_bits;
> diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
> index 366efbf..771e84f 100644
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -19,6 +19,7 @@
>  #include "hda_local.h"
>  #include "hda_auto_parser.h"
>  #include "hda_jack.h"
> +#include "hda_generic.h"
>
>  /**
>   * is_jack_detectable - Check whether the given pin is jack-detectable
> @@ -157,7 +158,10 @@ static void jack_detect_update(struct hda_codec
> *codec,
>      if (jack->phantom_jack)
>          jack->pin_sense = AC_PINSENSE_PRESENCE;
>      else
> -        jack->pin_sense = read_pin_sense(codec, jack->nid);
> +        if (jack->master_nid)
> +            jack->pin_sense = read_pin_sense(codec, jack->master_nid);
> +        else
> +            jack->pin_sense = read_pin_sense(codec, jack->nid);
>
>      /* A gating jack indicates the jack is invalid if gating is unplugged
> */
>      if (jack->gating_jack && !snd_hda_jack_detect(codec,
> jack->gating_jack))
> @@ -205,11 +209,20 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_set_dirty_all);
>  u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
>  {
>      struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
> +    struct hda_jack_tbl *slave;
> +    u32 sense;
>      if (jack) {
>          jack_detect_update(codec, jack);
>          return jack->pin_sense;
>      }
> -    return read_pin_sense(codec, nid);
> +    if (jack->master_nid)
> +        return read_pin_sense(codec, jack->master_nid);
> +    sense = read_pin_sense(codec, nid);
> +    if (jack->slave_nid) {
> +        slave = snd_hda_jack_tbl_get(codec, jack->slave_nid);
> +        slave->pin_sense = sense;
> +    }
> +    return sense;
>  }
>  EXPORT_SYMBOL_GPL(snd_hda_pin_sense);
>
> @@ -317,6 +330,28 @@ int snd_hda_jack_set_gating_jack(struct hda_codec
> *codec, hda_nid_t gated_nid,
>  EXPORT_SYMBOL_GPL(snd_hda_jack_set_gating_jack);
>
>  /**
> + * snd_hda_jack_set_master_slave
> + * @codec: the HDA codec
> + * @master_nid: use this nid for pin sense
> + * @slave_nid:  update slave jack pin sense
> + * use master pin sense for slave pin sense
> + */
> +int snd_hda_jack_set_master_slave(struct hda_codec *codec, hda_nid_t
> master_nid,
> +                 hda_nid_t slave_nid)
> +{
> +    struct hda_jack_tbl *master = snd_hda_jack_tbl_get(codec, master_nid);
> +    struct hda_jack_tbl *slave = snd_hda_jack_tbl_get(codec, slave_nid);
> +    if (master)
> +        master->slave_nid = slave_nid;
> +    if (slave) {
> +        slave->master_nid = master_nid;
> +        snd_hda_codec_write_cache(codec, slave_nid, 0,
> +                     AC_VERB_SET_UNSOLICITED_ENABLE, 0);
> +    }
> +    return 0;
> +}
> +
> +/**
>   * snd_hda_jack_report_sync - sync the states of all jacks and report if
> changed
>   * @codec: the HDA codec
>   */
> @@ -469,7 +504,8 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
>                 const struct auto_pin_cfg *cfg)
>  {
>      const hda_nid_t *p;
> -    int i, err;
> +    int i, err, loc;
> +    struct hda_gen_spec *spec = codec->spec;
>
>      for (i = 0; i < cfg->num_inputs; i++) {
>          /* If we have headphone mics; make sure they get the right name
> @@ -481,22 +517,37 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
>              else
>                  err = add_jack_kctl(codec, cfg->inputs[i].pin,
>                              cfg, "Headphone Mic");
> -        } else
> -            err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
> +        } else {
> +            if (cfg->inputs[i].is_headset_mic) {
> +                if (!spec->headset_and_no_hp)
> +                    err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
> NULL);
> +                else
> +                    err = 0;
> +            }
> +            else
> +                err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
>                          NULL);
> +        }
>          if (err < 0)
>              return err;
>      }
>
>      for (i = 0, p = cfg->line_out_pins; i < cfg->line_outs; i++, p++) {
> -        err = add_jack_kctl(codec, *p, cfg, NULL);
> +        loc = get_defcfg_location(get_wcaps(codec, *p));
> +        if (i == 1 && cfg->line_outs == 2 && loc == AC_JACK_LOC_EXTERNAL)
> +            err = add_jack_kctl(codec, *p, cfg, "External Subwoofer");
> +        else
> +            err = add_jack_kctl(codec, *p, cfg, NULL);
>          if (err < 0)
>              return err;
>      }
>      for (i = 0, p = cfg->hp_pins; i < cfg->hp_outs; i++, p++) {
>          if (*p == *cfg->line_out_pins) /* might be duplicated */
>              break;
> -        err = add_jack_kctl(codec, *p, cfg, NULL);
> +        if (spec->headset_and_no_hp && i == 0)
> +            err = add_jack_kctl(codec, *p, cfg, "Headset");
> +        else
> +            err = add_jack_kctl(codec, *p, cfg, NULL);
>          if (err < 0)
>              return err;
>      }
> @@ -507,6 +558,13 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
>          if (err < 0)
>              return err;
>      }
> +
> +    if (spec->combo_use_only_as_headset)
> +        for (i = 0; i < cfg->num_inputs; i++) {
> +            if (cfg->inputs[i].is_headset_mic)
> +                snd_hda_jack_set_master_slave(codec, cfg->hp_pins[0],
> cfg->inputs[i].pin);
> +        }
> +
>      for (i = 0, p = cfg->dig_out_pins; i < cfg->dig_outs; i++, p++) {
>          err = add_jack_kctl(codec, *p, cfg, NULL);
>          if (err < 0)
> diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
> index 387d309..364cfa5 100644
> --- a/sound/pci/hda/hda_jack.h
> +++ b/sound/pci/hda/hda_jack.h
> @@ -39,6 +39,8 @@ struct hda_jack_tbl {
>      unsigned int block_report:1;    /* in a transitional state - do not
> report to userspace */
>      hda_nid_t gating_jack;        /* valid when gating jack plugged */
>      hda_nid_t gated_jack;        /* gated is dependent on this jack */
> +    hda_nid_t master_nid;        /* use master_nid for jack sense */
> +    hda_nid_t slave_nid;        /* update slave_nid jack state */
>      int type;
>      struct snd_jack *jack;
>  };
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 8e02cdf..598a442 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -3998,6 +3998,16 @@ static void alc_update_headset_mode(struct
> hda_codec *codec)
>          return;
>      }
>
> +    if (spec->gen.combo_use_only_as_headset ||
> +        spec->gen.headset_and_no_hp) {
> +        if (snd_hda_jack_detect(codec, hp_pin)) {
> +            new_headset_mode = ALC_HEADSET_MODE_HEADSET;
> +            alc_determine_headset_type(codec);
> +            codec_info(codec, "mic_autoswitch\n");
> +            snd_hda_gen_mic_autoswitch(codec, NULL);
> +        }
> +    }
> +
>      switch (new_headset_mode) {
>      case ALC_HEADSET_MODE_UNPLUGGED:
>          alc_headset_mode_unplugged(codec);
> @@ -4056,8 +4066,10 @@ static void alc_probe_headset_mode(struct hda_codec
> *codec)
>
>      /* Find mic pins */
>      for (i = 0; i < cfg->num_inputs; i++) {
> -        if (cfg->inputs[i].is_headset_mic && !spec->headset_mic_pin)
> +        if (cfg->inputs[i].is_headset_mic && !spec->headset_mic_pin) {
>              spec->headset_mic_pin = cfg->inputs[i].pin;
> +            spec->gen.headset_mic_pin = spec->headset_mic_pin;
> +        }
>          if (cfg->inputs[i].is_headphone_mic && !spec->headphone_mic_pin)
>              spec->headphone_mic_pin = cfg->inputs[i].pin;
>      }
> @@ -4074,7 +4086,11 @@ static void alc_fixup_headset_mode(struct hda_codec
> *codec,
>
>      switch (action) {
>      case HDA_FIXUP_ACT_PRE_PROBE:
> -        spec->parse_flags |= HDA_PINCFG_HEADSET_MIC |
> HDA_PINCFG_HEADPHONE_MIC;
> +        if (spec->gen.combo_use_only_as_headset ||
> +            spec->gen.headset_and_no_hp)
> +            spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
> +        else
> +            spec->parse_flags |= HDA_PINCFG_HEADSET_MIC |
> HDA_PINCFG_HEADPHONE_MIC;
>          break;
>      case HDA_FIXUP_ACT_PROBE:
>          alc_probe_headset_mode(codec);
> @@ -6149,6 +6165,43 @@ static void alc668_restore_default_value(struct
> hda_codec *codec)
>      alc_process_coef_fw(codec, alc668_coefs);
>  }
>
> +static void alc668_fixup_asus_n751jk(struct hda_codec *codec,
> +                   const struct hda_fixup *fix, int action)
> +{
> +    struct alc_spec *spec = codec->spec;
> +    static const struct hda_pintbl normal_cfgs[] = {
> +        { 0x19, 0x03a1913d }, /* use as headphone mic, without its own
> jack detect */
> +        { 0x1a, 0x04110011 }, /* bass speaker at Ext Right with jack
> detect */
> +        { 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack
> detect */
> +        { }
> +    };
> +    static const struct hda_pintbl headset_cfgs[] = {
> +        { 0x19, 0x411111f0 }, /* N/A */
> +        { 0x1a, 0x04110011 }, /* bass speaker at Ext Right with jack
> detect */
> +        { 0x1b, 0x03a1103c }, /* use as headset mic, without its own jack
> detect */
> +        { }
> +    };
> +    switch(action){
> +    case HDA_FIXUP_ACT_PRE_PROBE:
> +        spec->gen.combo_use_only_as_headset = 0;
> +        spec->gen.headset_and_no_hp = 0;
> +        codec_info(codec, "use as headset %d\n",
> spec->gen.combo_use_only_as_headset);
> +        if (spec->gen.combo_use_only_as_headset ||
> +            spec->gen.headset_and_no_hp) {
> +            snd_hda_apply_pincfgs(codec, headset_cfgs);
> +            spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
> +        }
> +        else {
> +            snd_hda_apply_pincfgs(codec, normal_cfgs);
> +            spec->parse_flags |= HDA_PINCFG_HEADSET_MIC |
> HDA_PINCFG_HEADPHONE_MIC;
> +        }
> +        break;
> +    case HDA_FIXUP_ACT_BUILD:
> +        alc_fixup_bass_chmap(codec,  fix, action);
> +        break;
> +    }
> +}
> +
>  enum {
>      ALC662_FIXUP_ASPIRE,
>      ALC662_FIXUP_LED_GPIO1,
> @@ -6179,6 +6232,7 @@ enum {
>      ALC668_FIXUP_AUTO_MUTE,
>      ALC668_FIXUP_DELL_DISABLE_AAMIX,
>      ALC668_FIXUP_DELL_XPS13,
> +    ALC668_FIXUP_ASUS_N751JK,
>  };
>
>  static const struct hda_fixup alc662_fixups[] = {
> @@ -6419,6 +6473,12 @@ static const struct hda_fixup alc662_fixups[] = {
>          .type = HDA_FIXUP_FUNC,
>          .v.func = alc_fixup_bass_chmap,
>      },
> +    [ALC668_FIXUP_ASUS_N751JK] = {
> +        .type = HDA_FIXUP_FUNC,
> +        .v.func = alc668_fixup_asus_n751jk,
> +        .chained = true,
> +        .chain_id = ALC668_FIXUP_HEADSET_MODE,
> +    },
>  };
>
>  static const struct snd_pci_quirk alc662_fixup_tbl[] = {
> @@ -6441,6 +6501,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[]
> = {
>      SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
>      SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A),
>      SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ",
> ALC662_FIXUP_BASS_MODE4_CHMAP),
> +    SND_PCI_QUIRK(0x1043, 0x17bd, "Asus N751JK",
> ALC668_FIXUP_ASUS_N751JK),
>      SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
>      SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
>      SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ",
> ALC662_FIXUP_BASS_MODE4_CHMAP),
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
