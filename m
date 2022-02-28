Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578EFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 15:33:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FC2E1799;
	Mon, 28 Feb 2022 16:32:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FC2E1799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646062429;
	bh=QNbaP/oF5MSvyVa7b1ZwpSHP0ZZkFymWzIp6uBxLijc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rsgw2QBi95tQIp5I/Lg4akJyoVkz0O6kVYbieNINxN4RR2f4bBOhsYRxTJqnXcldM
	 wHi367lALXOButfnLSTq2RTgM9F5ezMpMgnWbc/MTqau2GnK3fr64M25TbNgCYKo4j
	 MP9OTFV7jsvoCIIeaDlsq0fI0Xu9GRNopubkDpWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18CAAF8025C;
	Mon, 28 Feb 2022 16:31:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3A0CF80128; Mon, 28 Feb 2022 16:31:53 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0411EF80128
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 16:31:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0411EF80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="YvKStwy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646062305; x=1677598305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QNbaP/oF5MSvyVa7b1ZwpSHP0ZZkFymWzIp6uBxLijc=;
 b=YvKStwy+az4YHHJjxOGiunrQm36SgJoJZSz3oxDWPafVRwLG4tFf37+u
 2G+dbQmpBoxcLl1Y6/hepJIAptDQMezyUhcxzwKSASqFRztODi1E5Ry+K
 3TVUizJjHHUz3Q/mjujUeO8U3YwIDAe06lJVpOK8Q+M9VKQwChdyE2yVF
 2/6v2rHkL7Q6AbZMluzd7uCy3OeZyEXaVA+JkJLV8UjoD78JeF/Fih6bo
 s8hfJehIRsBqOMxiqQGiYZEYJYu0034R95Rwd4YvZQw1pFxvqnOAl0usl
 /S1VI+IMuH/dvKZBbWi+4vcAeVycL+2jRQ3W7cvd+45eNnUVluBVq3GU9 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="339342342"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="339342342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 07:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="629667148"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2022 07:31:37 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 02/17] ASoC: Export DAI register and widget ctor and dctor
 functions
Date: Mon, 28 Feb 2022 16:33:28 +0100
Message-Id: <20220228153343.2263412-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228153343.2263412-1-cezary.rojewski@intel.com>
References: <20220228153343.2263412-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, rad@semihalf.com,
 upstream@semihalf.com, harshapriya.n@intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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

To allow for more flexibility i.e. populating component DAIs dynamically
during its initialization, without being limited to topology loading
procedure, expose snd_soc_register(), snd_soc_dapm_new_dai_widgets() and
snd_soc_dapm_free_widget() functions.

Allows users to first check available resources e.g. number of PCMs
supported by HDAudio codec before allocating the number of DAPM
widgets needed. This prevents superfluous objects from being created or
allows driver to adjust to situation when resources are limited.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/soc-dapm.h |  1 +
 sound/soc/soc-core.c     |  1 +
 sound/soc/soc-dapm.c     | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c3039e97929a..ebb8e7a7fc29 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -429,6 +429,7 @@ struct snd_soc_dapm_widget *snd_soc_dapm_new_control_unlocked(
 		const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
+void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a088bc9f7dd7..ce153ac2c3ab 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2465,6 +2465,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 	dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
 	return dai;
 }
+EXPORT_SYMBOL_GPL(snd_soc_register_dai);
 
 /**
  * snd_soc_unregister_dais - Unregister DAIs from the ASoC core
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b06c5682445c..b435b5c4cfb7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2484,6 +2484,12 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	kfree(path);
 }
 
+/**
+ * snd_soc_dapm_free_widget - Free specified widget
+ * @w: widget to free
+ *
+ * Removes widget from all paths and frees memory occupied by it.
+ */
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *p, *next_p;
@@ -2506,6 +2512,7 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 	kfree_const(w->sname);
 	kfree(w);
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_free_widget);
 
 void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm)
 {
@@ -4208,6 +4215,13 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card,
 	return ERR_PTR(ret);
 }
 
+/**
+ * snd_soc_dapm_new_dai_widgets - Create new DAPM widgets
+ * @dapm: DAPM context
+ * @dai: parent DAI
+ *
+ * Returns 0 on success, error code otherwise.
+ */
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai)
 {
@@ -4253,6 +4267,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_dai_widgets);
 
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 {
-- 
2.25.1

