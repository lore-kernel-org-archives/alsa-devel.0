Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04086C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 11:12:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20DD0221B;
	Wed,  8 Dec 2021 12:11:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20DD0221B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638961952;
	bh=syWY4dnCaPI5Njdfvl1Sa+8eHtkoeXu+lZfkZAHiFaY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTweaO1hdesCDqYJigu1rdb4azxUuUkS4RitYhi1ei8RC0kkt54pTe9Ubw81K50Hs
	 ZNJ5EoAJ7opCccCCLeN3Zmfok0Mad7xbAsWZjIWFjrGO/6ZXHo1akSuNdSeGHGzDeh
	 vfDHyqyIyJh7WEzk7/r1bwSOAWNjG5AHH75QkZr4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5DC9F804F2;
	Wed,  8 Dec 2021 12:11:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFA15F804F3; Wed,  8 Dec 2021 12:11:02 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5C82F80103
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 12:10:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5C82F80103
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301192800"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; d="scan'208";a="301192800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 03:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; d="scan'208";a="600600052"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2021 03:10:49 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC 01/37] ALSA: hda: Add snd_hdac_ext_bus_link_at() helper
Date: Wed,  8 Dec 2021 12:12:25 +0100
Message-Id: <20211208111301.1817725-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208111301.1817725-1-cezary.rojewski@intel.com>
References: <20211208111301.1817725-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 harshapriya.n@intel.com, yung-chuan.liao@linux.intel.com, rad@semihalf.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 broonie@kernel.org, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 peter.ujfalusi@linux.intel.com, lma@semihalf.com
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

This patch exposes a new helper to directly retrieve the link from the
codec address, and makes use of this helper when retrieving the link
from the codec name.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 31 +++++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index d4e31ea16aba..8b7ee918f540 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -28,6 +28,7 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_bus *chip,
 				 bool enable, int index);
 
 int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_bus *bus);
+struct hdac_ext_link *snd_hdac_ext_bus_link_at(struct hdac_bus *bus, int addr);
 struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_bus *bus,
 						const char *codec_name);
 
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index b2df7b4f9227..b072392725c7 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -132,6 +132,26 @@ void snd_hdac_link_free_all(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_link_free_all);
 
+/**
+ * snd_hdac_ext_bus_link_at - get link at specified address
+ * @bus: link's parent bus device
+ * @addr: codec device address
+ *
+ * Returns link object or NULL if matching link is not found.
+ */
+struct hdac_ext_link *snd_hdac_ext_bus_link_at(struct hdac_bus *bus, int addr)
+{
+	struct hdac_ext_link *hlink;
+	int i;
+
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		for (i = 0; i < HDA_MAX_CODECS; i++)
+			if (hlink->lsdiid & (0x1 << addr))
+				return hlink;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_at);
+
 /**
  * snd_hdac_ext_bus_get_link - get link based on codec name
  * @bus: the pointer to HDAC bus object
@@ -140,8 +160,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_link_free_all);
 struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_bus *bus,
 						 const char *codec_name)
 {
-	int i;
-	struct hdac_ext_link *hlink = NULL;
 	int bus_idx, addr;
 
 	if (sscanf(codec_name, "ehdaudio%dD%d", &bus_idx, &addr) != 2)
@@ -151,14 +169,7 @@ struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_bus *bus,
 	if (addr < 0 || addr > 31)
 		return NULL;
 
-	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		for (i = 0; i < HDA_MAX_CODECS; i++) {
-			if (hlink->lsdiid & (0x1 << addr))
-				return hlink;
-		}
-	}
-
-	return NULL;
+	return snd_hdac_ext_bus_link_at(bus, addr);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_link);
 
-- 
2.25.1

