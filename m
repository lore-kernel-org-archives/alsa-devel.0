Return-Path: <SRS0=FleP=KX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFEC47087
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 16:05:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDD5613E3
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 16:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDD5613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80DB016CD;
	Fri, 28 May 2021 18:04:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80DB016CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622217920;
	bh=bs2mBR66uVvWvx/Ef0gflX8oSZvQLdierWWtSLOHTYo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDrxG0z9OvOzyhUbATpDPcGQiBOHxOSu1M5Xekl9fW/TUp/Q8yhcycPPpdzpYeYye
	 kjuD2kU8sjLKmh3bU2RdOB5KOigAfMN0Wk+Tkfg3pWoykhb9/PqDwaKVMpm4tLMlpK
	 1EV8DgyP+fApLLoQRDrYI1rGIkReBP84FisrFjxE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC030F802BE;
	Fri, 28 May 2021 18:04:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB3F5F804B0; Fri, 28 May 2021 18:04:27 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AB29F804AB
 for <alsa-devel@alsa-project.org>; Fri, 28 May 2021 18:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AB29F804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Yb1mbA3F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=giTOQvmYrM5t4JeSPs9O4ZMevYgrHFOv5wej4uvXIjI=; b=Yb1mbA3FhKG7hQCRGy0vNSP3B/
 wTf/VSK+Su+gvMJZNGII8t7X8vu3n74aeOL9XO0ed8m2zQ9372FmHk6ScY2j8KVKQBDH7xxgXID3C
 qfJYZl6BIu8gKxsNxveNAsStWkk9PgHLbiUReQkq2/SATRKRopCaTl2qzkeCe4A0dd9A=;
Received: from cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 ([92.233.91.117] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1lmeyE-006czY-0e; Fri, 28 May 2021 16:04:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 520ECD078FE; Fri, 28 May 2021 17:04:21 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com,
	Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5659: Fix the lost powers for the HDA header
Date: Fri, 28 May 2021 17:04:17 +0100
Message-Id: <162221783192.3504698.9775759615007728247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <15fced51977b458798ca4eebf03dafb9@realtek.com>
References: <15fced51977b458798ca4eebf03dafb9@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 lars@metafoo.de, Brown@sirena.org.uk, broonie@kernel.org,
 =?UTF-8?q?Derek=20=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= <derek.fang@realtek.com>,
 =?UTF-8?q?Shuming=20=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= <shumingf@realtek.com>,
 Mark@sirena.org.uk, mkumard@nvidia.com, "Flove\(HsinFu\)" <flove@realtek.com>
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

From: Mark Brown,,, <broonie@kernel.org>

On Thu, 27 May 2021 01:06:51 +0000, Jack Yu wrote:
> The power of "LDO2", "MICBIAS1" and "Mic Det Power" were powered off after
> the DAPM widgets were added, and these powers were set by the JD settings
> "RT5659_JD_HDA_HEADER" in the probe function. In the codec probe function,
> these powers were ignored to prevent them controlled by DAPM.

Applied, thanks!

[1/1] ASoC: rt5659: Fix the lost powers for the HDA header
      commit: 6308c44ed6eeadf65c0a7ba68d609773ed860fbb

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
