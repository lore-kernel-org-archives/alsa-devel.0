From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Mon, 21 Feb 2011 11:01:47 +0800
Message-ID: <AANLkTikAqHaDRuFn6dXUrJ7ngmVoHLg8aHKU=LCosHOW@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f50.google.com (mail-ew0-f50.google.com
	[209.85.215.50]) by alsa0.perex.cz (Postfix) with ESMTP id F2D0A245F8
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 04:01:52 +0100 (CET)
Received: by ewy26 with SMTP id 26so828007ewy.9
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 19:01:49 -0800 (PST)
In-Reply-To: <AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
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

2011/2/20 Mark Goldstein <goldstein.mark@gmail.com>

>
> I think the Mic part might be the same problem I had. I found out that
> the following code:
>
> static void via_auto_init_analog_input(struct hda_codec *codec)
> {
>       struct via_spec *spec = codec->spec;
>       const struct auto_pin_cfg *cfg = &spec->autocfg;
>       unsigned int ctl;
>       int i;
>
>       for (i = 0; i < cfg->num_inputs; i++) {
>               hda_nid_t nid = cfg->inputs[i].pin;
>               if (spec->smart51_enabled && is_smart51_pins(spec, nid))
>                       ctl = PIN_OUT;
>               else if (i == AUTO_PIN_MIC)
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^
>                       ctl = PIN_VREF50;
>               else
>                       ctl = PIN_IN;
>               snd_hda_codec_write(codec, nid, 0,
>                                   AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
>       }
> }
>
> configures correctly only the first MIC (in my case it was Rear MIC).
> Front Mic pin was configured as HiZ.
> Changing the underlined condition to
>
> else if (cfg->input[i].type == AUTO_PIN_MIC)
>
> resolved the issue for me. (In alsa driver 1.0.23 this code was
> different, it checked that i <= FRONT_MIC index).
>

This may fix your vt1708s smart51 since only rear mic and line in are
retasked


static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin)
{
    const struct auto_pin_cfg *cfg = &spec->autocfg;
    int i;
        if (cfg->line_outs != 1)
        return 0;
    for (i = 0; i < cfg->num_inputs; i++) {
        if (pin == cfg->inputs[i].pin) {
                        switch(cfg->inputs[i].type){
            case AUTO_PIN_LINE_IN:
                    return 1;
                        case AUTO_PIN_MIC:
                                if (
strncmp(hda_get_autocfg_input_label(spec->codec,cfg,i),"Rear Mic",8) == 0 )
                           return 1;
                else
                    return 0;
            default:
                return 0;
                        }
                }
    }
    return 0;
}

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=1564b2878f5cf160f60af99d4dbca1dd7809ee8a

Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
While off, they act as "line out" / "line in" / "mic in".
While on, they acts as "line out" / "back left/right" / "center/lfe".
