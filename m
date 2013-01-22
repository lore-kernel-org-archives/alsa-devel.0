From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: HDA independent headphone
Date: Tue, 22 Jan 2013 16:04:46 +0800
Message-ID: <CAN8cciZfTh2Tw1xCrkVAmupe3YdK7sRaJhoHRUMytHubjTsvoQ@mail.gmail.com>
References: <CAN8ccib1K6gT+Dsg2mMZcLLyaB-DU3MUJ=hvOpTZecCP1uGBsw@mail.gmail.com>
 <CAN8ccia+SoKUvsXqXNcu7JvXUptkRd3tUwT28Zt_JFu=i0=dWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC3F264F24
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 09:04:47 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id c10so11043337ieb.39
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 00:04:46 -0800 (PST)
In-Reply-To: <CAN8ccia+SoKUvsXqXNcu7JvXUptkRd3tUwT28Zt_JFu=i0=dWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, pulseaudio-discuss@lists.freedesktop.org
Cc: basinilya@gmail.com, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > > Actually, it works fine in Skype when using "AD1989B Analog (hw:
0,2)". I
> > > was confused because I changed only "Speakers" to that device and
tried
> > > making a test sound. That did not work, apparently test sound goes to
> > > whatever "Ringing" is set to. But when making actual calls, it works
as
> > > expected and I can take advantage of the Independent HP feature.
> >
> > Hm, there should be nothing to touch the indep-HP mixer control from
> > PCM, so I have no idea why it went wrong.
> >
> > BTW, I guess we have still an issue regarding indep HP.  When it's ON,
> > should the auto-mute be disabled, no?
> > Although one can disable the automute manually, it'd be maybe more
> > user-friendly if the driver does it by itself.
> >
>
> The patch is below, already merged in test/hda-gen-parser branch (and
> test/hda-migrate and master branch, too), as usual.
>

Does it mean that the value of the "front headphone jack" kcontrol is no
longer updated when the independent headphone is switch on ?

>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Disable HP auto-mute during independent HP
mode
>
> Both the HP auto-mute and the independent HP mode conflict with each
> other.  Make HP auto-mute disabled (only for the affected HP jack)
> during the driver is in HP independent mode.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_generic.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 63d12ef..258fb5e 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1889,6 +1889,13 @@ static int indep_hp_put(struct snd_kcontrol
*kcontrol,
>                         *dacp = 0;
>                 else
>                         *dacp = spec->alt_dac_nid;
> +
> +               /* update HP auto-mute state too */
> +               if (spec->hp_automute_hook)
> +                       spec->hp_automute_hook(codec, NULL);
> +               else
> +                       snd_hda_gen_hp_automute(codec, NULL);
> +
>                 ret = 1;
>         }
>   unlock:
> @@ -3467,10 +3474,16 @@ static void call_update_outputs(struct hda_codec
*codec)
>  void snd_hda_gen_hp_automute(struct hda_codec *codec, struct
hda_jack_tbl *jack)
>  {
>         struct hda_gen_spec *spec = codec->spec;
> +       hda_nid_t *pins = spec->autocfg.hp_pins;
> +       int num_pins = ARRAY_SIZE(spec->autocfg.hp_pins);
> +
> +       /* No detection for the first HP jack during indep-HP mode */
> +       if (spec->indep_hp_enabled) {
> +               pins++;
> +               num_pins--;
> +       }
>
> -       spec->hp_jack_present =
> -               detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
> -                            spec->autocfg.hp_pins);
> +       spec->hp_jack_present = detect_jacks(codec, num_pins, pins);
>         if (!spec->detect_hp || (!spec->automute_speaker &&
!spec->automute_lo))
>                 return;
>         call_update_outputs(codec);
> --
> 1.8.1.1
>
