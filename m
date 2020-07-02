Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC43AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:47:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7291720760
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CboYxOMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7291720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10E7C16EB;
	Thu,  2 Jul 2020 21:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10E7C16EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593719246;
	bh=8hDQisk2/bye94ONsBEdlp8jK6VAFGn6499WSQhKh+A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CboYxOMyAJ8SPsPl5+vzo83NdvRo840nrj7icuqOsLspF89Ah9R9RXIITF+2PUnQq
	 IMsOG3T3IXP1ypWvcWhiFmQ5jQ9eoleJ8IFo8Ohl8xNDO3jx1Gnr7avZEytzyRCrNs
	 V+Aug+hubYhsVUJTKu84NqQsLrhch13fB7xVpS0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6586DF8034F;
	Thu,  2 Jul 2020 21:37:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CB77F80317; Thu,  2 Jul 2020 21:36:58 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E226AF8022D
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E226AF8022D
IronPort-SDR: xuAxjlKcrpzw5o4w4xJktbwoRyA2yceaImp0AssZeS0aM8ajKD8DDexPA1Bfu7kUyvz8RLehh1
 SN9+Y+TmpO7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549358"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:28 -0700
IronPort-SDR: cqGqDTUDx4X4BQ0zpQrH7uxPUJgXydf0vLvEL+Uqki8ndvpneLVy6T1pgtlCLnizMU7RyMBGCd
 1teen6lYd4Tg==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116389"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:27 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 16/23] ALSA: pci/oxygen/xonar_wm87x6: remove always true
 condition
Date: Thu,  2 Jul 2020 14:35:57 -0500
Message-Id: <20200702193604.169059-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warnings:

sound/pci/oxygen/xonar_wm87x6.c: In function ‘wm8776_write’:
sound/pci/oxygen/xonar_wm87x6.c:119:11: warning: comparison of
unsigned expression >= 0 is always true [-Wtype-limits]
  119 |   if (reg >= WM8776_HPLVOL && reg <= WM8776_DACMASTER)
      |           ^~
sound/pci/oxygen/xonar_wm87x6.c: In function ‘wm8766_write’:
sound/pci/oxygen/xonar_wm87x6.c:147:12: warning: comparison of
unsigned expression >= 0 is always true [-Wtype-limits]
  147 |   if ((reg >= WM8766_LDA1 && reg <= WM8766_RDA1) ||
      |            ^~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/oxygen/xonar_wm87x6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 0767276582ca..8aa92f3e5ee8 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -116,7 +116,8 @@ static void wm8776_write(struct oxygen *chip,
 	else
 		wm8776_write_i2c(chip, reg, value);
 	if (reg < ARRAY_SIZE(data->wm8776_regs)) {
-		if (reg >= WM8776_HPLVOL && reg <= WM8776_DACMASTER)
+		/* reg >= WM8776_HPLVOL is always true */
+		if (reg <= WM8776_DACMASTER)
 			value &= ~WM8776_UPDATE;
 		data->wm8776_regs[reg] = value;
 	}
@@ -144,7 +145,8 @@ static void wm8766_write(struct oxygen *chip,
 			 OXYGEN_SPI_CEN_LATCH_CLOCK_LO,
 			 (reg << 9) | value);
 	if (reg < ARRAY_SIZE(data->wm8766_regs)) {
-		if ((reg >= WM8766_LDA1 && reg <= WM8766_RDA1) ||
+		/* reg >= WM8766_LDA1 is always true */
+		if (reg <= WM8766_RDA1 ||
 		    (reg >= WM8766_LDA2 && reg <= WM8766_MASTDA))
 			value &= ~WM8766_UPDATE;
 		data->wm8766_regs[reg] = value;
-- 
2.25.1

