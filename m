Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38338C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:26:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B770020736
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e9Csl8on";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o616xSUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B770020736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2452916B0;
	Thu, 23 Apr 2020 09:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2452916B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587626763;
	bh=ZBYbrHc9gCXcCuzO2lECvk3wELc9S8J5/i/PXerFdr0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e9Csl8on4XOr42ncpESVwQrLBAOBM2G2wVt2coxdF9wtqxx4sX9MnjO5VP5I7/2Qr
	 ggVR95tv9Zd1eGKzFbSJsU0FYA15Y4tw7RYNy+KeBPNBYs9t7iPyJD90Phz9rss/77
	 k+rXcktS/jcHKkVFkI8m6mkMadrAqmd8M48nWg/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8A35F80121;
	Thu, 23 Apr 2020 09:25:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE363F801D9; Wed, 22 Apr 2020 20:55:36 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32485F800F2
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 20:55:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32485F800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="o616xSUI"
Received: by mail-wm1-x341.google.com with SMTP id u127so3729146wmg.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hkalyHJqg5ugOHKHuOFHI5AizfqrqyG86NTtO7Wz1Bc=;
 b=o616xSUIWsXUZfomNboyu/h8ArKESuhk0FtuGwCsMq6kL9BhmyjqH3dcHuB6mKgtEj
 bzxvU8hgmNPz4EFPF78sp5Ib9xIxttNhF9KWK5vxENRPRH7D4hyaE99zJyH6+PeioE4H
 jBRuShkyAQOipnSws+heJ+ARZyr97zJJ+ZZMgvK5vIYTUTPonF4rN7XYOMcaFYBN0KaP
 iu5fbYsk9vBo6bnjQk9/mKSpY277R7thivsLBi/elUDGZ3XIS5N6JoZRLb3PQZKmCzvj
 GQ+8uR6861mxeS2iheJfeD6rWeo2h2WS3lum3I9nLjsQsmNqz69yHTwNhv3oCs7Kd1TO
 9lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hkalyHJqg5ugOHKHuOFHI5AizfqrqyG86NTtO7Wz1Bc=;
 b=p85rL+vepxCHeUqEqY5BV+rf0yOcW5o3uY/kX2zWczRvCfOCF0dba9JtikJZA0t9nf
 EzuzNKrKMZ3+RwoVUwwXU2dthtzanTNdAWkAuGVjDQyqGYK+HBpFY//EY1dDce0E56Mm
 kHKwBDohF26SV9dY43H8sCMi5SDQHTWS/Ca67/7PCnP1uMxYhzT/Rk9yarct9oZvL1MR
 JC7nPJWoP73P/R6pS3q1MNzeN1mUWXnQuqZcOHpcc6LVMhz0cC2tbOBfKHzqujX1qRoE
 U7CycMCCvQTGcahg46fz5Booae9rkiJMuunaT7gl4hkFYKqfTXNSSKSvChEZlSzxx/bg
 5pJw==
X-Gm-Message-State: AGi0PuZNSlpVJg99+Vyv4ykANdzNGKYL1JE2cWsxnMO5XrC7W81MAlQe
 EKMhWqpC/+jQVdwDlxcv3Q0=
X-Google-Smtp-Source: APiQypJLC7phBF0Yw8BoGoCloB2GTITOavOKuDxc7rGEQWR0RgqUB6wattNHXMe8HqoWNPsT7DRGrw==
X-Received: by 2002:a1c:c2d4:: with SMTP id
 s203mr12900240wmf.128.1587581730932; 
 Wed, 22 Apr 2020 11:55:30 -0700 (PDT)
Received: from localhost.localdomain ([91.221.170.230])
 by smtp.googlemail.com with ESMTPSA id a67sm244292wmc.30.2020.04.22.11.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 11:55:30 -0700 (PDT)
From: Gregor Pintar <grpintar@gmail.com>
To: alexander@tsoy.me
Subject: Re: [PATCH] ALSA: usb-audio: Apply async workaround for Scarlett 2i4
 2nd gen
Date: Wed, 22 Apr 2020 20:55:22 +0200
Message-Id: <20200422185522.3347-1-grpintar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7190177d62f349eea7a5d1056924a63fc4270d43.camel@tsoy.me>
References: <7190177d62f349eea7a5d1056924a63fc4270d43.camel@tsoy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Apr 2020 09:25:07 +0200
Cc: tiwai@suse.de, Gregor Pintar <grpintar@gmail.com>,
 alsa-devel@alsa-project.org
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

On Wed, 22 Apr 2020 Alexander Tsoy wrote:
> В Вт, 21/04/2020 в 21:31 +0200, Takashi Iwai пишет:
> > I wonder, though, whether we can correct the rounding error in the
> > driver code, too.
> 
> I'm not sure if it's possible with currently used Q16.16 arithmetic.

Maybe calculate fixed correction shifts (like it would be feedback)?
Something like leap year.

In endpoint.c:
static inline unsigned get_usb_high_speed_rate(unsigned int rate)
{
	return ((rate << 10) + 62) / 125;
}
I guess 62 tries to round it, but exact number is needed. So exact value for
44100 should be 361267.2. For 48000 it is 360448.
If only we can deliver that 0.2 by shifting rate somehow?

At least maybe it would be better to disable sample rates that do not divide
by 1000 on SYNC playback endpoints, if there are others sample rates.

But I'm not familar with the code or USB.

