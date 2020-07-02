Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E810C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9154A20748
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EdnAIhRl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD4+9+vQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9154A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16BC11677;
	Thu,  2 Jul 2020 03:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16BC11677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593653055;
	bh=rAToyATJmJzHZQyIyJDmhYm9QwhloqEv1gMsff5kCjQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdnAIhRlOcFf7lhEMv9snjiiS5Wir4fU4B4tILeqEjTx1HJQCCCxoFADdL9p+mVbo
	 GOtGifiEQSWK0pMaCyLoTCdwwk3OKHC1lYQGB4jJMpdcp/UhhZjUv9SgRbdDasoJac
	 T3H05+83zbFkH5y51Lo38w0seS8G81211wTAtJzA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AC32F80245;
	Thu,  2 Jul 2020 03:23:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C784CF80252; Thu,  2 Jul 2020 03:23:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A8C5F800ED
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 03:23:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A8C5F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JD4+9+vQ"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06BCD20885;
 Thu,  2 Jul 2020 01:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593652995;
 bh=rAToyATJmJzHZQyIyJDmhYm9QwhloqEv1gMsff5kCjQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JD4+9+vQiP8pNbS3MptY6bz4I0i2X9/nfIPivDcP72sMqCaYIpzkGp00fUF3yCjta
 E5HX5XgDvuQyIIjfAFVINkP4Rf3vqbp49q5SOSLIrJjRKPe1z9WvDPLKcUdqNJF78o
 xmYiW/+20W6yiXPYyTza7E94f1TOTTRiI1vNvr0k=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 16/53] ASoC: hdac_hda: fix memleak with regmap not
 freed on remove
Date: Wed,  1 Jul 2020 21:21:25 -0400
Message-Id: <20200702012202.2700645-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit a94eaccefea1186947c5c5451fcae2245dd7e714 ]

kmemleak throws error reports on module load/unload tests, add
snd_hdac_regmap_exit() in .remove().

While we are at it, also fix the error handling flow in .probe() to
use snd_hdac_regmap_exit() if needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200617164144.17859-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index de003acb1951f..473efe9ef998a 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -441,13 +441,13 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "name failed %s\n", hcodec->preset->name);
-		goto error;
+		goto error_pm;
 	}
 
 	ret = snd_hdac_regmap_init(&hcodec->core);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "regmap init failed\n");
-		goto error;
+		goto error_pm;
 	}
 
 	patch = (hda_codec_patch_t)hcodec->preset->driver_data;
@@ -455,7 +455,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		ret = patch(hcodec);
 		if (ret < 0) {
 			dev_err(&hdev->dev, "patch failed %d\n", ret);
-			goto error;
+			goto error_regmap;
 		}
 	} else {
 		dev_dbg(&hdev->dev, "no patch file found\n");
@@ -467,7 +467,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	ret = snd_hda_codec_parse_pcms(hcodec);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
-		goto error;
+		goto error_regmap;
 	}
 
 	/* HDMI controls need to be created in machine drivers */
@@ -476,7 +476,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		if (ret < 0) {
 			dev_err(&hdev->dev, "unable to create controls %d\n",
 				ret);
-			goto error;
+			goto error_regmap;
 		}
 	}
 
@@ -496,7 +496,9 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 
 	return 0;
 
-error:
+error_regmap:
+	snd_hdac_regmap_exit(hdev);
+error_pm:
 	pm_runtime_put(&hdev->dev);
 error_no_pm:
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
@@ -518,6 +520,8 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+
+	snd_hdac_regmap_exit(hdev);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
-- 
2.25.1

