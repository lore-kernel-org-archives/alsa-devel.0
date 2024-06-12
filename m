Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7DC27C53
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jun 2024 06:59:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E1D3E67;
	Wed, 12 Jun 2024 08:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E1D3E67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718175561;
	bh=o2rGzDo3YKlqQkaytlg9bu7jSVurFyAsDq+dZF2uQ0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lF0VMCQVhuKtfwZ02Q6dDkPX42eepXueiQQydo1Oe6QIaMXMvNFIWTInSjHbY+cH6
	 ER69DKOZgB+DJMY8lj3GTBnXT+vozZAVew2l04ELXTt+W/7lwo0lXzOdNQNd6Q7rkf
	 EwN9oDsXCH9gyC9Er1OQnBmrQea7Ctm78mtmEBpU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E11EF80634; Wed, 12 Jun 2024 08:58:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F1B2F80615;
	Wed, 12 Jun 2024 08:58:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 236C4F805C3; Wed, 12 Jun 2024 08:58:01 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1564F80448
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2024 08:57:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1564F80448
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 884552018B5;
	Wed, 12 Jun 2024 08:57:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE47820079D;
	Wed, 12 Jun 2024 08:57:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ABEFB181D0FD;
	Wed, 12 Jun 2024 14:57:46 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com
Subject: [PATCH 3/3] ASoC: imx-audmix: Split capture device for audmix
Date: Wed, 12 Jun 2024 14:40:52 +0800
Message-Id: <1718174452-17596-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: TK362XWNMNI54KAVYNYBH5HW5QWKCXPY
X-Message-ID-Hash: TK362XWNMNI54KAVYNYBH5HW5QWKCXPY
X-MailFrom: shengjiu.wang@nxp.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TK362XWNMNI54KAVYNYBH5HW5QWKCXPY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There will be three devices for this sound card, hw:x,0 is
the playback device for one SAI, hw:x,1 is the playback device
for another SAI, hw:x,2 is the capture device for audmix
output. then capture device and playback device can be configured
with different master/slave mode.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-audmix.c | 79 ++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 2aeb18397bcb..6fbcf33fd0de 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -140,6 +140,13 @@ static const struct snd_soc_ops imx_audmix_be_ops = {
 	.hw_params = imx_audmix_be_hw_params,
 };
 
+static const char *name[][3] = {
+	{"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
+	{"sai-tx", "sai-tx", "sai-rx"},
+	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
+	{"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
+};
+
 static int imx_audmix_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -150,7 +157,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	struct imx_audmix *priv;
 	int i, num_dai, ret;
 	const char *fe_name_pref = "HiFi-AUDMIX-FE-";
-	char *be_name, *be_pb, *be_cp, *dai_name, *capture_dai_name;
+	char *be_name, *dai_name;
 
 	if (pdev->dev.parent) {
 		audmix_np = pdev->dev.parent->of_node;
@@ -183,6 +190,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	num_dai += 1;
 	priv->num_dai = 2 * num_dai;
 	priv->dai = devm_kcalloc(&pdev->dev, priv->num_dai,
 				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
@@ -196,7 +204,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (!priv->dai_conf)
 		return -ENOMEM;
 
-	priv->num_dapm_routes = 3 * num_dai;
+	priv->num_dapm_routes = num_dai;
 	priv->dapm_routes = devm_kcalloc(&pdev->dev, priv->num_dapm_routes,
 					 sizeof(struct snd_soc_dapm_route),
 					 GFP_KERNEL);
@@ -211,8 +219,12 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		if (!dlc)
 			return -ENOMEM;
 
-		ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
-						 &args);
+		if (i == num_dai - 1)
+			ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, 0,
+							 &args);
+		else
+			ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
+							 &args);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "of_parse_phandle_with_args failed\n");
 			return ret;
@@ -226,20 +238,14 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		put_device(&cpu_pdev->dev);
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
-					  fe_name_pref, args.np->full_name + 1);
+					  fe_name_pref, args.np->full_name);
 		if (!dai_name)
 			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
