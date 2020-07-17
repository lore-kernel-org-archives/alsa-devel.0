Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB47C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:18:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA14620739
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dF+fKEk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA14620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FCDF1682;
	Fri, 17 Jul 2020 23:17:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FCDF1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595020706;
	bh=LLi7zkxPOrxfoGbGXmRoAgSY09eegKsMbNliK+bz5SI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dF+fKEk2tFSfcjcSSVqeZlnY0Cd15J2HFspPnM0lAkJ+tQQfuS8gtGfVY0PNGE+4t
	 osy3JzXZNmOQKPqFO7PoqYiZ0Z0C7xqSEnb+OBLFpP0nLPCWFYAgZ3XczSWG3BxM2L
	 aiWMQPqTIB8q4HYMHD/DwvMIITOHOTM+KQ9Q8mOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC10DF802BC;
	Fri, 17 Jul 2020 23:15:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29BEEF802BD; Fri, 17 Jul 2020 23:15:35 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44F15F801D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 23:14:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44F15F801D8
IronPort-SDR: /tzlfzPvgbTR6Ws35p/yWXyKpzodklAbhFQLitQmY0WaEvkw/hz+Iv9Z74UYkiyz5q2DtXxHiD
 r3djCzLZCgOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="129758205"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; d="scan'208";a="129758205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 14:13:48 -0700
IronPort-SDR: 3eswPRsuaw94oumJVqd2XGiSPa9h5t2b5ZIcsHTo8wKZ7mA9QJO6wqpzE4MKFzFRqdDfmug7z9
 UCOX4YVWJmfg==
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; d="scan'208";a="282905783"
Received: from toddjdav-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.240])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 14:13:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/6] ASoC: Intel: sof_sdw_rt711: remove properties in card
 remove
Date: Fri, 17 Jul 2020 16:13:33 -0500
Message-Id: <20200717211337.31956-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717211337.31956-1-pierre-louis.bossart@linux.intel.com>
References: <20200717211337.31956-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

The rt711 jack detection properties are set from the machine drivers
during the card probe, as done in other ASoC examples.

KASAN reports a use-after-free error when unbinding drivers due to a
confusing sequence between the ACPI core, the device core and the
SoundWire device cleanups.

Rather than fixing this sequence, follow the recommendation to have
the same caller add and remove properties, add an explicit
device_remove_properties() in the card .remove() callback.

In future patches the use of device_add/remove_properties will be
replaced by a direct handling of a swnode, but the sequence will
remain the same.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c        |  1 +
 sound/soc/intel/boards/sof_sdw_common.h |  1 +
 sound/soc/intel/boards/sof_sdw_rt711.c  | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index be8eccb50450..9b6059905dbe 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -217,6 +217,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.direction = {true, true},
 		.dai_name = "rt711-aif1",
 		.init = sof_sdw_rt711_init,
+		.exit = sof_sdw_rt711_exit,
 	},
 	{
 		.id = 0x1308,
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 426017626b16..c64c5d801d26 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -91,6 +91,7 @@ int sof_sdw_rt711_init(const struct snd_soc_acpi_link_adr *link,
 		       struct snd_soc_dai_link *dai_links,
 		       struct sof_sdw_codec_info *info,
 		       bool playback);
+int sof_sdw_rt711_exit(struct device *dev, struct snd_soc_dai_link *dai_link);
 
 /* RT700 support */
 int sof_sdw_rt700_init(const struct snd_soc_acpi_link_adr *link,
diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
index c8f84e9a3e4e..606009fa3901 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711.c
@@ -133,6 +133,21 @@ static int rt711_rtd_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+int sof_sdw_rt711_exit(struct device *dev, struct snd_soc_dai_link *dai_link)
+{
+	struct device *sdw_dev;
+
+	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL,
+					  dai_link->codecs[0].name);
+	if (!sdw_dev)
+		return -EINVAL;
+
+	device_remove_properties(sdw_dev);
+	put_device(sdw_dev);
+
+	return 0;
+}
+
 int sof_sdw_rt711_init(const struct snd_soc_acpi_link_adr *link,
 		       struct snd_soc_dai_link *dai_links,
 		       struct sof_sdw_codec_info *info,
-- 
2.25.1

