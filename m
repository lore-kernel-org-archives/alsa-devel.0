Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E6C7619B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:05:05 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF802070B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF802070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CC8C1723;
	Mon, 17 Feb 2020 08:04:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CC8C1723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581923103;
	bh=g/tH0fZsPNi10O/dzWjsRuZyE3qqFVOMslIVVN5Vvn8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqmpMhzFannS+lej9kEtcML2FAJJ7c+EwZhhW0WJQp2YWqa2oFoPCHH2t2UZh08jy
	 9ORvExS+axE8xjrTeDv5yD2MU+rq+HsVfSsxB6/MXYO3GG+Un3o22dEQHnIoeyGqQt
	 j+UbE7FTQXSr1kKvejU5HPtvc9jLJHWV0bELB+6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67D92F800C4;
	Mon, 17 Feb 2020 07:56:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C193AF8015E; Mon, 17 Feb 2020 07:56:33 +0100 (CET)
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C87CF80172
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 07:56:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C87CF80172
Received: by mail-ed1-f67.google.com with SMTP id v28so19392428edw.12
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 22:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/WHKaTGOgOAJM+VcnF+6HFOUNwxgDydG90xB7o+8lGE=;
 b=p9pgF/RsOi1EH1MNpUoFQcTRACCwWHkwvEO+VJSCWhJeSTX1pMxeveaUTso12ezECT
 xT1kO2c6QqoCmuaYSPd6iCY8w54WGN27v5CGQc+RpDokyqbta7yK5d635dQOJ8MbUX1T
 CZ3NBcyhyNPFKimOr3Y7SuqvMCNGwJ/4rHcQ+VgZAVOi0OLzrgjXWyex6nkHXl02aWul
 VaD/IlbVFEV4pbW2p+OB4MaUDxcO7Op7D3ai4c0LSZBNeBoQAlkn8bkdnpQLQTGhP7MM
 fdZKaSpdS44Lx44SuTQH19AYJWXv/7fSAyKdJA1yoE5BnaJ4QQ042t//EFjqaIJrvWul
 S5Qg==
X-Gm-Message-State: APjAAAW2my/sgQB3ue3Pn1OeLVd06i/g0Cx9uyiX1rl66V9rvXW+P/oj
 iSxHhjieKIb9XpRIQGMH/lslfcVFrlg=
X-Google-Smtp-Source: APXvYqzp2Fa6dSwTKVhdr50HrsrA8NsGOymgkeYBIzhfEZkCX2ilZ94yMT3AvjBRgpNzGi7GLib3ig==
X-Received: by 2002:a05:6402:797:: with SMTP id
 d23mr13239952edy.138.1581922586046; 
 Sun, 16 Feb 2020 22:56:26 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id 29sm793756ejb.4.2020.02.16.22.56.25
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 22:56:25 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id a9so17119302wmj.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 22:56:25 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr20086133wmd.122.1581922585072; 
 Sun, 16 Feb 2020 22:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-5-samuel@sholland.org>
 <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
 <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
In-Reply-To: <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 14:56:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xLO_=EFoa=vGh-HRY=nQuE0a+mv-nfveimK=pb=FjGQ@mail.gmail.com>
Message-ID: <CAGb2v64xLO_=EFoa=vGh-HRY=nQuE0a+mv-nfveimK=pb=FjGQ@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 4/8] ASoC: sun50i-codec-analog: Make
	headphone routes stereo
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Feb 17, 2020 at 11:57 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Hello,
>
> On 2/16/20 9:48 PM, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> This matches the hardware more accurately, and is necessary for
> >> including the (stereo) headphone mute switch in the DAPM graph.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
> >>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> >> index 17165f1ddb63..f98851067f97 100644
> >> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> >> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> >> @@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
> >>          */
> >>
> >>         SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
> >> -       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> >> +       SND_SOC_DAPM_MUX("Left Headphone Source",
> >>                          SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
> >> -       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
> >> +       SND_SOC_DAPM_MUX("Right Headphone Source",
> >
> > Please don't remove the widget suffix. The suffix was chosen to work with
> > alsa-lib's control parsing code. The term "Playback Route" is appropriate
> > because it is playback only, and it is a routing switch, not a source or
> > sink.
>
> Removing the suffix here doesn't affect the control name as seen by userspace,
> because the control is shared between multiple widgets (Left and Right).

You're right.

> > Also, what's wrong with just having a single "stereo" widget instead of
> > two "mono" widgets? I added stereo (2-channel) support to DAPM quite
> > some time ago. You just have to have two routes in and out.
>
> If you have any completed path through a widget, the widget is turned on. A
> stereo mute switch is logically two separate paths. So if I break one path by
> muting one channel, that lets me turn off everything before and after in the
> path (e.g. turning off the right side of the DAC lets DAPM turn off the right
> mixer, the right side of the output amp, even the right side of the AIF or the
> ADC if that was the only input. That only works if there are separate Left/Right
> widgets.

Looks like that's the case indeed. Might be worth revisiting the core DAPM code
later on if I can find the time.

Since the widgets and routes changed are internal to the codec, there won't be
any issue if we rework this stuff later on. So for now,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
