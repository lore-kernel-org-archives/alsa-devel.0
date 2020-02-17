Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B1C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:29:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D41D20659
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Alg4H5eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D41D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05F6F829;
	Mon, 17 Feb 2020 04:28:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05F6F829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581910162;
	bh=k3scjiPI9X3mZ3W7rEksvfq3n0aYlX9Ntu3gga5uSk8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Alg4H5eTWcGHhlYXC2WZ7Y558jH5vvJGxJrNDTUiAs4iM5CJ2/vjK7xnk9PtiVYg2
	 Z9TxXZcNL+lsT40As2/HyyPMqcoaMm/c1yQ6ftfNomasztA10El/dK8jN0zapzAlyI
	 tb7bdaBmW8dsR0+3gyD1IrPBdgwA4bHQdO9YOB+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FF6FF80096;
	Mon, 17 Feb 2020 04:28:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D13B8F80172; Mon, 17 Feb 2020 04:28:28 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C34DF800B6
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 04:28:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C34DF800B6
Received: by mail-ed1-f68.google.com with SMTP id r21so19003235edq.0
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Vf+s0xiHFIhPppg6jnzm8oEYQMOnPl6UhM4IxCWOkI=;
 b=PQ/msz70icM1DSyhgJ66wTIJptFB5Tnvjk/RXa3KoW7vtjOyUV5yZ2DENWNRLI07M1
 Rvr/PshSOcAHozm4zDTYqU4QtymKlyPVzdiHlaPwGLwak9uKBxQYoioGe6TT50j23SoM
 ee4dWEj5ZTVD94o1CJXSKQIbQJgFweV89Yocirba6Kp3d7cYc9Wil8bHBqxgdMp+EwaV
 huc2FxvzgJGjHTRplJaqGRL3QEzWiDy9eJHJ3cbhg9r/ZC9TnTsrDMtWLb+WCG4ReNIu
 8pjxkYdMwKORMwEZgU47k5lbSBc4FPK+cHXC81RckRsu3JiK+64Vavv8BcK+HzW16+K+
 iZHA==
X-Gm-Message-State: APjAAAVHSfK78Ve2re//OHDjMi/Xmi4N2wrr/SJ4D1Z2z+2GYO4eo9iE
 ruALMJbj8BKi/OhiyolDJOkuo5ft9PQ=
X-Google-Smtp-Source: APXvYqxijx6unsr2kojVko02TDOhJzcCdA9TaJoDy/Wtfr11MMiapMFbmq2B5p4wz0bsVo5Q/DR1zA==
X-Received: by 2002:a17:906:4a97:: with SMTP id
 x23mr12844149eju.66.1581910103536; 
 Sun, 16 Feb 2020 19:28:23 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id x6sm793271ejw.84.2020.02.16.19.28.21
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 19:28:21 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id a6so16821305wme.2
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 19:28:21 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr20681900wmg.16.1581910101671; 
 Sun, 16 Feb 2020 19:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-2-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-2-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 11:28:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67PeKSpzRRQNvUy8PXtLMtv1=PZk99mmGgaL6nwMYMa+w@mail.gmail.com>
Message-ID: <CAGb2v67PeKSpzRRQNvUy8PXtLMtv1=PZk99mmGgaL6nwMYMa+w@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 1/8] ASoC: sun50i-codec-analog: Fix
 duplicate use of ADC enable bits
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

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> The same enable bits are currently used for both the "Left/Right ADC"
> and the "Left/Right ADC Mixer" widgets. This happens to work in practice
> because the widgets are always enabled/disabled at the same time, but
> each register bit should only be associated with a single widget.
>
> To keep symmetry with the DAC widgets, keep the bits on the ADC widgets,
> and remove them from the ADC Mixer widgets.
>
> Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
