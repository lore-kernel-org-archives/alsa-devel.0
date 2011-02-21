From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Mon, 21 Feb 2011 16:26:37 +0800
Message-ID: <AANLkTi=5gCWBazLG-A1ojP-uNnqk1D=HAs1_VVCfmZmg@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<AANLkTikAqHaDRuFn6dXUrJ7ngmVoHLg8aHKU=LCosHOW@mail.gmail.com>
	<AANLkTimxPgGE1EPyyMCtQ4s=iW1dSJudONVY4-FPUakJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f49.google.com (mail-ew0-f49.google.com
	[209.85.215.49]) by alsa0.perex.cz (Postfix) with ESMTP id 208B024133
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 09:26:38 +0100 (CET)
Received: by ewy23 with SMTP id 23so383602ewy.8
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 00:26:37 -0800 (PST)
In-Reply-To: <AANLkTimxPgGE1EPyyMCtQ4s=iW1dSJudONVY4-FPUakJ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/21 Mark Goldstein <goldstein.mark@gmail.com>

> On Mon, Feb 21, 2011 at 5:01 AM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> > 2011/2/20 Mark Goldstein <goldstein.mark@gmail.com>
> >
> >>
> >> I think the Mic part might be the same problem I had. I found out that
> >> the following code:
> >>
> >> static void via_auto_init_analog_input(struct hda_codec *codec)
> >> {
> >>       struct via_spec *spec = codec->spec;
> >>       const struct auto_pin_cfg *cfg = &spec->autocfg;
> >>       unsigned int ctl;
> >>       int i;
> >>
> >>       for (i = 0; i < cfg->num_inputs; i++) {
> >>               hda_nid_t nid = cfg->inputs[i].pin;
> >>               if (spec->smart51_enabled && is_smart51_pins(spec, nid))
> >>                       ctl = PIN_OUT;
> >>               else if (i == AUTO_PIN_MIC)
> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^^
> >>                       ctl = PIN_VREF50;
> >>               else
> >>                       ctl = PIN_IN;
> >>               snd_hda_codec_write(codec, nid, 0,
> >>                                   AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
> >>       }
> >> }
> >>
> >> configures correctly only the first MIC (in my case it was Rear MIC).
> >> Front Mic pin was configured as HiZ.
> >> Changing the underlined condition to
> >>
> >> else if (cfg->input[i].type == AUTO_PIN_MIC)
> >>
> >> resolved the issue for me. (In alsa driver 1.0.23 this code was
> >> different, it checked that i <= FRONT_MIC index).
> >>
> >
> > This may fix your vt1708s smart51 since only rear mic and line in are
> > retasked
> >
> >
> > static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin)
> > {
> >    const struct auto_pin_cfg *cfg = &spec->autocfg;
> >    int i;
> >        if (cfg->line_outs != 1)
> >        return 0;
> >    for (i = 0; i < cfg->num_inputs; i++) {
> >        if (pin == cfg->inputs[i].pin) {
> >                        switch(cfg->inputs[i].type){
> >            case AUTO_PIN_LINE_IN:
> >                    return 1;
> >                        case AUTO_PIN_MIC:
> >                                if (
> > strncmp(hda_get_autocfg_input_label(spec->codec,cfg,i),"Rear Mic",8) == 0
> )
> >                           return 1;
> >                else
> >                    return 0;
> >            default:
> >                return 0;
> >                        }
> >                }
> >    }
> >    return 0;
> > }
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=1564b2878f5cf160f60af99d4dbca1dd7809ee8a
> >
> > Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
> > While off, they act as "line out" / "line in" / "mic in".
> > While on, they acts as "line out" / "back left/right" / "center/lfe".
>
> Hi Raymond,
> I've always had spart5.1 disabled and still Front Mic PIN has been
> configured as High Impedance and did not work until I changed the code
> as I described.
>
> What I see in this function (is_smart51_pins) is that pin type is
> checked the same way I tried, that is cfg->inputs[i].type is compared
> to AUTO_PIN_MIC and not "i" itself as in the code of
> via_auto_init_analog_input.
>
> So should the via_auto_init_analog_input be fixed? What do you think?
>
> BTW for some reason I can't see the link included in your mail, I'm
> getting: 403 Forbidden - No such project
>
> Thank you & regards,
> --
> Mark Goldstein
>

author    Lydia Wang <lydiawang@viatech.com.cn>
Sat, 10 Oct 2009 11:07:52 +0000 (19:07 +0800)
committer    Takashi Iwai <tiwai@suse.de>
     Sun, 11 Oct 2009 15:56:53 +0000 (17:56 +0200)
commit    1564b2878f5cf160f60af99d4dbca1dd7809ee8a
tree    2224b34919c247b6bfacce32a81a0953036fc0c4
parent    cdc1784d49258198df600fbc1d37c07d7eee5ed6


http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1564b2878f5cf160f60af99d4dbca1dd7809ee8a;hp=cdc1784d49258198df600fbc1d37c07d7eee5ed6

in the patch , just only front mic

+               if (i == AUTO_PIN_FRONT_MIC) {
+                       if (spec->codec_type == VT1708S) {
+                               /* input = index 1 (AOW3) */
+                               snd_hda_codec_write(
+                                       codec, nid, 0,
+                                       AC_VERB_SET_CONNECT_SEL, 1);
+                               snd_hda_codec_amp_stereo(
+                                       codec, nid, HDA_OUTPUT,
+                                       0, HDA_AMP_MUTE, HDA_AMP_UNMUTE);
+                       }
+               }

but now become any mic

1406                 if (cfg->inputs[i].type == AUTO_PIN_MIC) {
1407                         if (spec->codec_type == VT1708S
1408                             || spec->codec_type == VT1716S) {
1409                                 /* input = index 1 (AOW3) */
1410                                 snd_hda_codec_write(
1411                                         codec, nid, 0,
1412                                         AC_VERB_SET_CONNECT_SEL, 1);
1413                                 snd_hda_codec_amp_stereo(
1414                                         codec, nid, HDA_OUTPUT,
1415                                         0, HDA_AMP_MUTE,
HDA_AMP_UNMUTE);
1416                         }
1417                 }
1418         }
