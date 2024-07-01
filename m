Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E24C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:33:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8961822AF;
	Mon,  1 Jul 2024 13:32:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8961822AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719833579;
	bh=JyxXab3gh+wCGMjIW6vDCbjLfD//HftTPx3aJXGP3m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OvRtGesAsXH9ESXPsXN+ua+4lIZL6nG9z6yWdDzJjsg2Kz4zfcxCQ98xFldx5YNBk
	 yYl0rTNlb53sp3arOhDHX6C04HBDcYhoqeNo7RrtU7thRJ5fKKH/5NAADmmN+pQeu9
	 EislwCqE+ahgc1BjHiH1rOFoxhGTz+6mmRJUVVOc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D054F805EE; Mon,  1 Jul 2024 13:32:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D6C7F805EA;
	Mon,  1 Jul 2024 13:32:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E137F804F2; Mon,  1 Jul 2024 13:32:02 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5F7C1F8003A
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 13:31:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F7C1F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=fY5JNPPN
Received: by mail.gandi.net (Postfix) with ESMTPA id 5EB47240002;
	Mon,  1 Jul 2024 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719833511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2OniZ6NTuy93VyAe8/Sk6MsW0dFYWJCYUEKa4O7/i0=;
	b=fY5JNPPNTUPd+3WwdpltqYwI63mL9XXxlIkXhbS6hKe5rdPZ4lvBOQfo5N0juytrcdShcz
	MmlHt9VD3Xu6TUoWvSWvKIMPGLqmySiXL6B/mRONseF5N76usRmMgMq8+2+PrH1sU2w3S8
	0gh+G3GYDDEnDNJ6AZ+3xsfj5zl5VEIhgmsX2ykfDBZTLsfkVq8fqSWHvbYaguK1hhfpGl
	1BaL2FMf4IVKA9yB+WQGAGqUR64suAfhLN2M3peUznZjgN6NtROnfFLuFEPF61HfZ28Uj4
	xj40osEIqZmE25n5f5YKzg9JLX9Io/Myd1eOjD1HLLLvMdWMvDZhSoqNN4mmDQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/10] ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf()
 returned value
Date: Mon,  1 Jul 2024 13:30:28 +0200
Message-ID: <20240701113038.55144-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701113038.55144-1-herve.codina@bootlin.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: BTZXSVXMA4MQX4OKJJTCAW2DWLY72WBI
X-Message-ID-Hash: BTZXSVXMA4MQX4OKJJTCAW2DWLY72WBI
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BTZXSVXMA4MQX4OKJJTCAW2DWLY72WBI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked.

Fix this lack and check the returned value.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index bfaaa451735b..dd90ef16fa97 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -604,6 +604,8 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 
 	qmc_dai->name = devm_kasprintf(qmc_audio->dev, GFP_KERNEL, "%s.%d",
 				       np->parent->name, qmc_dai->id);
+	if (!qmc_dai->name)
+		return -ENOMEM;
 
 	qmc_dai->qmc_chan = devm_qmc_chan_get_byphandle(qmc_audio->dev, np,
 							"fsl,qmc-chan");
-- 
2.45.0

