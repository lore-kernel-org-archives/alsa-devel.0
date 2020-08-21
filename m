Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360EC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:14:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56C22078D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YMVPJhDw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Vt4Sqwe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C22078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AA5E1687;
	Fri, 21 Aug 2020 09:13:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AA5E1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597994064;
	bh=4C93rfTkYYAe6YpLxR8PaC5qgCxICWsqnPda3XOTLVU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YMVPJhDwEzupEp06nbnWRLyeRFPxeoseq/bio/896gdiapz+PIvoSGhJpeNX7Orf+
	 x+TgpBNqd7rJBSVsynR0DzF0fybtZ8PhlvLH60nDn+NjmiEmp8XB4EfLl9mvlgZC66
	 Zcc3elDoUdja99x2Xh8bOo637dfD6JesSXCYZ8zo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AFF7F80218;
	Fri, 21 Aug 2020 09:12:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76D74F80218; Fri, 21 Aug 2020 09:12:22 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [62.157.118.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F323F80218
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:12:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F323F80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com
 header.b="Vt4Sqwe3"
IronPort-SDR: 2D1en2nIaqpQD5WHCwkl5keNUKSx1Yg7WLkFEX+Jp+IudMxGs1H/g5cCp/jxcMacHgXvy977qn
 5g3ld4Rv8sGPCt/inLic2BkOVLqH70LdODaB2ptDpGVg13T61EzidU9QW3C6DvmrFHbpX2Zngh
 wSVeYWIXGeol0ckTAlkUHDCjLHhVEeQNW8peWblzM86/UMCaKAFTTJ3j1iwbl+kjsFJRNfSETg
 N4lh8O5r9BBLFmbAv+ZzOUyWz2Ya6kArXVgIQ2LdjiAiE5PTUGVhAM1FZUaEtYeQwUHYw7+fs7
 jJo=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; d="scan'208";a="13549137"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 21 Aug 2020 09:12:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Fri, 21 Aug 2020 09:12:11 +0200
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Fri, 21 Aug 2020 09:12:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1597993931; x=1629529931;
 h=from:to:cc:subject:date:message-id;
 bh=4C93rfTkYYAe6YpLxR8PaC5qgCxICWsqnPda3XOTLVU=;
 b=Vt4Sqwe3i0b2cyC3lAhzp2Yi+sqoXtYFC2sCdrTVy8gwY9CyEiL+Um5k
 uQAh5tqzqvc/VIz7efzO02RYLgv/rQ9LqIRcZqU9yvWwFIGGE0Y0uVjqe
 eeHAp8F3vAQXI/MAoYBmLuf7Jc4NG6Sv12voaIF7Adwd5q67FOE5zqyHJ
 c1wt0HK9Q+PnRxOJlrVn6I2EDnsnNv7boPbh/ENCzhYSp84Bdnovc+fU+
 lNGOPSuyQT7bAY5zTVU2MNVPv/7XM5OsmhxxP6QqbXtfAQcE3E8voGhDd
 Ah9qmNvgxe0PM7YWxrdT2pjcXpM7L456B/LhM67awZEsKtNRssxlEaur4 Q==;
IronPort-SDR: 6LGTt+7iBWNLGsTYozLX6NjYOiV2bCMlsFeIRF2xdffJ9B+qK9CoDa1hEyGqnxS5Q7XWWYVf1P
 v7KRfyhftrSqG/neIJL821FYZLfCDPzGD9wpbq873juzofSBUp76oxRK3bssXI8m2fTfNJLt3i
 OOlRIXO5npr+Vfpsn5wWPnRzD9fwe+kxzQLDPS8f5KiKSFwvyRUdY7MAPMsWo5WtRMynRW3E7A
 0ySil2zYA546DRPRdhaamIo+uQJLKfLV474xZ2T1g5AJ5ZbssgzE4BdXP0f9nLfNRBi+ZZtDkI
 WlU=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; d="scan'208";a="13549136"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 21 Aug 2020 09:12:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de
 [10.117.49.26])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 90C36280065;
 Fri, 21 Aug 2020 09:12:11 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: add compatible string for
 TLV320AIC32x4 codec
Date: Fri, 21 Aug 2020 09:11:52 +0200
Message-Id: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 linux-kernel@vger.kernel.org
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

The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 63ebf52b43e8..f339be62e7e4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -38,6 +38,8 @@ The compatible list for this generic sound card currently:
 
  "fsl,imx-audio-wm8524"
 
+ "fsl,imx-audio-tlv320aic32x4"
+
 Required properties:
 
   - compatible		: Contains one of entries in the compatible list.
-- 
2.17.1

