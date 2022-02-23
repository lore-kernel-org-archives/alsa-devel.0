Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE0C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 01:49:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 484701909;
	Wed, 23 Feb 2022 02:48:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 484701909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645580988;
	bh=/eztGgB/qaOyxpKSXlrdBXVDfhrcn0PcKGbDUZqrf8g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QWUwgCzPFidhWxR3s+6hOSvh4B+bGDzrOxNKHeQsZzIP6q1miKSL5ZhWMUfW87W62
	 8q0ObDLFpTG4gBRUAkR0oNlvF//BgdSAvVUNV1dNCdgc0OPr1kByQfo5OlqCNMndlD
	 OqDjZNjE6zwpuPzJXjn3O1ndRCgUBFK/I+gPgiBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E34A3F80118;
	Wed, 23 Feb 2022 02:48:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39170F800F5; Wed, 23 Feb 2022 02:48:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3F7CF800F5
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 02:48:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3F7CF800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DvxOD98a"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 69C96B81E00;
 Wed, 23 Feb 2022 01:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2756EC340E8;
 Wed, 23 Feb 2022 01:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645580932;
 bh=/eztGgB/qaOyxpKSXlrdBXVDfhrcn0PcKGbDUZqrf8g=;
 h=From:To:Cc:Subject:Date:From;
 b=DvxOD98aANOMTTx+DDHoEmTeIZ6llOvCRuYq14yQWgTHCYnPjWrTODh13R9Ms1edk
 L0D2dzpg2BiUp2+3eIuMZiTPR+XbN+WpVG6x8m3dYjexxKBbRRXxBqK+e/2o+lSA71
 mKlMwoolXyMGEeRFug4fvAeUJJT+vm1KEEy0YWC3FuKHzIbbUEZ3S6f2+4YzBpe8p+
 dclc7axKUv9Auj6e4MWoJDUJSmoZxIaddJjwapWLT7cbUnHK0wEg2PeCFNMc5bABJd
 dKTg1gFAT17h04BOUWQO+sZ/rSwlvwUnBoYfSXtLi10PAZrhxG1T1PgjRrESVSaloj
 nZ4vgE76sDiIQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/4] ASoC: pcm1681: Use modern ASoC DAI format terminology
Date: Wed, 23 Feb 2022 01:48:43 +0000
Message-Id: <20220223014846.2765382-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; h=from:subject;
 bh=/eztGgB/qaOyxpKSXlrdBXVDfhrcn0PcKGbDUZqrf8g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiFZJmJ+AXvYhyktyzjI3sqkq4hx/Iv1k2rfAK6Hr0
 1C02V3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhWSZgAKCRAk1otyXVSH0BYMB/
 97pY52uur3mdQ4UCTmaNGYlA+ZbjFORgKUPjQAbrVF6rOtizwOkvq02Gt2xMY4YzNpxMi3UvDKSXnC
 qEkYlsBDwjJDJ/6+b3PViCLE4j3GTE461aWpX3Z4ggxriRBVt6dFyfnYnraKddJvN31gbmSUGkI2Hl
 OMddpsJ0h4PowXAuPc0JsWtFo91wmtn9dRA6NnPdMk/TTo8KqQcYH1Es4f/2gH7g/7GA5Dihb3KZ8q
 ZzCjwLsy4I7UTrE6XnGFrORgf+ofABJEamf66ywlxeQU4aDa0hPgjdUYQd2s9RkKYL2Tl7S5CfMhxJ
 aSKeGZldAopOFPYmbu61LbHTTN14oM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

As part of moving to remove the old style defines for the bus clocks update
the pcm1681 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1681.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 5b78e9299c95..9eb65f94fc4d 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -136,8 +136,8 @@ static int pcm1681_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_component *component = codec_dai->component;
 	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 
-	/* The PCM1681 can only be slave to all clocks */
-	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+	/* The PCM1681 can only be consumer to all clocks */
+	if ((format & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_CBC_CFC) {
 		dev_err(component->dev, "Invalid clocking mode\n");
 		return -EINVAL;
 	}
-- 
2.30.2

