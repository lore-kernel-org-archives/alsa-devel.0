From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multiple sound problems with ALC888 (1025:013f) on
 Acer Aspire 5930
Date: Sat, 2 Apr 2011 10:12:38 +0800
Message-ID: <AANLkTi=QxeQ35=WYem2wHyYv-+xU_EJ2+KsxVzngU_06@mail.gmail.com>
References: <4D92EFB2.7090209@yahoo.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E7691037F2
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 04:12:39 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3287286fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2011 19:12:38 -0700 (PDT)
In-Reply-To: <4D92EFB2.7090209@yahoo.gr>
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

2011/3/30 Elisavet Vorgia <elisavet_vorgia@yahoo.gr>

> Hi All,
>
> I have sound issues with my laptop, I cannot get 5.1 sound and jack
> sensing does not work (but works on Windows 7; dual-boot).
>
> I have an Acer Aspire 5930 (chipset: ALC888) running Ubuntu 10.10 (64-bit).
> I have tested with Alsa 1.0.23 (which comes with Ubuntu 10.10) and also
> compiled Alsa 1.0.24.
> Here is the Alsa-info with Alsa 1.0.24 (latest), and "model=auto",
> http://www.alsa-project.org/db/?f=2cbab ... 31dc6a7d70
> <
> http://www.alsa-project.org/db/?f=2cbab995516f4b56a7faecf537f61f31dc6a7d70
> >
>
> Here is alsa-info with "model=acer-aspire-6530g",
> http://www.alsa-project.org/db/?f=40992 ... 17160cde64
> <
> http://www.alsa-project.org/db/?f=409923a3d8f042804e61f21c7b8ae917160cde64
> >
>
>
how many audio jacks do your acer 5930 have ?

As the model acer-aspire-6530g use alc883_3ST_2ch)modes , this model won't
support 5.1

if your 5930 support 5.1 with 3 audio jacks, you will need to find a model
which has 3st_6ch_modes

    [ALC888_ACER_ASPIRE_6530G] = {
        .mixers = { alc888_acer_aspire_6530_mixer },
        .init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
                alc888_acer_aspire_6530g_verbs },
        .num_dacs = ARRAY_SIZE(alc883_dac_nids),
        .dac_nids = alc883_dac_nids,
        .num_adc_nids = ARRAY_SIZE(alc883_adc_nids_rev),
        .adc_nids = alc883_adc_nids_rev,
        .capsrc_nids = alc883_capsrc_nids_rev,
        .dig_out_nid = ALC883_DIGOUT_NID,
        .num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
        .channel_mode = alc883_3ST_2ch_modes,
        .num_mux_defs =
            ARRAY_SIZE(alc888_2_capture_sources),
        .input_mux = alc888_acer_aspire_6530_sources,
        .unsol_event = alc_automute_amp_unsol_event,
        .setup = alc888_acer_aspire_6530g_setup,
        .init_hook = alc_automute_amp,
    },
