Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE9C38A2D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 15:02:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E77D150A7;
	Tue, 25 Oct 2022 17:02:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E77D150A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666710175;
	bh=cmimi/f2Ov8ciwP3TqeneC+3HhVdIsver/X74PlGva4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DRnWo/Gp+rcWbvGqNvSzOxUcwSuGcp+f5gAlN3km7S8Sm8cT+z1IVQo6dvpUibSSG
	 j7WRw1X9jRUThHR2MTbH254ZXkss2g7S4r17IbEx8YmJ9GyVNfa9uFs+VCpyp/KTt8
	 1VGkCxz0JVeTo3yR7+T4Ods5/6ep9giAX1brw1/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89311F8042F;
	Tue, 25 Oct 2022 17:02:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 933B3F80431; Tue, 25 Oct 2022 17:02:03 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77B8CF80240
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 17:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77B8CF80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="WoGntmFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1666710116; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=xRxva5kPtIk4AgmMh5Ah5qs16fLVraMoyg8JYmMcBno=;
 b=WoGntmFizqSg7uziAiWpH5vkz4ugrgLIaFQgV7uO5zGOHCikQwdp6kdWtXJudWr29Kg2fv
 0FOO4EOdIkiNYAuyYFzYnRntmv9oZDxReSLf5ZOI3t97XCm5YVt2MsrcJeEzu6GDYf+1u9
 +LKdo1Xbe7TwcFSdhU/0VIPsxSh6EhY=
From: Paul Cercueil <paul@crapouillou.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: dapm: Don't use prefix for regulator name
Date: Tue, 25 Oct 2022 16:01:49 +0100
Message-Id: <20221025150149.113129-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org,
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

When a component has a prefix, and uses a SND_SOC_DAPM_REGULATOR_SUPPLY,
the name of the regulator should not use the prefix, otherwise it won't
be properly matched in the DT/ACPI.

Fixes: 3caac759681e ("ASoC: soc-dapm.c: fixup snd_soc_dapm_new_control_unlocked() error handling")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d515e7a78ea8..879cf1be67a9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3645,7 +3645,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
-		w->regulator = devm_regulator_get(dapm->dev, w->name);
+		w->regulator = devm_regulator_get(dapm->dev, widget->name);
 		if (IS_ERR(w->regulator)) {
 			ret = PTR_ERR(w->regulator);
 			goto request_failed;
-- 
2.35.1

