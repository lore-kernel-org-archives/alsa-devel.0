From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Mon, 31 Jan 2011 17:22:22 +0800
Message-ID: <AANLkTinxVgGAW0XMhV+rnB6S2-JqNijXZiMDE2utJfZd@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
	<AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
	<AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
	<AANLkTimiwTcnCnGECN8jpzY2VaMTmpcHBx-qmFDmwxSY@mail.gmail.com>
	<AANLkTi=14Q53BtcafboP=qz2-9AEcnnE3UD+HTwoGtbe@mail.gmail.com>
	<AANLkTimQ+evOVnG78UWPhCORKo2VvXyzVO8BhTrzSnVG@mail.gmail.com>
	<AANLkTim95ynONz5N27J4EOBR93ROsoWdZajovDCaWX9f@mail.gmail.com>
	<AANLkTinm3WYzzjVB-K6yVMeZm3+0hxsDGSb4+hQB4jLh@mail.gmail.com>
	<AANLkTikFtQpiAqfpgx-8BjJh=jcHwVW2OQccCU_23Yq7@mail.gmail.com>
	<AANLkTikb1R-8Y6nf+SjPrS8gMVUZ3VLSxEKyGcPq=dKa@mail.gmail.com>
	<AANLkTimEJkcTJoLuNXKGN+dfxctVS0SmPEDcFvLCNMwE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0D847243A7
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 10:22:23 +0100 (CET)
Received: by ewy19 with SMTP id 19so2188003ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 01:22:22 -0800 (PST)
In-Reply-To: <AANLkTimEJkcTJoLuNXKGN+dfxctVS0SmPEDcFvLCNMwE@mail.gmail.com>
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

2011/1/29 Mark Goldstein <goldstein.mark@gmail.com>

> On Sat, Jan 29, 2011 at 12:53 PM, Mark Goldstein
> <goldstein.mark@gmail.com> wrote:
> > On Sat, Jan 29, 2011 at 12:42 PM, Mark Goldstein
> > <goldstein.mark@gmail.com> wrote:
> >> On Sat, Jan 29, 2011 at 11:37 AM, Mark Goldstein
> >> <goldstein.mark@gmail.com> wrote:
> >>> On Fri, Jan 28, 2011 at 2:47 AM, Raymond Yau
> >>> <superquad.vortex2@gmail.com> wrote:
> >>>> 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
> >>>>
> >>>>> On Thu, Jan 27, 2011 at 11:09 AM, Raymond Yau
> >>>>> <superquad.vortex2@gmail.com> wrote:
> >>>>> > 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
> >>>>> >
> >>
> >>> Still trying to figure out why only Rear Mic works while Front Mic does
> not.
> >>
> >> Ok, for some reason Pin-ctls for Front Mic (0x1e) set to VREF Hi-Z.
> >> After I set it to VREF 50 using hda-analyser, Front Mic started
> >> working. Have to figure out why it is set to Hi-Z.
> >>
> >
> > static void via_auto_init_analog_input(struct hda_codec *codec)
> > {
> >        struct via_spec *spec = codec->spec;
> >        const struct auto_pin_cfg *cfg = &spec->autocfg;
> >        unsigned int ctl;
> >        int i;
> >
> >        for (i = 0; i < cfg->num_inputs; i++) {
> >                hda_nid_t nid = cfg->inputs[i].pin;
> >                if (spec->smart51_enabled && is_smart51_pins(spec, nid))
> >                        ctl = PIN_OUT;
> >                else if (i == AUTO_PIN_MIC)
> >                          ^^^^^^^^^^^^^^^^^^^^^^^^^
> >                        ctl = PIN_VREF50;
> >                else
> >                        ctl = PIN_IN;
> >                snd_hda_codec_write(codec, nid, 0,
> >                                    AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
> >        }
> > }
> >
> > Should it probably be
> > else if (cfg->input[i].type == AUTO_PIN_MIC) ?
>
> OK, now it works for me.
> So totally there were 3 changes:
> 1) setting of PIN control for Mics
> 2) shifting the ids in pin_idxs one position to the right
> 3) using specialized version of vt_auto_create_analog_input_ctls, that
> passes idx - 1 to snd_hda_add_imux_item.
>
> Well, instead of last two changes it was probably possible to use only
> 3rd, but instead of passing idx - 1 to snd_hda_add_imux_item pass idx
> + 1 to via_new_analog_input.
>
> Of course it should be done in more common way, since not only VT1708S
> used different indexes for via_new_analog_input and
> snd_hda_add_imux_item.
>
>
The reason is assign "Stereo Mix"  as first element of input source ,

In snd_hda_input_mux_put() , imux->items[].index is the position of the pin
in the connection list

snd_hda_codec_write_cache(codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
                  imux->items[idx].index);

if you look at print_codec_info() in hda_proc.c

you can get the connection list of imux using snd_hda_get_connections()

    conn_len = snd_hda_get_connections(codec, nid, conn,
                               HDA_MAX_CONNECTIONS);
