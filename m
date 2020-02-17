Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDFCC7619B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:24:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4C620725
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MvyTn69N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4C620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F80C1676;
	Mon, 17 Feb 2020 09:23:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F80C1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581927880;
	bh=FmGN78bD/6I501G/vyQdTjs+jry35yMYlWWHIxbK3MA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvyTn69N8EFvNHNwNZ33feIUKQuBtYHfbi3d5osDalE1nMeqOjjlncaF1KLrnxbBs
	 snCkbc0h1czJOc+HFMlOX4K8GlUpVHXs5R6don+ObeLymQ6TSUhH/oOfxNVY6wgeZX
	 2La1aBed1hA2Aewfkhke9iXIyP+WBnhNNZaFLRNw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C02F0F80172;
	Mon, 17 Feb 2020 09:23:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 107B1F801F5; Mon, 17 Feb 2020 09:23:48 +0100 (CET)
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBF64F80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 09:23:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBF64F80096
Received: by mail-ed1-f67.google.com with SMTP id j17so19680943edp.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 00:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RCvgYdsJcfvOF7DNGv6F0fWsfl3RWpjn9MSCG6l5nng=;
 b=SpXhbTKJGEizln8p5uoEkFXJ1nH+ryB4EKI2wgiUTOX5STMnbJSY9HO6fKI1jWotNc
 gJp3BV36dW85b0h5Jnxjy1hz5gwz1o8J4zhgemq9nnK1IbaeV3zR/xOHk9wLWUytbHsV
 o37qSmpbLqMKY7nxhQvv4OTvL8FFMxgMs0Z38qeP5MVIH3pHL8885Dl6FJ1WIyZO81eA
 zvmD8mXSsX3i50RySM5A/ucxtlRwmFSLYt87mUQCp+f5usdzd1fkayqIkXe8a4zNcxnl
 hPYWytM20/2Kh0gVe0hKG8tai1qtrv/KMFHIWYKjJmC6l3qzYcJ2ua9dXixOBDjmmfGt
 XkpQ==
X-Gm-Message-State: APjAAAV9hEruAfxbiW74SyGK8x8h0mouST2kIS9cWJYByfLlOuiuPrJA
 v/NNTkNFEnWm0ABe0TNXbH8byzAST+4=
X-Google-Smtp-Source: APXvYqxRqBvPXsjhZ+KLnvSVPvSvRhcnqhgdhgUVsJK0oEa4GWz2eJ+wjO3QtfgmNzZjShFuC7eHig==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr12961290edx.166.1581927823611; 
 Mon, 17 Feb 2020 00:23:43 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id w18sm851842eja.57.2020.02.17.00.23.42
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 00:23:43 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id w15so18492961wru.4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 00:23:42 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr21282613wru.64.1581927822372; 
 Mon, 17 Feb 2020 00:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-7-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-7-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 16:23:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v65pow6ufaz=6f8rWMXkmknLL2toYgUj-wM9sqns9Xy-ow@mail.gmail.com>
Message-ID: <CAGb2v65pow6ufaz=6f8rWMXkmknLL2toYgUj-wM9sqns9Xy-ow@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, stable@kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [RFC PATCH 06/34] ASoC: sun8i-codec: Fix setting
	DAI data format
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

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Use the correct mask for this two-bit field. This fixes setting the DAI
> data format to RIGHT_J or DSP_A.
>
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
