Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8E1C54EBE
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jan 2023 08:34:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EA6C9032;
	Tue, 10 Jan 2023 09:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EA6C9032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673339679;
	bh=EkGv2fAe4IZVtbYTynD17ofPqbrfLMHTNC1/01j67Zc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JxL0Sqwe0KpfHaHP4lRhoTMbI9JzN2a1QteRGz7OMgNw74W9tBao50r0EDILrJlCp
	 NvIhMjnzdZweJVbFlxn7hnB+1m104oKyt1mpoVN02C/gNlJgsVB0gw72Vupn6NgoeY
	 Q4PR//n65KNqSe3wFRjc2kJDS4I1c0LLPGwkqhqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6171F80544;
	Tue, 10 Jan 2023 09:32:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23463F8024E; Fri,  6 Jan 2023 14:30:23 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A69E4F8025A
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2023 14:30:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A69E4F8025A
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=gRZd+VM0
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id B466840010;
 Fri,  6 Jan 2023 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1673011816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHdG5dWGsORYS6XG1CcUMN1p2tcFBkBpXeEXIVWBo8Q=;
 b=gRZd+VM02MADKNfgu66UEHMokrsVMXI/MBXuX1NRBymAldkteEF3bWjPHiL2Na3Rnsg055
 sVEWGxJIc5g+uUfFp8PNBfSXAYyF6CzgWrh5Rr0smgVNlH5XZc+OhPVohfonqIvb2V8f0a
 vFjdzh5h37q7+hvnHCIrE7FNQqysdVcmywDGRMYpvfVCcPnMIQS5ZR0KCKtzrf7uoJcE2W
 T3sqDZwjXLbzNLR5sI6f3/mJjxBhmFr4IDhYzy4L9VQsbILz5g+ImmLrihNI6Rd0v5gpg3
 EX5ZXUPKETN8273pnNN+SGqSI11ZZt7zge3UReeT+iGIMHD97ie4yhQ9C5ElsA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 04/10] powerpc/8xx: Use a larger CPM1 command check mask
Date: Fri,  6 Jan 2023 14:29:45 +0100
Message-Id: <20230106132951.392271-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106132951.392271-1-herve.codina@bootlin.com>
References: <20230106132951.392271-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jan 2023 09:32:35 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The CPM1 command mask is defined for use with the standard
CPM1 command register as described in the user's manual:
  0  |1        3|4    7|8   11|12      14| 15|
  RST|    -     |OPCODE|CH_NUM|     -    |FLG|

In the QMC extension the CPM1 command register is redefined
(QMC supplement user's manuel) with the following mapping:
  0  |1        3|4    7|8           13|14| 15|
  RST|QMC OPCODE|  1110|CHANNEL_NUMBER| -|FLG|

Extend the check command mask in order to support both the
standard CH_NUM field and the QMC extension CHANNEL_NUMBER
field.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/powerpc/platforms/8xx/cpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index 8ef1f4392086..6b828b9f90d9 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -100,7 +100,7 @@ int cpm_command(u32 command, u8 opcode)
 	int i, ret;
 	unsigned long flags;
 
-	if (command & 0xffffff0f)
+	if (command & 0xffffff03)
 		return -EINVAL;
 
 	spin_lock_irqsave(&cmd_lock, flags);
-- 
2.38.1

