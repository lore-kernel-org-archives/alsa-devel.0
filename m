Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF7C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:36:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5899A20708
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hHQHD4J4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5899A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDEF41614;
	Wed,  8 Jul 2020 22:35:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDEF41614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594240573;
	bh=btvJ/bUe3gcY/QAdXf3Ggcc9btTEeB6nrQk+PmUiwrE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHQHD4J4VgSx8pwiVFqByCho/HHDNDETpKL/YJ38xP6m41YAPv1CFqnWrKJ3MsZiv
	 N0b7y6TgJA7Hcmohh0xAKlmYSDP+PYevThsMWu9n6WEtmAv9JTgyFQrvsI86AUOQTg
	 /yqcZXVPi3OFtclFjWHO9iQL8iSmxIubpJs0TF0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B7DBF802DF;
	Wed,  8 Jul 2020 22:32:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1297CF8015A; Wed,  8 Jul 2020 22:32:45 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2A80F8015D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 22:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2A80F8015D
IronPort-SDR: tHhvWAFHEZGyq9G/N2Mhh/TJaN7yvY9p0MZD+97ip2AxDTz31LOfU7EzRh+sF/2yNHVEUBzx1F
 7Kdyh6CMiayg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="145386993"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; d="scan'208";a="145386993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 13:32:30 -0700
IronPort-SDR: UuJIXiKO+8OnjnSJYa0BCDG4cyaxiySXRAV8SHCWoxZc9EZLXgvCUwM/T0Xnhs5OgQ7wbYTm7c
 /m/6P3N9vRyw==
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; d="scan'208";a="323992703"
Received: from cculman-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.230.50])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 13:32:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 4/4] ASoC: Intel: sdw_max98373: add card_late_probe support
Date: Wed,  8 Jul 2020 15:32:15 -0500
Message-Id: <20200708203215.231776-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708203215.231776-1-pierre-louis.bossart@linux.intel.com>
References: <20200708203215.231776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 randerwang <rander.wang@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: randerwang <rander.wang@linux.intel.com>

Disable Left and Right Spk pin after boot so that sof can get
suspended.

This follows the same logic added to another machine driver with
commit 94d2d0897474 ("ASoC: Intel: Boards: tgl_max98373: add dai_trigger function")

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: randerwang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c          | 19 ++++++++++++++++++-
 sound/soc/intel/boards/sof_sdw_common.h   |  6 ++++++
 sound/soc/intel/boards/sof_sdw_max98373.c | 12 ++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 45be9ec6d4ef..be8eccb50450 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -237,6 +237,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.direction = {true, true},
 		.dai_name = "max98373-aif1",
 		.init = sof_sdw_mx8373_init,
+		.codec_card_late_probe = sof_sdw_mx8373_late_probe,
 	},
 	{
 		.id = 0x5682,
@@ -927,13 +928,29 @@ static int sof_card_dai_links_create(struct device *dev,
 	return 0;
 }
 
+static int sof_sdw_card_late_probe(struct snd_soc_card *card)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(codec_info_list); i++) {
+		if (!codec_info_list[i].late_probe)
+			continue;
+
+		ret = codec_info_list[i].codec_card_late_probe(card);
+		if (ret < 0)
+			return ret;
+	}
+
+	return sof_sdw_hdmi_card_late_probe(card);
+}
+
 /* SoC card */
 static const char sdw_card_long_name[] = "Intel Soundwire SOF";
 
 static struct snd_soc_card card_sof_sdw = {
 	.name = "soundwire",
 	.owner = THIS_MODULE,
-	.late_probe = sof_sdw_hdmi_card_late_probe,
+	.late_probe = sof_sdw_card_late_probe,
 	.codec_conf = codec_conf,
 	.num_configs = ARRAY_SIZE(codec_conf),
 };
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 3f820cf99a89..426017626b16 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -11,6 +11,7 @@
 
 #include <linux/bits.h>
 #include <linux/types.h>
+#include <sound/soc.h>
 
 #define MAX_NO_PROPS 2
 #define MAX_HDMI_NUM 4
@@ -61,6 +62,9 @@ struct sof_sdw_codec_info {
 		     struct snd_soc_dai_link *dai_links,
 		     struct sof_sdw_codec_info *info,
 		     bool playback);
+
+	bool late_probe;
+	int (*codec_card_late_probe)(struct snd_soc_card *card);
 };
 
 struct mc_private {
@@ -114,6 +118,8 @@ int sof_sdw_mx8373_init(const struct snd_soc_acpi_link_adr *link,
 			struct sof_sdw_codec_info *info,
 			bool playback);
 
+int sof_sdw_mx8373_late_probe(struct snd_soc_card *card);
+
 /* RT5682 support */
 int sof_sdw_rt5682_init(const struct snd_soc_acpi_link_adr *link,
 			struct snd_soc_dai_link *dai_links,
diff --git a/sound/soc/intel/boards/sof_sdw_max98373.c b/sound/soc/intel/boards/sof_sdw_max98373.c
index a38ddc099a95..6437872a9b3d 100644
--- a/sound/soc/intel/boards/sof_sdw_max98373.c
+++ b/sound/soc/intel/boards/sof_sdw_max98373.c
@@ -68,7 +68,19 @@ int sof_sdw_mx8373_init(const struct snd_soc_acpi_link_adr *link,
 	if (info->amp_num == 2)
 		dai_links->init = spk_init;
 
+	info->late_probe = true;
+
 	dai_links->ops = &max_98373_sdw_ops;
 
 	return 0;
 }
+
+int sof_sdw_mx8373_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_context *dapm = &card->dapm;
+
+	/* Disable Left and Right Spk pin after boot */
+	snd_soc_dapm_disable_pin(dapm, "Left Spk");
+	snd_soc_dapm_disable_pin(dapm, "Right Spk");
+	return snd_soc_dapm_sync(dapm);
+}
-- 
2.25.1

