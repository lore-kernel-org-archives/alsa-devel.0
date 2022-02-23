Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2768C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 00:31:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D91721798;
	Wed, 23 Feb 2022 01:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D91721798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645576309;
	bh=PZN/IotVQCa6X5R8t7KaCBLRkc1kT4WSU/+f6u1wdCs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oLoa1S1a3lwJFZkgC1NTKWfPf5IQTbLHah0jtyungB6v8LPCFKAu3lsKOwRVNMDki
	 OB/AqLr9LcawgMGr6Uh2gp3x/nuXfz+CP3b1uoVTqtogwraQmpatYpow1H+svNHGUH
	 8HFK1k2akoskunb99B9A2AVLrwgc7n9c3CU07o1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C62DF800F5;
	Wed, 23 Feb 2022 01:30:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 072ADF800D1; Wed, 23 Feb 2022 01:30:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A331FF800D1
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 01:30:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A331FF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WuvWLajt"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB14612F2;
 Wed, 23 Feb 2022 00:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93E3C340F0;
 Wed, 23 Feb 2022 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645576252;
 bh=PZN/IotVQCa6X5R8t7KaCBLRkc1kT4WSU/+f6u1wdCs=;
 h=From:To:Cc:Subject:Date:From;
 b=WuvWLajtjWv0IoxpmKotYUbXJTI8aymjA7dt7YYwBNJqBJ8tf1mIJHL2zqenBB3RG
 Y693k6jNMJ5gYhobk/evk8FAk6indo3Zz3Qd6LF2BNzdyp1ZglPcN/WUtyZk4Zq6jt
 k9vZSBEdQiT8KcNkQm5Y4pJe3F3Ubbl1FgEwylcwHY+vWbgqCylfzYqeMC67Hi0hZo
 9PAUffKEW3xdKmuosY8RHzMXJ5xW0NPdv8EWA8F0GPzjn7YEXeMRk/VPA8AHKizyb8
 wD3/dMyMMYDIOYjTnAmiST59csyQk8o3qoz1Z6GugPeZwz4rbo1ztFWlmrh8i7xg5A
 gbOjT37Hu1Mfg==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: twl4030: Use modern ASoC DAI format terminology
Date: Wed, 23 Feb 2022 00:30:46 +0000
Message-Id: <20220223003046.1697784-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; h=from:subject;
 bh=PZN/IotVQCa6X5R8t7KaCBLRkc1kT4WSU/+f6u1wdCs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiFX/y3ZYI3wXk9qgPycD3cQCQQerkoWMnJ4XXJifh
 i+tmgf6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhV/8gAKCRAk1otyXVSH0JqdB/
 9j+vUjjuCsAbujbQfeoc7tjbqE1q0gSUYYL0MbZIY2OYF2qYvXhj5sVeum2Gf+8tJtoAvuNqwlW7QL
 vtIqT168KZf+1WkxvDdjjAqf5mg6iwPmM4RpeguXOTKzFRJ0D/elpO/Wos5Eh8OQC8BXn53hreyazW
 wHHmh2rOk/WN+e0g4Y5HC/ra4K9RWS4F8fWu1owtjOCDJ/4ioXTThnj+h7bM/nA/LrJXDgNsA8hNcH
 wHNeGD/H/xevgbBX9EIDVQXcODjdo6Dvepjna/TRg8YZdZKnpfATLe2pe2OYUs0fymAhpBdJQeoUlq
 CQ4DoPxnTntuW9evZfXz0uM1b1pazb
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
the twl4030 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl4030.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e059711ff293..0ba3546ef870 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1840,13 +1840,12 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	old_format = twl4030_read(component, TWL4030_REG_AUDIO_IF);
 	format = old_format;
 
-	/* set master/slave audio interface */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		format &= ~(TWL4030_AIF_SLAVE_EN);
 		format &= ~(TWL4030_CLK256FS_EN);
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBC_CFC:
 		format |= TWL4030_AIF_SLAVE_EN;
 		format |= TWL4030_CLK256FS_EN;
 		break;
@@ -2038,9 +2037,8 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	old_format = twl4030_read(component, TWL4030_REG_VOICE_IF);
 	format = old_format;
 
-	/* set master/slave audio interface */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		format &= ~(TWL4030_VIF_SLAVE_EN);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-- 
2.30.2

