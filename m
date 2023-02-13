Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B72BC636D4
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Feb 2023 12:52:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD26E20B;
	Mon, 13 Feb 2023 13:52:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD26E20B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676292773;
	bh=SqUSc0xFa6eoBF99+TocfgxvHOe2xZ/W1XkwGdDE6as=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iMDwFibbKY8IsOERAbmU9zGTXw4/9ekHmjvCJPtREyET/XnkoFpSTYgMGlYZ4QtM8
	 9aDooX+UJNotiWijT1sHQlIXFafxZ8s4v4xOUkXyFq5/AxhvZshurK2yptmnVTi9vf
	 EYScW9hpLgDjDiB+4rJDHIDkUPGUCAEphnXs6Blc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 46867F8001E;
	Mon, 13 Feb 2023 13:51:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA114F804B4; Mon, 13 Feb 2023 13:51:35 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 04085F800B0
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2023 13:51:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04085F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FitqmEcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676292689; x=1707828689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SqUSc0xFa6eoBF99+TocfgxvHOe2xZ/W1XkwGdDE6as=;
  b=FitqmEcA9hiKyZiYnvJefEnzOmxuk3onQ9l23mdBu8kOks2y/zrrUq6S
   91ywv3YkuYzYZjXCo7119MkcVmp0gZ5WB+H7dnD4/0w8MCut9Y8MF+ZHy
   Pl+knSK7rPF5bxYsI5EeMsEdF86FZ6oBj9cT5hxT00ivyhFFfzYfHt8Vy
   qW1Cqr4AtZTyaDT0kQA4lZnNDtlOEC/1ansIMkEuc2t731algcLpcrtQY
   Xkp9kz15T0jFdSScob4+aPv0/AkwNpt6BR9K5m9xBR4qMhW28Eme0lZZs
   JOYK3jtjRt8G3tNIuB0k5qmzFlp/6Nd9fPvI6r1JRuLcD+Czwg6l6ZW2m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="330887230"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000";
   d="scan'208";a="330887230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2023 04:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="699170321"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000";
   d="scan'208";a="699170321"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2023 04:51:21 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: Skylake: Fix struct definition
Date: Mon, 13 Feb 2023 21:52:23 +0100
Message-Id: <20230213205223.2679357-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IYCJDQBJIGWAITJWJWPEAXBXM7KHOB37
X-Message-ID-Hash: IYCJDQBJIGWAITJWJWPEAXBXM7KHOB37
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Sasa Ostrouska <casaxa@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYCJDQBJIGWAITJWJWPEAXBXM7KHOB37/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1]. In this instance, struct
skl_cpr_cfg contains struct skl_cpr_gtw_cfg, which defined "config_data"
as a 1-element array.

However, case present in sound/soc/intel/skylake/skl-topology.h is not a
simple one as the structure takes part in IPC communication. Apparently
original definition missed one field, which while not used by AudioDSP
firmware when there is no additional data, is still expected to be part
of an IPC message. Currently this works because of how 'config_data' is
declared: 'config_data[1]'. Now when one replaces it with a flexible
array there would be one field missing. Update struct declaration to fix
this.

Reported-by: Sasa Ostrouska <casaxa@gmail.com>
Link: https://lore.kernel.org/all/CALFERdwvq5day_sbDfiUsMSZCQu9HG8-SBpOZDNPeMdZGog6XA@mail.gmail.com/
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org
CC: Kees Cook <keescook@chromium.org>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-topology.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 5ab0917a2b3d..d31509298a0a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -549,7 +549,7 @@ static void skl_copy_copier_caps(struct skl_module_cfg *mconfig,
 	if (mconfig->formats_config[SKL_PARAM_INIT].caps_size == 0)
 		return;
 
-	memcpy(cpr_mconfig->gtw_cfg.config_data,
+	memcpy(&cpr_mconfig->gtw_cfg.config_data,
 			mconfig->formats_config[SKL_PARAM_INIT].caps,
 			mconfig->formats_config[SKL_PARAM_INIT].caps_size);
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6db0fd7bad49..30a0977af943 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -115,7 +115,10 @@ struct skl_cpr_gtw_cfg {
 	u32 dma_buffer_size;
 	u32 config_length;
 	/* not mandatory; required only for DMIC/I2S */
-	u32 config_data[1];
+	struct {
+		u32 gtw_attrs;
+		u32 data[];
+	} config_data;
 } __packed;
 
 struct skl_dma_control {
-- 
2.34.1

