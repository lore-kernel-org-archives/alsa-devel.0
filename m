From: "Andrew Boettcher" <a.boettcher@gmail.com>
Subject: Re: Intel8x0 8 channel sound
Date: Sun, 17 Feb 2008 14:31:11 -0500
Message-ID: <6a316a6e0802171131w799c34acoc92d6bb1c80ac7cb@mail.gmail.com>
References: <6a316a6e0802141202y6fe22539o8705ffdc1ac9d1cc@mail.gmail.com>
	<s5hodaiw6nf.wl%tiwai@suse.de>
	<6a316a6e0802171053n6bc2ed03q10b4baba30283479@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3097_12176030.1203276671166"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F3D24433
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2008 20:31:12 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so1419699fka.0
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2008 11:31:11 -0800 (PST)
In-Reply-To: <6a316a6e0802171053n6bc2ed03q10b4baba30283479@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_3097_12176030.1203276671166
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Feb 17, 2008 1:53 PM, Andrew Boettcher <a.boettcher@gmail.com> wrote:

> On Feb 15, 2008 11:01 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> > At Thu, 14 Feb 2008 15:02:04 -0500,
> > Andrew Boettcher wrote:
> > >
> > > For some intel 8x0 cards there is 8 channel sound (such as the ALC850
> > chip
> > > on NFORCE 4 boards), and this has not been patched yet though the
> > patch has
> > > been on the bug tracker.  Here it is again updated for 1.0.16.  There
> > is
> > > also a patch for the configuration in alsa-lib for cards/NFORCE.conf.
> >  I
> > > have been patching my sources every time I update my kernel, I figured
> > it
> > > was time for someone to actually submit this somewhere else.  The
> > patch was
> > > written by Martin Ellis.
> >
> > Thanks for submitting this.  I haven't checked that issue.
> >
> > The change is almost OK.  One thing to be fixed is the enablement of
> > chip->multi8.  It's unconditionally enabled together with multi6.
> >
> > I think we should add a new bitflag in ac97_codec->flags to indicate
> > that the codec supports 8 channels.  Also, ac97_channel_mode_info()
> > shouldn't be unconditionally 8-channels, too.  It should check the
> > 8-channel capability as well.
> >
> > Do you know which audio controller model supports 7.1 output?  We may
> > need to check the chip model eventualy for 7.1-enablement.
> > Certainly the earlier version of controllers don't support 7.1 output.
> > Well, but these are very unlikely with ALC850 chip, so maybe it
> > doesn't matter... :)
> >
> >
> > The below is a quick-fixed patch.  Could you try it?
> >
> >
> > Takashi
> >
> > ---
> >
> > diff -r 362cee3efa84 include/ac97_codec.h
> > --- a/include/ac97_codec.h      Fri Feb 15 16:43:11 2008 +0100
> > +++ b/include/ac97_codec.h      Fri Feb 15 16:59:51 2008 +0100
> > @@ -397,6 +397,7 @@
> >  #define AC97_HAS_NO_TONE       (1<<16) /* no Tone volume */
> >  #define AC97_HAS_NO_STD_PCM    (1<<17) /* no standard AC97 PCM volume
> > and mute */
> >  #define AC97_HAS_NO_AUX                (1<<18) /* no standard AC97 AUX
> > volume and mute */
> > +#define AC97_HAS_8CH           (1<<19) /* supports 8-channel output */
> >
> >  /* rates indexes */
> >  #define AC97_RATES_FRONT_DAC   0
> > diff -r 362cee3efa84 pci/ac97/ac97_patch.c
> > --- a/pci/ac97/ac97_patch.c     Fri Feb 15 16:43:11 2008 +0100
> > +++ b/pci/ac97/ac97_patch.c     Fri Feb 15 16:59:51 2008 +0100
> > @@ -114,10 +114,9 @@ static int ac97_surround_jack_mode_put(s
> >
> >  static int ac97_channel_mode_info(struct snd_kcontrol *kcontrol, struct
> > snd_ctl_elem_info *uinfo)
> >  {
> > -       static const char *texts[] = { "2ch", "4ch", "6ch" };
> > -       if (kcontrol->private_value)
> > -               return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
> > /* 4ch only */
> > -       return ac97_enum_text_info(kcontrol, uinfo, texts, 3);
> > +       static const char *texts[] = { "2ch", "4ch", "6ch", "8ch" };
> > +       return ac97_enum_text_info(kcontrol, uinfo, texts,
> > +                                  kcontrol->private_value);
> >  }
> >
> >  static int ac97_channel_mode_get(struct snd_kcontrol *kcontrol, struct
> > snd_ctl_elem_value *ucontrol)
> > @@ -133,13 +132,8 @@ static int ac97_channel_mode_put(struct
> >        struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
> >        unsigned char mode = ucontrol->value.enumerated.item[0];
> >
> > -       if (kcontrol->private_value) {
> > -               if (mode >= 2)
> > -                       return -EINVAL;
> > -       } else {
> > -               if (mode >= 3)
> > -                       return -EINVAL;
> > -       }
> > +       if (mode >= kcontrol->private_value)
> > +               return -EINVAL;
> >
> >        if (mode != ac97->channel_mode) {
> >                ac97->channel_mode = mode;
> > @@ -158,6 +152,7 @@ static int ac97_channel_mode_put(struct
> >                .get = ac97_surround_jack_mode_get, \
> >                .put = ac97_surround_jack_mode_put, \
> >        }
> > +/* 6ch */
> >  #define AC97_CHANNEL_MODE_CTL \
> >        { \
> >                .iface  = SNDRV_CTL_ELEM_IFACE_MIXER, \
> > @@ -165,7 +160,9 @@ static int ac97_channel_mode_put(struct
> >                .info = ac97_channel_mode_info, \
> >                .get = ac97_channel_mode_get, \
> >                .put = ac97_channel_mode_put, \
> > +               .private_value = 3, \
> >        }
> > +/* 4ch */
> >  #define AC97_CHANNEL_MODE_4CH_CTL \
> >        { \
> >                .iface  = SNDRV_CTL_ELEM_IFACE_MIXER, \
> > @@ -173,7 +170,17 @@ static int ac97_channel_mode_put(struct
> >                .info = ac97_channel_mode_info, \
> >                .get = ac97_channel_mode_get, \
> >                .put = ac97_channel_mode_put, \
> > -               .private_value = 1, \
> > +               .private_value = 2, \
> > +       }
> > +/* 8ch */
> > +#define AC97_CHANNEL_MODE_8CH_CTL \
> > +       { \
> > +               .iface  = SNDRV_CTL_ELEM_IFACE_MIXER, \
> > +               .name   = "Channel Mode", \
> > +               .info = ac97_channel_mode_info, \
> > +               .get = ac97_channel_mode_get, \
> > +               .put = ac97_channel_mode_put, \
> > +               .private_value = 4, \
> >        }
> >
> >  static inline int is_surround_on(struct snd_ac97 *ac97)
> > @@ -208,6 +215,11 @@ static inline int is_shared_micin(struct
> >  static inline int is_shared_micin(struct snd_ac97 *ac97)
> >  {
> >        return !ac97->indep_surround && !is_clfe_on(ac97);
> > +}
> > +
> > +static inline int alc850_is_aux_back_surround(struct snd_ac97 *ac97)
> > +{
> > +       return is_surround_on(ac97);
> >  }
> >
> >
> > @@ -2816,10 +2828,12 @@ static int patch_alc655(struct snd_ac97
> >
> >  #define AC97_ALC850_JACK_SELECT        0x76
> >  #define AC97_ALC850_MISC1      0x7a
> > +#define AC97_ALC850_MULTICH    0x6a
> >
> >  static void alc850_update_jacks(struct snd_ac97 *ac97)
> >  {
> >        int shared;
> > +       int aux_is_back_surround;
> >
> >        /* shared Line-In / Surround Out */
> >        shared = is_shared_surrout(ac97);
> > @@ -2837,13 +2851,18 @@ static void alc850_update_jacks(struct s
> >        /* MIC-IN = 1, CENTER-LFE = 5 */
> >        snd_ac97_update_bits(ac97, AC97_ALC850_JACK_SELECT, 7 << 4,
> >                             shared ? (5<<4) : (1<<4));
> > +
> > +       aux_is_back_surround = alc850_is_aux_back_surround(ac97);
> > +       /* Aux is Back Surround */
> > +       snd_ac97_update_bits(ac97, AC97_ALC850_MULTICH, 1 << 10,
> > +                            aux_is_back_surround ? (1<<10) : (0<<10));
> >  }
> >
> >  static const struct snd_kcontrol_new snd_ac97_controls_alc850[] = {
> >        AC97_PAGE_SINGLE("Duplicate Front", AC97_ALC650_MULTICH, 0, 1, 0,
> > 0),
> >        AC97_SINGLE("Mic Front Input Switch", AC97_ALC850_JACK_SELECT,
> > 15, 1, 1),
> >        AC97_SURROUND_JACK_MODE_CTL,
> > -       AC97_CHANNEL_MODE_CTL,
> > +       AC97_CHANNEL_MODE_8CH_CTL,
> >  };
> >
> >  static int patch_alc850_specific(struct snd_ac97 *ac97)
> > @@ -2878,6 +2897,7 @@ static int patch_alc850(struct snd_ac97
> >           spdif-in monitor off, spdif-in PCM off
> >           center on mic off, surround on line-in off
> >           duplicate front off
> > +          NB default bit 10=0 = Aux is Capture, not Back Surround
> >        */
> >        snd_ac97_write_cache(ac97, AC97_ALC650_MULTICH, 1<<15);
> >        /* SURR_OUT: on, Surr 1kOhm: on, Surr Amp: off, Front 1kOhm: off
> > diff -r 362cee3efa84 pci/intel8x0.c
> > --- a/pci/intel8x0.c    Fri Feb 15 16:43:11 2008 +0100
> > +++ b/pci/intel8x0.c    Fri Feb 15 16:59:51 2008 +0100
> > @@ -155,7 +155,8 @@ DEFINE_REGSET(SP, 0x60);    /* SPDIF out */
> >  #define   ICH_PCM_SPDIF_69     0x80000000      /* s/pdif pcm on slots
> > 6&9 */
> >  #define   ICH_PCM_SPDIF_1011   0xc0000000      /* s/pdif pcm on slots
> > 10&11 */
> >  #define   ICH_PCM_20BIT                0x00400000      /* 20-bit
> > samples (ICH4) */
> > -#define   ICH_PCM_246_MASK     0x00300000      /* 6 channels (not all
> > chips) */
> > +#define   ICH_PCM_246_MASK     0x00300000      /* channels (not all
> > chips) */
> > +#define   ICH_PCM_8            0x00300000      /* 8 channels (not all
> > chips) */
> >  #define   ICH_PCM_6            0x00200000      /* 6 channels (not all
> > chips) */
> >  #define   ICH_PCM_4            0x00100000      /* 4 channels (not all
> > chips) */
> >  #define   ICH_PCM_2            0x00000000      /* 2 channels (stereo)
> > */
> > @@ -382,6 +383,7 @@ struct intel8x0 {
> >
> >        unsigned multi4: 1,
> >                 multi6: 1,
> > +                multi8 :1,
> >                 dra: 1,
> >                 smp20bit: 1;
> >        unsigned in_ac97_init: 1,
> > @@ -995,6 +997,8 @@ static void snd_intel8x0_setup_pcm_out(s
> >                        cnt |= ICH_PCM_4;
> >                else if (runtime->channels == 6)
> >                        cnt |= ICH_PCM_6;
> > +               else if (runtime->channels == 8)
> > +                       cnt |= ICH_PCM_8;
> >                if (chip->device_type == DEVICE_NFORCE) {
> >                        /* reset to 2ch once to keep the 6 channel data
> > in alignment,
> >                         * to start from Front Left always
> > @@ -1104,6 +1108,16 @@ static struct snd_pcm_hw_constraint_list
> >        .mask = 0,
> >  };
> >
> > +static unsigned int channels8[] = {
> > +       2, 4, 6, 8,
> > +};
> > +
> > +static struct snd_pcm_hw_constraint_list hw_constraints_channels8 = {
> > +       .count = ARRAY_SIZE(channels8),
> > +       .list = channels8,
> > +       .mask = 0,
> > +};
> > +
> >  static int snd_intel8x0_pcm_open(struct snd_pcm_substream *substream,
> > struct ichdev *ichdev)
> >  {
> >        struct intel8x0 *chip = snd_pcm_substream_chip(substream);
> > @@ -1134,7 +1148,12 @@ static int snd_intel8x0_playback_open(st
> >        if (err < 0)
> >                return err;
> >
> > -       if (chip->multi6) {
> > +       if (chip->multi8) {
> > +               runtime->hw.channels_max = 8;
> > +               snd_pcm_hw_constraint_list(runtime, 0,
> > +                                          SNDRV_PCM_HW_PARAM_CHANNELS,
> > +                                          &hw_constraints_channels8);
> > +       } else if (chip->multi6) {
> >                runtime->hw.channels_max = 6;
> >                snd_pcm_hw_constraint_list(runtime, 0,
> > SNDRV_PCM_HW_PARAM_CHANNELS,
> >                                           &hw_constraints_channels6);
> > @@ -2195,8 +2214,11 @@ static int __devinit snd_intel8x0_mixer(
> >        }
> >        if (pbus->pcms[0].r[0].slots & (1 << AC97_SLOT_PCM_SLEFT)) {
> >                chip->multi4 = 1;
> > -               if (pbus->pcms[0].r[0].slots & (1 << AC97_SLOT_LFE))
> > +               if (pbus->pcms[0].r[0].slots & (1 << AC97_SLOT_LFE)) {
> >                        chip->multi6 = 1;
> > +                       if (chip->ac97[0]->flags & AC97_HAS_8CH)
> > +                               chip->multi8 = 1;
> > +               }
> >        }
> >        if (pbus->pcms[0].r[1].rslots[0]) {
> >                chip->dra = 1;
> >
>
>
> It does not work 8 channel.  I found the problem though.  in line 2219 of
> the patched pci/intel8x0.c it checks for the flag AC97_HAS_8CH
> This flag is never set anywhere.  where would be the appropriate place?
>
>
>             if (chip->ac97[0]->flags & AC97_HAS_8CH)
>                 chip->multi8 = 1;
>
> Andrew Boettcher


I went ahead and  made a new patch, attached.  I put the flag in
patch_alc850() in pci/ac97/ac97_patch.c
The only issue I see now is the imbalanced volumes, nothing a .asoundrc
can't fix.  I wonder if the DAC volumes are maxed for the side and rear
DACs?  In the code it only maxes 2 of them.  I don't have a data sheet to
see how to max the others if they are maxed, or what the deal is.

Andrew Boettcher

------=_Part_3097_12176030.1203276671166
Content-Type: application/octet-stream; name=alc850_8ch_patch.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcrzsyqb0
Content-Disposition: attachment; filename=alc850_8ch_patch.patch

ZGlmZiAtciAwNTEwMDQxNTcyZDggaW5jbHVkZS9hYzk3X2NvZGVjLmgKLS0tIGEvaW5jbHVkZS9h
Yzk3X2NvZGVjLmgJU2F0IEZlYiAxNiAwOTo0NDo1NiAyMDA4ICswMTAwCisrKyBiL2luY2x1ZGUv
YWM5N19jb2RlYy5oCVN1biBGZWIgMTcgMTQ6MjY6MTEgMjAwOCAtMDUwMApAQCAtMzk3LDYgKzM5
Nyw3IEBACiAjZGVmaW5lIEFDOTdfSEFTX05PX1RPTkUJKDE8PDE2KSAvKiBubyBUb25lIHZvbHVt
ZSAqLwogI2RlZmluZSBBQzk3X0hBU19OT19TVERfUENNCSgxPDwxNykJLyogbm8gc3RhbmRhcmQg
QUM5NyBQQ00gdm9sdW1lIGFuZCBtdXRlICovCiAjZGVmaW5lIEFDOTdfSEFTX05PX0FVWAkJKDE8
PDE4KSAvKiBubyBzdGFuZGFyZCBBQzk3IEFVWCB2b2x1bWUgYW5kIG11dGUgKi8KKyNkZWZpbmUg
QUM5N19IQVNfOENICQkoMTw8MTkpIC8qIHN1cHBvcnRzIDgtY2hhbm5lbCBvdXRwdXQgKi8KIAog
LyogcmF0ZXMgaW5kZXhlcyAqLwogI2RlZmluZSBBQzk3X1JBVEVTX0ZST05UX0RBQwkwCmRpZmYg
LXIgMDUxMDA0MTU3MmQ4IHBjaS9hYzk3L2FjOTdfcGF0Y2guYwotLS0gYS9wY2kvYWM5Ny9hYzk3
X3BhdGNoLmMJU2F0IEZlYiAxNiAwOTo0NDo1NiAyMDA4ICswMTAwCisrKyBiL3BjaS9hYzk3L2Fj
OTdfcGF0Y2guYwlTdW4gRmViIDE3IDE0OjI2OjExIDIwMDggLTA1MDAKQEAgLTExNCwxMCArMTE0
LDkgQEAgc3RhdGljIGludCBhYzk3X3N1cnJvdW5kX2phY2tfbW9kZV9wdXQocwogCiBzdGF0aWMg
aW50IGFjOTdfY2hhbm5lbF9tb2RlX2luZm8oc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2ws
IHN0cnVjdCBzbmRfY3RsX2VsZW1faW5mbyAqdWluZm8pCiB7Ci0Jc3RhdGljIGNvbnN0IGNoYXIg
KnRleHRzW10gPSB7ICIyY2giLCAiNGNoIiwgIjZjaCIgfTsKLQlpZiAoa2NvbnRyb2wtPnByaXZh
dGVfdmFsdWUpCi0JCXJldHVybiBhYzk3X2VudW1fdGV4dF9pbmZvKGtjb250cm9sLCB1aW5mbywg
dGV4dHMsIDIpOyAvKiA0Y2ggb25seSAqLwotCXJldHVybiBhYzk3X2VudW1fdGV4dF9pbmZvKGtj
b250cm9sLCB1aW5mbywgdGV4dHMsIDMpOworCXN0YXRpYyBjb25zdCBjaGFyICp0ZXh0c1tdID0g
eyAiMmNoIiwgIjRjaCIsICI2Y2giLCAiOGNoIiB9OworCXJldHVybiBhYzk3X2VudW1fdGV4dF9p
bmZvKGtjb250cm9sLCB1aW5mbywgdGV4dHMsCisJCWtjb250cm9sLT5wcml2YXRlX3ZhbHVlKTsK
IH0KIAogc3RhdGljIGludCBhYzk3X2NoYW5uZWxfbW9kZV9nZXQoc3RydWN0IHNuZF9rY29udHJv
bCAqa2NvbnRyb2wsIHN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUgKnVjb250cm9sKQpAQCAtMTMz
LDEzICsxMzIsOCBAQCBzdGF0aWMgaW50IGFjOTdfY2hhbm5lbF9tb2RlX3B1dChzdHJ1Y3QgCiAJ
c3RydWN0IHNuZF9hYzk3ICphYzk3ID0gc25kX2tjb250cm9sX2NoaXAoa2NvbnRyb2wpOwogCXVu
c2lnbmVkIGNoYXIgbW9kZSA9IHVjb250cm9sLT52YWx1ZS5lbnVtZXJhdGVkLml0ZW1bMF07CiAK
LQlpZiAoa2NvbnRyb2wtPnByaXZhdGVfdmFsdWUpIHsKLQkJaWYgKG1vZGUgPj0gMikKLQkJCXJl
dHVybiAtRUlOVkFMOwotCX0gZWxzZSB7Ci0JCWlmIChtb2RlID49IDMpCi0JCQlyZXR1cm4gLUVJ
TlZBTDsKLQl9CisJaWYgKG1vZGUgPj0ga2NvbnRyb2wtPnByaXZhdGVfdmFsdWUpCisJCXJldHVy
biAtRUlOVkFMOwogCiAJaWYgKG1vZGUgIT0gYWM5Ny0+Y2hhbm5lbF9tb2RlKSB7CiAJCWFjOTct
PmNoYW5uZWxfbW9kZSA9IG1vZGU7CkBAIC0xNTgsNiArMTUyLDcgQEAgc3RhdGljIGludCBhYzk3
X2NoYW5uZWxfbW9kZV9wdXQoc3RydWN0IAogCQkuZ2V0ID0gYWM5N19zdXJyb3VuZF9qYWNrX21v
ZGVfZ2V0LCBcCiAJCS5wdXQgPSBhYzk3X3N1cnJvdW5kX2phY2tfbW9kZV9wdXQsIFwKIAl9Cisv
KiA2Y2ggKi8KICNkZWZpbmUgQUM5N19DSEFOTkVMX01PREVfQ1RMIFwKIAl7IFwKIAkJLmlmYWNl
CT0gU05EUlZfQ1RMX0VMRU1fSUZBQ0VfTUlYRVIsIFwKQEAgLTE2NSw3ICsxNjAsOSBAQCBzdGF0
aWMgaW50IGFjOTdfY2hhbm5lbF9tb2RlX3B1dChzdHJ1Y3QgCiAJCS5pbmZvID0gYWM5N19jaGFu
bmVsX21vZGVfaW5mbywgXAogCQkuZ2V0ID0gYWM5N19jaGFubmVsX21vZGVfZ2V0LCBcCiAJCS5w
dXQgPSBhYzk3X2NoYW5uZWxfbW9kZV9wdXQsIFwKKwkJLnByaXZhdGVfdmFsdWUgPSAzLCBcCiAJ
fQorLyogNGNoICovCiAjZGVmaW5lIEFDOTdfQ0hBTk5FTF9NT0RFXzRDSF9DVEwgXAogCXsgXAog
CQkuaWZhY2UJPSBTTkRSVl9DVExfRUxFTV9JRkFDRV9NSVhFUiwgXApAQCAtMTczLDcgKzE3MCwx
NyBAQCBzdGF0aWMgaW50IGFjOTdfY2hhbm5lbF9tb2RlX3B1dChzdHJ1Y3QgCiAJCS5pbmZvID0g
YWM5N19jaGFubmVsX21vZGVfaW5mbywgXAogCQkuZ2V0ID0gYWM5N19jaGFubmVsX21vZGVfZ2V0
LCBcCiAJCS5wdXQgPSBhYzk3X2NoYW5uZWxfbW9kZV9wdXQsIFwKLQkJLnByaXZhdGVfdmFsdWUg
PSAxLCBcCisJCS5wcml2YXRlX3ZhbHVlID0gMiwgXAorCX0KKy8qIDhjaCAqLworI2RlZmluZSBB
Qzk3X0NIQU5ORUxfTU9ERV84Q0hfQ1RMIFwKKwl7IFwKKwkJLmlmYWNlICA9IFNORFJWX0NUTF9F
TEVNX0lGQUNFX01JWEVSLCBcCisJCS5uYW1lICAgPSAiQ2hhbm5lbCBNb2RlIiwgXAorCQkuaW5m
byA9IGFjOTdfY2hhbm5lbF9tb2RlX2luZm8sIFwKKwkJLmdldCA9IGFjOTdfY2hhbm5lbF9tb2Rl
X2dldCwgXAorCQkucHV0ID0gYWM5N19jaGFubmVsX21vZGVfcHV0LCBcCisJCS5wcml2YXRlX3Zh
bHVlID0gNCwgXAogCX0KIAogc3RhdGljIGlubGluZSBpbnQgaXNfc3Vycm91bmRfb24oc3RydWN0
IHNuZF9hYzk3ICphYzk3KQpAQCAtMjEwLDYgKzIxNywxMCBAQCBzdGF0aWMgaW5saW5lIGludCBp
c19zaGFyZWRfbWljaW4oc3RydWN0CiAJcmV0dXJuICFhYzk3LT5pbmRlcF9zdXJyb3VuZCAmJiAh
aXNfY2xmZV9vbihhYzk3KTsKIH0KIAorc3RhdGljIGlubGluZSBpbnQgYWxjODUwX2lzX2F1eF9i
YWNrX3N1cnJvdW5kKHN0cnVjdCBzbmRfYWM5NyAqYWM5NykKK3sKKwlyZXR1cm4gaXNfc3Vycm91
bmRfb24oYWM5Nyk7Cit9CiAKIC8qIFRoZSBmb2xsb3dpbmcgc25kX2FjOTdfeW1mNzUzXy4uLiBp
dGVtcyBhZGRlZCBieSBEYXZpZCBTaHVzdCAoZHNodXN0QHNodXN0cmluZy5jb20pICovCiAvKiBN
b2RpZmllZCBmb3IgWU1GNzQzIGJ5IEtlaXRhIE1hZWhhcmEgPG1hZWhhcmFAZGViaWFuLm9yZz4g
Ki8KQEAgLTI4MTYsMTAgKzI4MjcsMTIgQEAgc3RhdGljIGludCBwYXRjaF9hbGM2NTUoc3RydWN0
IHNuZF9hYzk3IAogCiAjZGVmaW5lIEFDOTdfQUxDODUwX0pBQ0tfU0VMRUNUCTB4NzYKICNkZWZp
bmUgQUM5N19BTEM4NTBfTUlTQzEJMHg3YQorI2RlZmluZSBBQzk3X0FMQzg1MF9NVUxUSUNIICAg
IDB4NmEKIAogc3RhdGljIHZvaWQgYWxjODUwX3VwZGF0ZV9qYWNrcyhzdHJ1Y3Qgc25kX2FjOTcg
KmFjOTcpCiB7CiAJaW50IHNoYXJlZDsKKwlpbnQgYXV4X2lzX2JhY2tfc3Vycm91bmQ7CiAJCiAJ
Lyogc2hhcmVkIExpbmUtSW4gLyBTdXJyb3VuZCBPdXQgKi8KIAlzaGFyZWQgPSBpc19zaGFyZWRf
c3Vycm91dChhYzk3KTsKQEAgLTI4MzcsMTMgKzI4NTAsMTggQEAgc3RhdGljIHZvaWQgYWxjODUw
X3VwZGF0ZV9qYWNrcyhzdHJ1Y3QgcwogCS8qIE1JQy1JTiA9IDEsIENFTlRFUi1MRkUgPSA1ICov
CiAJc25kX2FjOTdfdXBkYXRlX2JpdHMoYWM5NywgQUM5N19BTEM4NTBfSkFDS19TRUxFQ1QsIDcg
PDwgNCwKIAkJCSAgICAgc2hhcmVkID8gKDU8PDQpIDogKDE8PDQpKTsKKworCWF1eF9pc19iYWNr
X3N1cnJvdW5kID0gYWxjODUwX2lzX2F1eF9iYWNrX3N1cnJvdW5kKGFjOTcpOworCS8qIEF1eCBp
cyBCYWNrIFN1cnJvdW5kICovCisJc25kX2FjOTdfdXBkYXRlX2JpdHMoYWM5NywgQUM5N19BTEM4
NTBfTVVMVElDSCwgMSA8PCAxMCwKKwkJCQkgYXV4X2lzX2JhY2tfc3Vycm91bmQgPyAoMTw8MTAp
IDogKDA8PDEwKSk7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBz
bmRfYWM5N19jb250cm9sc19hbGM4NTBbXSA9IHsKIAlBQzk3X1BBR0VfU0lOR0xFKCJEdXBsaWNh
dGUgRnJvbnQiLCBBQzk3X0FMQzY1MF9NVUxUSUNILCAwLCAxLCAwLCAwKSwKIAlBQzk3X1NJTkdM
RSgiTWljIEZyb250IElucHV0IFN3aXRjaCIsIEFDOTdfQUxDODUwX0pBQ0tfU0VMRUNULCAxNSwg
MSwgMSksCiAJQUM5N19TVVJST1VORF9KQUNLX01PREVfQ1RMLAotCUFDOTdfQ0hBTk5FTF9NT0RF
X0NUTCwKKwlBQzk3X0NIQU5ORUxfTU9ERV84Q0hfQ1RMLAogfTsKIAogc3RhdGljIGludCBwYXRj
aF9hbGM4NTBfc3BlY2lmaWMoc3RydWN0IHNuZF9hYzk3ICphYzk3KQpAQCAtMjg2OSw2ICsyODg3
LDggQEAgc3RhdGljIGludCBwYXRjaF9hbGM4NTAoc3RydWN0IHNuZF9hYzk3IAogCWFjOTctPmJ1
aWxkX29wcyA9ICZwYXRjaF9hbGM4NTBfb3BzOwogCiAJYWM5Ny0+c3BlYy5kZXZfZmxhZ3MgPSAw
OyAvKiBmb3IgSUVDOTU4IHBsYXliYWNrIHJvdXRlIC0gQUxDNjU1IGNvbXBhdGlibGUgKi8KKwkK
KwlhYzk3LT5mbGFncyB8PSBBQzk3X0hBU184Q0g7CiAKIAkvKiBhc3N1bWUgb25seSBwYWdlIDAg
Zm9yIHdyaXRpbmcgY2FjaGUgKi8KIAlzbmRfYWM5N191cGRhdGVfYml0cyhhYzk3LCBBQzk3X0lO
VF9QQUdJTkcsIEFDOTdfUEFHRV9NQVNLLCBBQzk3X1BBR0VfVkVORE9SKTsKQEAgLTI4NzgsNiAr
Mjg5OCw3IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWxjODUwKHN0cnVjdCBzbmRfYWM5NyAKIAkgICBz
cGRpZi1pbiBtb25pdG9yIG9mZiwgc3BkaWYtaW4gUENNIG9mZgogCSAgIGNlbnRlciBvbiBtaWMg
b2ZmLCBzdXJyb3VuZCBvbiBsaW5lLWluIG9mZgogCSAgIGR1cGxpY2F0ZSBmcm9udCBvZmYKKwkg
ICBOQiBkZWZhdWx0IGJpdCAxMD0wID0gQXV4IGlzIENhcHR1cmUsIG5vdCBCYWNrIFN1cnJvdW5k
CiAJKi8KIAlzbmRfYWM5N193cml0ZV9jYWNoZShhYzk3LCBBQzk3X0FMQzY1MF9NVUxUSUNILCAx
PDwxNSk7CiAJLyogU1VSUl9PVVQ6IG9uLCBTdXJyIDFrT2htOiBvbiwgU3VyciBBbXA6IG9mZiwg
RnJvbnQgMWtPaG06IG9mZgpkaWZmIC1yIDA1MTAwNDE1NzJkOCBwY2kvaW50ZWw4eDAuYwotLS0g
YS9wY2kvaW50ZWw4eDAuYwlTYXQgRmViIDE2IDA5OjQ0OjU2IDIwMDggKzAxMDAKKysrIGIvcGNp
L2ludGVsOHgwLmMJU3VuIEZlYiAxNyAxNDoyNjoxMSAyMDA4IC0wNTAwCkBAIC0xNTUsNyArMTU1
LDggQEAgREVGSU5FX1JFR1NFVChTUCwgMHg2MCk7CS8qIFNQRElGIG91dCAqLwogI2RlZmluZSAg
IElDSF9QQ01fU1BESUZfNjkJMHg4MDAwMDAwMAkvKiBzL3BkaWYgcGNtIG9uIHNsb3RzIDYmOSAq
LwogI2RlZmluZSAgIElDSF9QQ01fU1BESUZfMTAxMQkweGMwMDAwMDAwCS8qIHMvcGRpZiBwY20g
b24gc2xvdHMgMTAmMTEgKi8KICNkZWZpbmUgICBJQ0hfUENNXzIwQklUCQkweDAwNDAwMDAwCS8q
IDIwLWJpdCBzYW1wbGVzIChJQ0g0KSAqLwotI2RlZmluZSAgIElDSF9QQ01fMjQ2X01BU0sJMHgw
MDMwMDAwMAkvKiA2IGNoYW5uZWxzIChub3QgYWxsIGNoaXBzKSAqLworI2RlZmluZSAgIElDSF9Q
Q01fMjQ2X01BU0sJMHgwMDMwMDAwMAkvKiA2LzggY2hhbm5lbHMgKG5vdCBhbGwgY2hpcHMpICov
CisjZGVmaW5lICAgSUNIX1BDTV84CQkweDAwMzAwMDAwICAgICAgLyogOCBjaGFubmVscyAobm90
IGFsbCBjaGlwcykgKi8KICNkZWZpbmUgICBJQ0hfUENNXzYJCTB4MDAyMDAwMDAJLyogNiBjaGFu
bmVscyAobm90IGFsbCBjaGlwcykgKi8KICNkZWZpbmUgICBJQ0hfUENNXzQJCTB4MDAxMDAwMDAJ
LyogNCBjaGFubmVscyAobm90IGFsbCBjaGlwcykgKi8KICNkZWZpbmUgICBJQ0hfUENNXzIJCTB4
MDAwMDAwMDAJLyogMiBjaGFubmVscyAoc3RlcmVvKSAqLwpAQCAtMzgyLDYgKzM4Myw3IEBAIHN0
cnVjdCBpbnRlbDh4MCB7CiAKIAl1bnNpZ25lZCBtdWx0aTQ6IDEsCiAJCSBtdWx0aTY6IDEsCisJ
CSBtdWx0aTg6IDEsCiAJCSBkcmE6IDEsCiAJCSBzbXAyMGJpdDogMTsKIAl1bnNpZ25lZCBpbl9h
Yzk3X2luaXQ6IDEsCkBAIC05OTUsNiArOTk3LDggQEAgc3RhdGljIHZvaWQgc25kX2ludGVsOHgw
X3NldHVwX3BjbV9vdXQocwogCQkJY250IHw9IElDSF9QQ01fNDsKIAkJZWxzZSBpZiAocnVudGlt
ZS0+Y2hhbm5lbHMgPT0gNikKIAkJCWNudCB8PSBJQ0hfUENNXzY7CisJCWVsc2UgaWYgKHJ1bnRp
bWUtPmNoYW5uZWxzID09IDgpCisJCQljbnQgfD0gSUNIX1BDTV84OwogCQlpZiAoY2hpcC0+ZGV2
aWNlX3R5cGUgPT0gREVWSUNFX05GT1JDRSkgewogCQkJLyogcmVzZXQgdG8gMmNoIG9uY2UgdG8g
a2VlcCB0aGUgNiBjaGFubmVsIGRhdGEgaW4gYWxpZ25tZW50LAogCQkJICogdG8gc3RhcnQgZnJv
bSBGcm9udCBMZWZ0IGFsd2F5cwpAQCAtMTEwNCw2ICsxMTA4LDE2IEBAIHN0YXRpYyBzdHJ1Y3Qg
c25kX3BjbV9od19jb25zdHJhaW50X2xpc3QKIAkubWFzayA9IDAsCiB9OwogCitzdGF0aWMgdW5z
aWduZWQgaW50IGNoYW5uZWxzOFtdID0geworCTIsIDQsIDYsIDgsCit9OworCitzdGF0aWMgc3Ry
dWN0IHNuZF9wY21faHdfY29uc3RyYWludF9saXN0IGh3X2NvbnN0cmFpbnRzX2NoYW5uZWxzOCA9
IHsKKwkuY291bnQgPSBBUlJBWV9TSVpFKGNoYW5uZWxzOCksCisJLmxpc3QgPSBjaGFubmVsczgs
CisJLm1hc2sgPSAwLAorfTsKKwogc3RhdGljIGludCBzbmRfaW50ZWw4eDBfcGNtX29wZW4oc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIHN0cnVjdCBpY2hkZXYgKmljaGRldikK
IHsKIAlzdHJ1Y3QgaW50ZWw4eDAgKmNoaXAgPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0
cmVhbSk7CkBAIC0xMTM0LDcgKzExNDgsMTIgQEAgc3RhdGljIGludCBzbmRfaW50ZWw4eDBfcGxh
eWJhY2tfb3BlbihzdAogCWlmIChlcnIgPCAwKQogCQlyZXR1cm4gZXJyOwogCi0JaWYgKGNoaXAt
Pm11bHRpNikgeworCWlmIChjaGlwLT5tdWx0aTgpIHsKKwkJcnVudGltZS0+aHcuY2hhbm5lbHNf
bWF4ID0gODsKKwkJc25kX3BjbV9od19jb25zdHJhaW50X2xpc3QocnVudGltZSwgMCwKKwkJCQkJ
CVNORFJWX1BDTV9IV19QQVJBTV9DSEFOTkVMUywKKwkJCQkJCSZod19jb25zdHJhaW50c19jaGFu
bmVsczgpOworCX0gZWxzZSBpZiAoY2hpcC0+bXVsdGk2KSB7CiAJCXJ1bnRpbWUtPmh3LmNoYW5u
ZWxzX21heCA9IDY7CiAJCXNuZF9wY21faHdfY29uc3RyYWludF9saXN0KHJ1bnRpbWUsIDAsIFNO
RFJWX1BDTV9IV19QQVJBTV9DSEFOTkVMUywKIAkJCQkJICAgJmh3X2NvbnN0cmFpbnRzX2NoYW5u
ZWxzNik7CkBAIC0yMTk1LDggKzIyMTQsMTEgQEAgc3RhdGljIGludCBfX2RldmluaXQgc25kX2lu
dGVsOHgwX21peGVyKAogCX0KIAlpZiAocGJ1cy0+cGNtc1swXS5yWzBdLnNsb3RzICYgKDEgPDwg
QUM5N19TTE9UX1BDTV9TTEVGVCkpIHsKIAkJY2hpcC0+bXVsdGk0ID0gMTsKLQkJaWYgKHBidXMt
PnBjbXNbMF0uclswXS5zbG90cyAmICgxIDw8IEFDOTdfU0xPVF9MRkUpKQorCQlpZiAocGJ1cy0+
cGNtc1swXS5yWzBdLnNsb3RzICYgKDEgPDwgQUM5N19TTE9UX0xGRSkpIHsKIAkJCWNoaXAtPm11
bHRpNiA9IDE7CisJCQlpZiAoY2hpcC0+YWM5N1swXS0+ZmxhZ3MgJiBBQzk3X0hBU184Q0gpCisJ
CQkJY2hpcC0+bXVsdGk4ID0gMTsKKwkJfQogCX0KIAlpZiAocGJ1cy0+cGNtc1swXS5yWzFdLnJz
bG90c1swXSkgewogCQljaGlwLT5kcmEgPSAxOwo=
------=_Part_3097_12176030.1203276671166
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_3097_12176030.1203276671166--
