Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4A6C77B73
	for <alsa-devel@archiver.kernel.org>; Sun,  7 May 2023 00:35:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF0571841;
	Sun,  7 May 2023 02:34:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF0571841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683419738;
	bh=Gi/XeeeFJGaxdykTW9TYbF0cQECHu1dUcrdCmjj4qbA=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rZHuzRdCDTNIdbIowFqU3aTuyqIowGIv+ebGLPVesvZiBhxYr3SWyLHLMxt7BSQ+3
	 SCDbIuuTGWYLAzLWOhe6+1z+ds2m2iNeRUp3rEgtgPge22hvi/P8//DxIZsVIOvqUy
	 PMnG6fQ1J1pZ1MHdORgvIyf7ocBjX2nHLaXOY8ZQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 40680F804B1;
	Sun,  7 May 2023 02:34:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D66D4F8052E; Sun,  7 May 2023 02:34:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 35415F80217
	for <alsa-devel@alsa-project.org>; Sun,  7 May 2023 02:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35415F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=k66Pu9X0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 270D160EF0;
	Sun,  7 May 2023 00:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E36C433EF;
	Sun,  7 May 2023 00:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683419661;
	bh=Gi/XeeeFJGaxdykTW9TYbF0cQECHu1dUcrdCmjj4qbA=;
	h=From:To:Cc:Subject:Date:From;
	b=k66Pu9X0WHvyTew2hQgZuASXzGOHyz/dEXnhtyWsfDhR+7cE09mUD7SFHFKsXZ3+Z
	 ovPOPRkDMziG++vPT0lOdzYghn7MQNIfAB/8sVjHtI+wUGncZBhDLGrdFYoMCi9CpM
	 G6CS7azvK8H/he4reS+WTPrOPai1STR791ljnefsYqSyF1CbxF6JNtcPCBy9BQrsX4
	 ys/+2SW9vY2oVV7HEkWjS9GH36SlvBuOmwHi+5ula0cI6PSyRZrqBafBSTs7Epbhj/
	 FvwTomEW9oO9MZpht5mXGfH3BV3N/XIxu5UcFQ9c/2Fn5CGpZHRRPPSwWkYYcPLWVf
	 gTMaJE2iB04gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/19] ASoC: jack: allow multiple interrupt per
 gpio
Date: Sat,  6 May 2023 20:33:59 -0400
Message-Id: <20230507003417.4077259-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MC5SX3O5WUWAG67BEY7E2NS6XBBNNOMN
X-Message-ID-Hash: MC5SX3O5WUWAG67BEY7E2NS6XBBNNOMN
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Svyatoslav Ryhel <clamor95@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MC5SX3O5WUWAG67BEY7E2NS6XBBNNOMN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit a2d4051b0bd6dffcd736888ae89a550d6f60b060 ]

This feature is required for coupled hp-mic quirk used
by some Nvidia Tegra 3 based devices work properly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20230221183211.21964-3-clamor95@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fcece5ca38c69..f951acb2ce362 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -367,6 +367,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 		ret = request_any_context_irq(gpiod_to_irq(gpios[i].desc),
 					      gpio_handler,
+					      IRQF_SHARED |
 					      IRQF_TRIGGER_RISING |
 					      IRQF_TRIGGER_FALLING,
 					      gpios[i].name,
-- 
2.39.2

