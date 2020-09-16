Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0836FC2D0A7
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:15:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4543E2064E
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hwe2IY/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4543E2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49F1A1612;
	Wed, 16 Sep 2020 08:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49F1A1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600236931;
	bh=xIwrm7z23oIBGeDpQbcKW1MvHRZZBqn1qtEFrS5U6zg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hwe2IY/DO5WID9qWtr+F1SHGrmyS1AFzA1ZHEE4s6T5lReB3pFasAgsTTOl5dle3L
	 WRKlp47Un9j41WYNNTTZKd2/5XgrfhW55FbdovDWmM0KfHTxIId+YR18QKt8hsc00z
	 jD0VW5qA669yvYG3fqKSqig768yw7vhP11H0h8Pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CA92F800E8;
	Wed, 16 Sep 2020 08:14:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3009BF8015A; Wed, 16 Sep 2020 08:14:38 +0200 (CEST)
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
 by alsa1.perex.cz (Postfix) with ESMTP id 6E737F800E8
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 08:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E737F800E8
Received: from localhost (unknown [159.226.5.99])
 by APP-03 (Coremail) with SMTP id rQCowADX3Ow9rWFfj71FAg--.32289S2;
 Wed, 16 Sep 2020 14:14:22 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] fsl: imx-audmix : Replace seq_printf with seq_puts
Date: Wed, 16 Sep 2020 06:14:20 +0000
Message-Id: <20200916061420.10403-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowADX3Ow9rWFfj71FAg--.32289S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UKw1fAr43Ar4rJr17trb_yoW8Aw45pa
 1ktFW0qFyjyF4Yvr1kKr4kWasxAa97Ca18t3W2gw1avwnxKr4kGFsYqr1UZFWFyF9YkF45
 K3y8Ja4YvFyUAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
 JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUe7KsUUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQUBA102Zk3uuAAAsY
Cc: linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
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

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "devm_kcalloc".

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/imx-audmix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 202fb8950078..cbdc0a2c09c5 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -185,20 +185,20 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->num_dai = 2 * num_dai;
-	priv->dai = devm_kzalloc(&pdev->dev, priv->num_dai *
+	priv->dai = devm_kcalloc(&pdev->dev, priv->num_dai,
 				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
 	if (!priv->dai)
 		return -ENOMEM;
 
 	priv->num_dai_conf = num_dai;
-	priv->dai_conf = devm_kzalloc(&pdev->dev, priv->num_dai_conf *
+	priv->dai_conf = devm_kcalloc(&pdev->dev, priv->num_dai_conf,
 				      sizeof(struct snd_soc_codec_conf),
 				      GFP_KERNEL);
 	if (!priv->dai_conf)
 		return -ENOMEM;
 
 	priv->num_dapm_routes = 3 * num_dai;
-	priv->dapm_routes = devm_kzalloc(&pdev->dev, priv->num_dapm_routes *
+	priv->dapm_routes = devm_kcalloc(&pdev->dev, priv->num_dapm_routes,
 					 sizeof(struct snd_soc_dapm_route),
 					 GFP_KERNEL);
 	if (!priv->dapm_routes)
@@ -208,7 +208,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		struct snd_soc_dai_link_component *dlc;
 
 		/* for CPU/Codec/Platform x 2 */
-		dlc = devm_kzalloc(&pdev->dev, 6 * sizeof(*dlc), GFP_KERNEL);
+		dlc = devm_kcalloc(&pdev->dev, 6, sizeof(*dlc), GFP_KERNEL);
 		if (!dlc) {
 			dev_err(&pdev->dev, "failed to allocate dai_link\n");
 			return -ENOMEM;
-- 
2.17.1

