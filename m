Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77494C47088
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Dec 2022 17:40:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 389AF17B7;
	Thu,  1 Dec 2022 18:39:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 389AF17B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669916441;
	bh=LHt7/5NJl5Y3NZL5prFvrzhxk9uMSseLqoW3MnyXp1k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahdCmKETXGdJL1CRk6Wg7cfM6MrVlr05H/jIoCOlKTHvfI3j96a+b7qJKPM+sjbvc
	 8iorRfZ17Sr9AegfF2aGk1N7WQJ/sgH8JnTZM2t9JQoXcerXAnY2IJ4jboa4vR1wJQ
	 886ShMtRNovIh1r5zn3LYljzyuoJCPxzaM8AHhR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BAAFF804ED;
	Thu,  1 Dec 2022 18:39:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD993F80559; Thu,  1 Dec 2022 18:39:29 +0100 (CET)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 501DDF80162
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2022 18:39:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 501DDF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="D5iTcbyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669916364; x=1701452364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LHt7/5NJl5Y3NZL5prFvrzhxk9uMSseLqoW3MnyXp1k=;
 b=D5iTcbybJTSYrfOVnowDD/bCusske9XjWy7WgqfPIb7a1Ly4IIbszKRz
 pjtOdbrWYO1C86AubwKG+ioIdV85Fzdap2C4CjSSG4efC2C4B2ddU36ac
 ykfLl+GXimEgGyIGbwi6kME2NC4uY932D/o99Z6bXlh5daQE4Eim5pMNq
 IEVUEozWMxG2JNpv2tNR/9CBjcQZBuakhQoxvr/Z/hratCYT2bEq2dcbG
 E+esRguS/LkuL3nuFtUMCy92goNw+hd4MfsLZZstQWLTpY1bfr2Cd55YX
 3v5YHJHfo/ydYopZgG9jwiUDrcFgRJ8snACoi8aUFPo3QU60FWLrHjKjC g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377908295"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; d="scan'208";a="377908295"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2022 09:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889823904"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; d="scan'208";a="889823904"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2022 09:39:16 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 01/16] ALSA: hda: Allow for compress stream to hdac_ext_stream
 assignment
Date: Thu,  1 Dec 2022 18:56:04 +0100
Message-Id: <20221201175619.504758-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201175619.504758-1-cezary.rojewski@intel.com>
References: <20221201175619.504758-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

Currently only PCM streams can enlist hdac_stream for their data
transfer. Add cstream field to hdac_ext_stream to expose possibility of
compress stream assignment in place of PCM one.
Limited to HOST-type only as there no other users on the horizon.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/hdaudio_ext.h     |  2 ++
 sound/hda/ext/hdac_ext_stream.c | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 68ab89211de2..511211f4a2b6 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -75,6 +75,8 @@ struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type);
 void snd_hdac_ext_stream_release(struct hdac_ext_stream *hext_stream, int type);
+struct hdac_ext_stream *snd_hdac_ext_cstream_assign(struct hdac_bus *bus,
+						    struct snd_compr_stream *cstream);
 void snd_hdac_ext_stream_decouple_locked(struct hdac_bus *bus,
 					 struct hdac_ext_stream *hext_stream, bool decouple);
 void snd_hdac_ext_stream_decouple(struct hdac_bus *bus,
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 2a071a09224d..11b7119cc47e 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -14,6 +14,7 @@
 #include <sound/pcm.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/compress_driver.h>
 
 /**
  * snd_hdac_ext_stream_init - initialize each stream (aka device)
@@ -367,3 +368,43 @@ void snd_hdac_ext_stream_release(struct hdac_ext_stream *hext_stream, int type)
 
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_release);
+
+/**
+ * snd_hdac_ext_cstream_assign - assign a host stream for compress
+ * @bus: HD-audio core bus
+ * @cstream: Compress stream to assign
+ *
+ * Assign an unused host stream for the given compress stream.
+ * If no stream is free, NULL is returned. Stream is decoupled
+ * before assignment.
+ */
+struct hdac_ext_stream *snd_hdac_ext_cstream_assign(struct hdac_bus *bus,
+						    struct snd_compr_stream *cstream)
+{
+	struct hdac_ext_stream *res = NULL;
+	struct hdac_stream *hstream;
+
+	spin_lock_irq(&bus->reg_lock);
+	list_for_each_entry(hstream, &bus->stream_list, list) {
+		struct hdac_ext_stream *hext_stream = stream_to_hdac_ext_stream(hstream);
+
+		if (hstream->direction != cstream->direction)
+			continue;
+
+		if (!hstream->opened) {
+			res = hext_stream;
+			break;
+		}
+	}
+
+	if (res) {
+		snd_hdac_ext_stream_decouple_locked(bus, res, true);
+		res->hstream.opened = 1;
+		res->hstream.running = 0;
+		res->hstream.cstream = cstream;
+	}
+	spin_unlock_irq(&bus->reg_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_cstream_assign);
-- 
2.25.1

