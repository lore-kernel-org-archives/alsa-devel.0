Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D686DC433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:05:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA7C206A1
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WZXl1t1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0195E1681;
	Tue, 15 Sep 2020 16:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0195E1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600178747;
	bh=LK0K1IKmildzXNgl4MPrlTsOrbYp+59RYFwHRmK3qqE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WZXl1t1GLJ57vKwQqW6KdTHNRztoCY7TSfaa72NWgTDr7rMXzTo/G12oKIluJWtUe
	 RXZXP45Z/kc68LmQZW5issW3I4tl/A+O6E2LrHyqDGVxeEsc1ZRw/FUmnbbZwFsI5x
	 XxNGCMTotQhcJED/dw6jeXoWV70oINdb40S6aNKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81FCBF8027C;
	Tue, 15 Sep 2020 16:04:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87575F800F1; Tue, 15 Sep 2020 16:03:59 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70F44F80146
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 16:03:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70F44F80146
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82554200481;
 Tue, 15 Sep 2020 16:03:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D77C72005C8;
 Tue, 15 Sep 2020 16:03:43 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6B37402A5;
 Tue, 15 Sep 2020 16:03:38 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: dt-bindings: ak4458: Add dsd-path property
Date: Tue, 15 Sep 2020 21:56:59 +0800
Message-Id: <1600178220-28973-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add "dsd-path" property, which is used for ak4497 codec
to select the DSD input pin.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
index 8f6c84f21468..0416c14895d6 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -12,6 +12,9 @@ Optional properties:
 - mute-gpios: A GPIO specifier for the soft mute pin
 - AVDD-supply: Analog power supply
 - DVDD-supply: Digital power supply
+- dsd-path: Select DSD input pins for ak4497
+            0: select #16, #17, #19 pins
+            1: select #3, #4, #5 pins
 
 Example:
 
-- 
2.27.0

