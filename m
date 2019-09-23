Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F1DC3A5A6
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:17:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1919520882
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KjxxPsi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1919520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E44C91612;
	Mon, 23 Sep 2019 11:16:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E44C91612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569230262;
	bh=YDVKyBONhE5ij7EP9lJjfjGLddjUa1zG7ymgsJKMz0o=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjxxPsi1L7fvjks0O+dkscAGHgQYHjgIr22FxeGiI6jjYa8rnDFF04Ee/DyVEWWPV
	 A8KwiHLBTeUwO7kOPYwFOW+U8jEnc+u0/xwqdX5bf4SUofM+PSH0inTYMFWINDwB6A
	 2Kau2r93JqduGmypDs2ilgSBL3X10p1jiTNeImDg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B1A9F8031A;
	Mon, 23 Sep 2019 11:16:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAA10F8044C; Mon, 23 Sep 2019 11:16:49 +0200 (CEST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8222DF80307
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 11:16:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8222DF80307
Received: by mail-wr1-f68.google.com with SMTP id o18so13001037wrv.13
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 02:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eUZTQEw4J0qVIA2fDKv3wKt2hX7/DxEBMom/U6HeJCA=;
 b=j5vxPEMt+fr17SmZaJd/oYCkQPyafvtTDwZOm1aNUgl49VAJLaMFqIMQ+TWjLSvWDa
 Y2ZPkcfskIy8ogywZKoZ7ofUsOHcXTBe49mqLHCjgjLfAFA0gbE6T1WUAVGNUNnm9MTi
 E/8PsKtdbgSdYYQkJ6nlNb/n/b9X3RS+J3tGUPBEY1hladGY4xj9r1anFvbhXNKrXuGV
 xkJOEWCzpeEdcs/jKjSiAg748plaXbOW2sZfj4x2QcdgtR52DO7bkl1EJvHq1CEFBOTz
 NtPOHbGpReoDC7IdiOzCR0QT70NznToUmFCRcBWsA7hYQR7GTmejUE0HJbOiM+USz8i/
 rYCA==
X-Gm-Message-State: APjAAAVq85xkVRXliV3JiHKGobRszgWdPpyJmcq3rkWsmrz3SETwP07G
 TRw2IHmn40dc/Gf0Mq42Ceg=
X-Google-Smtp-Source: APXvYqy/K8AUiDccc2Dhtcu7DPXS49zP6PhLDw4ZT1thoebNST6dXSKJcAdR933mVGIR+GOsw17Now==
X-Received: by 2002:adf:e9ce:: with SMTP id l14mr13891459wrn.264.1569230206656; 
 Mon, 23 Sep 2019 02:16:46 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id y19sm9238322wmi.13.2019.09.23.02.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 02:16:25 -0700 (PDT)
Date: Mon, 23 Sep 2019 11:16:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20190923091622.GC4577@pi3>
References: <20190920130218.32690-1-s.nawrocki@samsung.com>
 <CGME20190920130321eucas1p2efe85adb3df4c546a7d81326b4c75873@eucas1p2.samsung.com>
 <20190920130218.32690-8-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920130218.32690-8-s.nawrocki@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, sbkim73@samsung.com, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v2 07/10] ASoC: samsung: arndale: Add
 support for WM1811 CODEC
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

On Fri, Sep 20, 2019 at 03:02:16PM +0200, Sylwester Nawrocki wrote:
> The Arndale boards come with different types of the audio daughter
> board.  In order to support the WM1811 one we add new definition of
> an ASoC card which will be registered when the driver matches on
> "samsung,arndale-wm1811" compatible.  There is no runtime detection of
> the audio daughter board type at the moment, compatible string of the
> audio card needs to be adjusted in DT, e.g. by the bootloader,
> depending on actual audio board (CODEC) used.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - removed unneeded __maybe_used attribute
> ---
>  sound/soc/samsung/Kconfig          |  2 +
>  sound/soc/samsung/arndale_rt5631.c | 85 +++++++++++++++++++++++++-----
>  2 files changed, 74 insertions(+), 13 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