-		if (i == 0) {
+		if (i == num_dai - 1)
 			out_cpu_np = args.np;
-			capture_dai_name =
-				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
-					       dai_name, "CPU-Capture");
-			if (!capture_dai_name)
-				return -ENOMEM;
-		}
 
 		/*
 		 * CPU == Platform
@@ -252,27 +258,23 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dai[i].num_cpus = 1;
 		priv->dai[i].num_codecs = 1;
 		priv->dai[i].num_platforms = 1;
-
-		priv->dai[i].name = dai_name;
+		priv->dai[i].name = name[0][i];
 		priv->dai[i].stream_name = "HiFi-AUDMIX-FE";
 		priv->dai[i].cpus->of_node = args.np;
-		priv->dai[i].cpus->dai_name = dev_name(&cpu_pdev->dev);
+		priv->dai[i].cpus->dai_name = name[1][i];
+
 		priv->dai[i].dynamic = 1;
 		priv->dai[i].dpcm_playback = 1;
-		priv->dai[i].dpcm_capture = (i == 0 ? 1 : 0);
+		if (i == num_dai - 1) {
+			priv->dai[i].dpcm_capture = 1;
+			priv->dai[i].dpcm_playback = 0;
+		}
 		priv->dai[i].ignore_pmdown_time = 1;
 		priv->dai[i].ops = &imx_audmix_fe_ops;
 
 		/* Add AUDMIX Backend */
 		be_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					 "audmix-%d", i);
-		be_pb = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-				       "AUDMIX-Playback-%d", i);
-		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-				       "AUDMIX-Capture-%d", i);
-		if (!be_name || !be_pb || !be_cp)
-			return -ENOMEM;
-
 		priv->dai[num_dai + i].cpus	= &dlc[1];
 		priv->dai[num_dai + i].codecs	= &snd_soc_dummy_dlc;
 
@@ -284,24 +286,33 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dai[num_dai + i].cpus->dai_name = be_name;
 		priv->dai[num_dai + i].no_pcm = 1;
 		priv->dai[num_dai + i].dpcm_playback = 1;
-		priv->dai[num_dai + i].dpcm_capture  = 1;
+		if (i == num_dai - 1) {
+			priv->dai[num_dai + i].dpcm_capture  = 1;
+			priv->dai[num_dai + i].dpcm_playback  = 0;
+		}
 		priv->dai[num_dai + i].ignore_pmdown_time = 1;
 		priv->dai[num_dai + i].ops = &imx_audmix_be_ops;
 
 		priv->dai_conf[i].dlc.of_node = args.np;
 		priv->dai_conf[i].name_prefix = dai_name;
 
-		priv->dapm_routes[i].source =
-			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
-				       dai_name, "CPU-Playback");
-		if (!priv->dapm_routes[i].source)
-			return -ENOMEM;
+		if (i == num_dai - 1) {
+			priv->dapm_routes[i].sink =
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, name[2][i]);
+			if (!priv->dapm_routes[i].sink)
+				return -ENOMEM;
 
-		priv->dapm_routes[i].sink = be_pb;
-		priv->dapm_routes[num_dai + i].source   = be_pb;
-		priv->dapm_routes[num_dai + i].sink     = be_cp;
-		priv->dapm_routes[2 * num_dai + i].source = be_cp;
-		priv->dapm_routes[2 * num_dai + i].sink   = capture_dai_name;
+			priv->dapm_routes[i].source = name[3][i];
+		} else {
+			priv->dapm_routes[i].source =
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, name[3][i]);
+			if (!priv->dapm_routes[i].source)
+				return -ENOMEM;
+
+			priv->dapm_routes[i].sink = name[2][i];
+		}
 	}
 
 	cpu_pdev = of_find_device_by_node(out_cpu_np);
-- 
2.34.1

