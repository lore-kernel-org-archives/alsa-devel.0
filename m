Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59ABC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 23:42:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12D8818B5;
	Wed, 23 Feb 2022 00:41:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12D8818B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645573359;
	bh=h7hW/1oAn71EzGJnMnxoywwX4Q1V0B/wAoZRx+0BrzM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zyrj0QJ7coI99AWgvehQ5NurK8jqO+yccms9PZ8II0rNYMKto1nUdEzwKTPeOkzl9
	 7H86s21vHM0Ul3iAOtNTmFUB23zhaRYHR9zZnWz6gLFyEpxjZtV2giwLSuZxAZM+cs
	 QUxC3a/wfYXi4Gxdt4no9a2zCHTBNwCoJG0XwE7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E77DEF8051D;
	Wed, 23 Feb 2022 00:40:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15E0BF8012C; Wed, 23 Feb 2022 00:40:42 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F087F801EC
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 00:40:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F087F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r7sPGkz+"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EB1BFB81D5F;
 Tue, 22 Feb 2022 23:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DA5C340F1;
 Tue, 22 Feb 2022 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645573236;
 bh=h7hW/1oAn71EzGJnMnxoywwX4Q1V0B/wAoZRx+0BrzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r7sPGkz+uYZngqErWyweuSPlqhLDW8jscboEjnoz63N3AUsk9u7WktE4flkxYm+Ha
 FCsOa9SdbgU9BuJp1sN45osIu8MoDz1ZdAACNZYyCxw3v3dzBYKTNC68z/1UfEjX6u
 AL93Ye2pZw0BDaDOPJ3krRVyklDki4HWYlyj/AgWnplVmXaYpFZ81bKB2DwMDjNd+8
 OTG306f88pnYqh1RtqCXxFyERl1nqY4UVDJve0raGHJJwG4P1bNgsJzGBSyKX6wOgu
 kDq+pmE56WDxn0GYoVsbDgGBbq0YSq2jnpi6JY1WIH/Bpi12Ou/aYH4BVQqyUeY6uc
 RuePe1va6gwGQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 04/10] ASoC: max98390: Use modern ASoC DAI format terminology
Date: Tue, 22 Feb 2022 23:40:20 +0000
Message-Id: <20220222234026.712070-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222234026.712070-1-broonie@kernel.org>
References: <20220222234026.712070-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; h=from:subject;
 bh=h7hW/1oAn71EzGJnMnxoywwX4Q1V0B/wAoZRx+0BrzM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiFXQnphXGHRDjPWmkzr++fqE509m3bPcGcrL29Uv2
 mNtrFQWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhV0JwAKCRAk1otyXVSH0DV6B/
 9jj1QJyMOscK3sN6n2wUPTTc7sbiWXB6UJNuw/Jij4zSI4ZTFeDUKOVXdmQe8L64CnvaOTv+7iApV5
 G9ba7TbdT0CkvbO/H4RkbOOEGK3RW92Gpk9BWc6c9QD7AoZRzsHHP7EHX8Ao2s7m2N/m+KqWsJzN9q
 WL3NkAHCp8PZdKkOW5C+FBIF7VqWaqTcVt4UieUtUWSczLdXpIIlL1tK0TGrXyY3e2y11xGHDXyXBL
 tWk0TLIZfPDUyCDYwq5f4TiDesFHQ6HDKiIwf8AB3Xf3RVIpSLGHGuzBNtY5wsruEqR6WCRL8N/2MO
 l6qCvdWL2KWyxqUchpeoQJm08Q1i0d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Peter Rosin <peda@axentia.se>
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
the max98390 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98390.c | 10 +++++-----
 sound/soc/codecs/max98390.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index d1882cbc9381..40fd6f363f35 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -174,12 +174,12 @@ static int max98390_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 
 	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
 		mode = MAX98390_PCM_MASTER_MODE_SLAVE;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM:
-		max98390->master = true;
+	case SND_SOC_DAIFMT_CBP_CFP:
+		max98390->provider = true;
 		mode = MAX98390_PCM_MASTER_MODE_MASTER;
 		break;
 	default:
@@ -265,7 +265,7 @@ static int max98390_set_clock(struct snd_soc_component *component,
 		* snd_pcm_format_width(params_format(params));
 	int value;
 
-	if (max98390->master) {
+	if (max98390->provider) {
 		int i;
 		/* match rate to closest value */
 		for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
diff --git a/sound/soc/codecs/max98390.h b/sound/soc/codecs/max98390.h
index c250740f73a2..f4d6758ab4c6 100644
--- a/sound/soc/codecs/max98390.h
+++ b/sound/soc/codecs/max98390.h
@@ -656,7 +656,7 @@
 struct max98390_priv {
 	struct regmap *regmap;
 	unsigned int sysclk;
-	unsigned int master;
+	unsigned int provider;
 	unsigned int tdm_mode;
 	unsigned int v_l_slot;
 	unsigned int i_l_slot;
-- 
2.30.2

