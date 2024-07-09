Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFF9C2BD09
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:29:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AC20F50;
	Tue,  9 Jul 2024 18:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AC20F50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720542569;
	bh=lstzIYvPCZPCOyislBdQb7DoT8PCCt7CdK6+rbKdaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gXEMxCHm+wDyZG+/3YpQEnUwokyUj9N4wpUOPJRnR8+p3qzGofimX0ZKgEsHmVKtZ
	 gDi/5VBoWMU8jFiKJogvn8fdgHhRHdFazuXmBFNcsZDJbCGkM0kOASWh7Rajp50taI
	 C1e01VCfPL6ETwldSxtyNZ7gcbyIkGWhAo4H1mro=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF114F806AC; Tue,  9 Jul 2024 18:27:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C7DE4F8069E;
	Tue,  9 Jul 2024 18:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C6F3F80682; Tue,  9 Jul 2024 18:27:39 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7B067F8060B
	for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2024 18:27:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B067F8060B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OFOX4fs6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E3BD2CE12BB;
	Tue,  9 Jul 2024 16:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC48C32782;
	Tue,  9 Jul 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542423;
	bh=lstzIYvPCZPCOyislBdQb7DoT8PCCt7CdK6+rbKdaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFOX4fs6To2JPZ6RX2pNnVSdnc65vOGn28sxDrQuzTm71pSXASf6We9wbDXeDY8D8
	 qDooI1NVSLkPIU//efZ96ER8N8RJ5hENJZ1ff4VceNZK5SAuRCL8GizgT9JGZssLpT
	 3lxMvmI08M+EP1ki04qSUSldtjembyrgL52FViji2uIpKaSdK1bDemw5sHBpeA+Dwm
	 tVZOUGxM7//b019c/xaSBfYUFpzsUN6AvIsBqcIWkqD9a55ertwJk5gZG49hIHcaCF
	 McU3pcc2j0frEhawcMgDKR9IioyYD6tmrXqoOxjLbbaUzMFiIWj4Col5vQPBM4EH9e
	 rY6SeaWINWOCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Primoz Fiser <primoz.fiser@norik.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jarkko.nikula@bitmer.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-omap@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/11] ASoC: ti: omap-hdmi: Fix too long driver
 name
Date: Tue,  9 Jul 2024 12:26:37 -0400
Message-ID: <20240709162654.33343-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162654.33343-1-sashal@kernel.org>
References: <20240709162654.33343-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ND6OAMSONUFXZMUJ76TFP7NG4TE76MGV
X-Message-ID-Hash: ND6OAMSONUFXZMUJ76TFP7NG4TE76MGV
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ND6OAMSONUFXZMUJ76TFP7NG4TE76MGV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Primoz Fiser <primoz.fiser@norik.com>

[ Upstream commit 524d3f126362b6033e92cbe107ae2158d7fbff94 ]

Set driver name to "HDMI". This simplifies the code and gets rid of
the following error messages:

  ASoC: driver name too long 'HDMI 58040000.encoder' -> 'HDMI_58040000_e'

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20240610125847.773394-1-primoz.fiser@norik.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-hdmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index def2a0ce88863..e4f661c5349ef 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -353,11 +353,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
-	card->name = devm_kasprintf(dev, GFP_KERNEL,
-				    "HDMI %s", dev_name(ad->dssdev));
-	if (!card->name)
-		return -ENOMEM;
-
+	card->name = "HDMI";
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
-- 
2.43.0

