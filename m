Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D455AC35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:55:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB8520718
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZELyLys/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB8520718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A970782E;
	Mon, 17 Feb 2020 08:54:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A970782E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581926139;
	bh=QNz/oarOFN8YEEseqvEK38sdwy7NgTNs/+LbUQIIQIM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZELyLys/EAEu9rHg8wpHFU4vTn6wuynZQliBYgQLq2HzTAqFPNASguX7vb4sjKDVR
	 rhwCgV3wn8+kW+xthE4w8p9iOK9etL8GtVurW4FgytyFG4qKaknYBZvTO3sYjgZ4LI
	 KOmQkrRINw/os8OJVznM/0k4Yu14DbMyHLlo1heY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CC05F800C4;
	Mon, 17 Feb 2020 08:54:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 666D0F80172; Mon, 17 Feb 2020 08:54:47 +0100 (CET)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B82AF80096
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 08:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B82AF80096
Received: by mail-ed1-f65.google.com with SMTP id v28so19548519edw.12
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KR6FhQWcs0qNnsB7tbG/todYZCoVJm9lbx/mBjKE5fM=;
 b=kkQkgO+Lg9ppkMxoXh5kBpH6Ou0xLCGkR5ApZGigZvLITlyMaPFLxX2exypL1/i4BQ
 juCif9io4xX5lVL2Bu8gDdE6+d5CBIkkMnE8eFsZcf1Tg0q/gm48+EFEUPgz0K6OV2Oo
 hgD4J/76ZDnCCmlYjqFdNjn6Q6e/KGZVHQxjkvCJ55rj956462TFhnkbnszf3msz3IE9
 8qPux+GBuFI0cAMK/dx+iKpKLGpwaD2FThCQAkuRsAEzs8oaSkUJvvAo/3zbAMK5lVGk
 BVYsmmbwH2VqjhVWdeEU3QV/T5rgP4PCYqmn+CkUWKyeobRiUdEW9rxhvBoBZqjFKPOD
 8elQ==
X-Gm-Message-State: APjAAAUceK/J3GCd/f2RaZ5uTTaRZbLbMZYwYsMApoqCQilZtmSPcvL5
 NkglmkOiIsHiJnmyO4bHLTuncmlaTdg=
X-Google-Smtp-Source: APXvYqwV6v1/6ZCtBlgyjTyDGfU+FaEdoYEXPLBmOO/cTE6/73ZPzNsuore4tFnFERMdWXkmlkTVCQ==
X-Received: by 2002:a17:906:3cea:: with SMTP id
 d10mr13251817ejh.32.1581926082250; 
 Sun, 16 Feb 2020 23:54:42 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42])
 by smtp.gmail.com with ESMTPSA id ks2sm820841ejb.82.2020.02.16.23.54.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 23:54:42 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id y11so18377740wrt.6
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:54:41 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr20401029wrs.365.1581926081266; 
 Sun, 16 Feb 2020 23:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-17-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-17-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 15:54:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Af-gZxfrmCEg3Ltvy82Wb4M0RF17CR=jwazyTGy8L=g@mail.gmail.com>
Message-ID: <CAGb2v67Af-gZxfrmCEg3Ltvy82Wb4M0RF17CR=jwazyTGy8L=g@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [RFC PATCH 16/34] ASoC: sun8i-codec: Fix field bit
	number indentation
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
> Several fields have inconsistent indentation, presumably because it
> "looked correct" in the patch due to the additional character at the
> beginning of the line.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
