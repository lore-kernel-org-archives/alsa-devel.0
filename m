Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F9EC35242
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:14:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7ABE20838
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TU0c2xjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ABE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13487169B;
	Fri, 24 Jan 2020 20:13:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13487169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579893244;
	bh=qhtZGHoYLQPJ/t7qhul5knFkhdYwjfQp5hyeXgMHA7U=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TU0c2xjXJ2mBv0D5CjvZytSbkpP/WOBpd7MI1XfBwvP+9u9KiKVwYsl6KE5W6+kVK
	 txz7gPtcq96H+r/CbsAQ/p+rfSYT+msUiCLP8R2pMk72X5unkqagv3LsRTMoKJuqqQ
	 P/ZOaUuwj/GGzEttH+0gIv4UlWphKlVvbZNv9/QM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0226F8027D;
	Fri, 24 Jan 2020 20:12:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE812F8025A; Fri, 24 Jan 2020 20:12:08 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C78FAF800DE
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 20:12:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C78FAF800DE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2020 11:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; d="scan'208";a="260337118"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2020 11:04:21 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 24 Jan 2020 20:04:02 +0100
Message-Id: <20200124190413.18154-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124190413.18154-1-cezary.rojewski@intel.com>
References: <20200124190413.18154-1-cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH 01/12] ALSA: hda: Allow for compress stream to
	hdac_ext_stream assignment
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Currently only PCM streams can enlist hdac_stream for their data
transfer. Add cstream field to hdac_ext_stream to expose possibility of
compress stream assignment in place of PCM one.
Limited to HOST-type only.

Rather than copying entire hdac_ext_host_stream_assign, declare separate
PCM and compress wrappers and reuse it for both cases.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/hdaudio.h         |  1 +
 include/sound/hdaudio_ext.h     |  2 ++
 sound/hda/ext/hdac_ext_stream.c | 49 +++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 541ca99b154b..91aabda56c96 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -484,6 +484,7 @@ struct hdac_stream {
 	struct snd_pcm_substream *substream;	/* assigned substream,
 						 * set in PCM open
 						 */
+	struct snd_compr_stream *cstream;
 	unsigned int format_val;	/* format value to be set in the
 					 * controller and the codec
 					 */
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index ef88b20c7b0a..ec01f2024f0b 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -84,6 +84,8 @@ int snd_hdac_ext_stream_init_all(struct hdac_bus *bus, int start_idx,
 		int num_stream, int dir);
 void snd_hdac_stream_free_all(struct hdac_bus *bus);
 void snd_hdac_link_free_all(struct hdac_bus *bus);
+struct hdac_ext_stream *snd_hdac_ext_cstream_assign(struct hdac_bus *bus,
+					   struct snd_compr_stream *cstream);
 struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream,
 					   int type);
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index c4d54a838773..014841a7f966 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -14,6 +14,7 @@
 #include <sound/pcm.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/compress_driver.h>
 
 /**
  * snd_hdac_ext_stream_init - initialize each stream (aka device)
@@ -281,8 +282,7 @@ hdac_ext_link_stream_assign(struct hdac_bus *bus,
 }
 
 static struct hdac_ext_stream *
-hdac_ext_host_stream_assign(struct hdac_bus *bus,
-				struct snd_pcm_substream *substream)
+hdac_ext_host_stream_assign(struct hdac_bus *bus, int direction)
 {
 	struct hdac_ext_stream *res = NULL;
 	struct hdac_stream *stream = NULL;
@@ -296,12 +296,13 @@ hdac_ext_host_stream_assign(struct hdac_bus *bus,
 		struct hdac_ext_stream *hstream = container_of(stream,
 						struct hdac_ext_stream,
 						hstream);
-		if (stream->direction != substream->stream)
+		if (stream->direction != direction)
 			continue;
 
 		if (!stream->opened) {
 			if (!hstream->decoupled)
-				snd_hdac_ext_stream_decouple(bus, hstream, true);
+				snd_hdac_ext_stream_decouple(bus,
+						hstream, true);
 			res = hstream;
 			break;
 		}
@@ -310,13 +311,49 @@ hdac_ext_host_stream_assign(struct hdac_bus *bus,
 		spin_lock_irq(&bus->reg_lock);
 		res->hstream.opened = 1;
 		res->hstream.running = 0;
-		res->hstream.substream = substream;
+		res->hstream.substream = NULL;
+		res->hstream.cstream = NULL;
 		spin_unlock_irq(&bus->reg_lock);
 	}
 
 	return res;
 }
 
+static struct hdac_ext_stream *
+hdac_ext_host_stream_pcm_assign(struct hdac_bus *bus,
+				struct snd_pcm_substream *substream)
+{
+	struct hdac_ext_stream *res;
+
+	res = hdac_ext_host_stream_assign(bus, substream->stream);
+	if (res)
+		res->hstream.substream = substream;
+
+	return res;
+}
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
+					   struct snd_compr_stream *cstream)
+{
+	struct hdac_ext_stream *res;
+
+	res = hdac_ext_host_stream_assign(bus, cstream->direction);
+	if (res)
+		res->hstream.cstream = cstream;
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_cstream_assign);
+
 /**
  * snd_hdac_ext_stream_assign - assign a stream for the PCM
  * @bus: HD-audio core bus
@@ -350,7 +387,7 @@ struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_bus *bus,
 		return hstream;
 
 	case HDAC_EXT_STREAM_TYPE_HOST:
-		return hdac_ext_host_stream_assign(bus, substream);
+		return hdac_ext_host_stream_pcm_assign(bus, substream);
 
 	case HDAC_EXT_STREAM_TYPE_LINK:
 		return hdac_ext_link_stream_assign(bus, substream);
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
