Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29C5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:00:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA082067D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C9kM7XYd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLwDDYuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA082067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AB2E167F;
	Thu, 23 Jul 2020 21:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AB2E167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595534436;
	bh=zP3Fc33PffOt8kcMr6zvgvJDbsiHE4yEx/MJxaBNdNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C9kM7XYd58GKL2W5/Ze3m+V8QR3mTiAQOzyvJvj4R4fLLpmtJ57sqUEiEM0NEkOd8
	 C+0WHDjpJe1TMZj3+s9tAyJxhVjcYHqHscjGYOrL5vgdiWDR5l6c2ZVJOTf5g4HmU7
	 Gi3DNoQyjIAU3Z6YFbBdEqHb8VfPg8toopGSLBL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A2E9F8020D;
	Thu, 23 Jul 2020 21:59:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37B45F80212; Thu, 23 Jul 2020 21:59:44 +0200 (CEST)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F7A0F80090
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 21:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F7A0F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oLwDDYuF"
Received: by mail-lf1-x141.google.com with SMTP id y18so3935586lfh.11
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zP3Fc33PffOt8kcMr6zvgvJDbsiHE4yEx/MJxaBNdNY=;
 b=oLwDDYuF2y8WRlgjUVI1jCJ5eaqIXOFo4k5e9OcFMSYwQCLW9/EpJGOc7M2Hfzf9Et
 X1Jd9Wt1COUcK9QPMyWTfDjvmiX9MlaOJ+6CJrDohPMk15yBB4LC+i7FqbVjBkAnqY3D
 QQuY9Mfl6Yq2cqFCUAk416lYl6Fzrro8dZFipGndkU8v6VJBRUbpyno1KsgIhahWFbsk
 748JdnCVcSGGeMjxHbRS+PT6rO7cVSJNDsh5uvSetRAks15naLfAqm2UF1VljFeOPzUZ
 2LAZay7gGHpxPP9x1gkL55raoEpUmz9+G5NZkEHVuJM0Ee+Q8V29fz40xggfY0banfYq
 GHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zP3Fc33PffOt8kcMr6zvgvJDbsiHE4yEx/MJxaBNdNY=;
 b=blgJa4olvkffcjqp7j1e/bzyX2wF3w5h01L67XR4Pv2/+oz90okPPReBtJ3zE1Bkiq
 c1D+T+nvX73a3mqn5+CxAMAnb+6fSk5jafn1rX97O7QNaye4fifsjeexGG4OC5am7re0
 ro6127AjlTV1olpD1WKMqyWNl4QHviFBDEXW7J+wAEXrnY7gvFhMp0Uq0lRJb0AdJsIL
 xbkP0QbMLsRrf+d+c42bJGYie1RR3Fax39Zy5hqtqVdnmXBjPzbDHiRYMkiuj7wilxix
 XDPHDh4fKEaFvhihcG4NnN2wBxPWkcicU3xPrfeMkxo5DbnwLzeanPH7FZFHof6+1R2Z
 sMGQ==
X-Gm-Message-State: AOAM530pT0tlnTsMsCIOV9iwhSPLnQcN4Fo6W6Br2E7TifmmolbBaY2o
 tsLDyhM9jm/xKquIJzSMCtiaPLimIh8/uOWS8LU=
X-Google-Smtp-Source: ABdhPJx0j/0j7rtnkMI9ke3ZTXABaFXfQgw9C5W6OuPl+ZebLuH8U7u1IkbNptWTWBe1MY5VAkCglNu2JOD4wNpIb8U=
X-Received: by 2002:a19:c3d0:: with SMTP id t199mr3090614lff.56.1595534376214; 
 Thu, 23 Jul 2020 12:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200717135959.19212-1-festevam@gmail.com>
 <20200723092140.GB10899@ediswmail.ad.cirrus.com>
In-Reply-To: <20200723092140.GB10899@ediswmail.ad.cirrus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2020 16:59:24 -0300
Message-ID: <CAOMZO5DvR1CNwR2fG_e48Kv9FPdXj-UrboPpAbA9tTakOdpw6A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Do not access WM8962_GPIO_BASE
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Charles,

On Thu, Jul 23, 2020 at 6:21 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Ah ok I think I can see what is going on here, you get an EBUSY
> if the regmap is in cache only and you try to read a register
> which isn't in the cache. Is that what you are seeing?

After adding some debug info I got:

************ register is 512
wm8962 0-001a: ASoC: error at soc_component_read_no_lock on wm8962.0-001a: -16

************ register is 515
wm8962 0-001a: ASoC: error at soc_component_read_no_lock on wm8962.0-001a: -16

Both register 512 and 515 do not exist as per the WM8962 datasheet, so
the driver should not try to access them, right?

This patch avoids reading from these unexisting registers, which makes
sense IMHO.

Do you have any other suggestions to avoid these errors?

Thanks
