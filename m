Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98849C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245FE2067C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SZIkE1gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245FE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 811821612;
	Mon, 27 Jan 2020 13:16:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 811821612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580127443;
	bh=KM7+a0G9ASW1enpJmogmnBtFW8hiYVmO+FKaEZMIYYI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZIkE1gvcpPHPikD/XPCgHIyqGeqUtdZu/EOdeL9bZGyhg6yXEsLjaKbWQsTQGabs
	 S2PWgiYtndKWHSOG1PqyXQ441xv8COWGyXgV5yE8ePOeaaS2Ezdi6FdBv/KL5Q2npL
	 UNvx79rp+uxQvMUqkI54Tl/2a01CrNkVwbcuBbO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07D00F8028F;
	Mon, 27 Jan 2020 13:13:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4316CF80276; Mon, 27 Jan 2020 13:13:36 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A14B4F80085
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 13:13:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A14B4F80085
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 04:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; d="scan'208";a="261029652"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2020 04:13:28 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 27 Jan 2020 13:12:37 +0100
Message-Id: <20200127121243.15813-6-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127121243.15813-1-cezary.rojewski@intel.com>
References: <20200127121243.15813-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Divya Prakash <divya1.prakash@intel.com>, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org
Subject: [alsa-devel] [PATCH v2 05/11] ALSA: core: Implement compress page
	allocation and free routines
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

Add simple malloc and free methods for memory management for compress
streams. Based on snd_pcm_lib_malloc_pages and snd_pcm_lib_free_pages
implementation.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
---
 include/sound/compress_driver.h |  5 ++++
 sound/core/compress_offload.c   | 42 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 00f633c0c3ba..6ce8effa0b12 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -67,6 +67,7 @@ struct snd_compr_runtime {
  * @metadata_set: metadata set flag, true when set
  * @next_track: has userspace signal next track transition, true when set
  * @private_data: pointer to DSP private data
+ * @dma_buffer: allocated buffer if any
  */
 struct snd_compr_stream {
 	const char *name;
@@ -78,6 +79,7 @@ struct snd_compr_stream {
 	bool metadata_set;
 	bool next_track;
 	void *private_data;
+	struct snd_dma_buffer dma_buffer;
 };
 
 /**
@@ -212,6 +214,9 @@ snd_compr_set_runtime_buffer(struct snd_compr_stream *stream,
 	}
 }
 
+int snd_compr_malloc_pages(struct snd_compr_stream *stream, size_t size);
+int snd_compr_free_pages(struct snd_compr_stream *stream);
+
 int snd_compr_stop_error(struct snd_compr_stream *stream,
 			 snd_pcm_state_t state);
 
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index f34ce564d92c..638c9314284f 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -488,6 +488,48 @@ snd_compr_get_codec_caps(struct snd_compr_stream *stream, unsigned long arg)
 }
 #endif /* !COMPR_CODEC_CAPS_OVERFLOW */
 
+int snd_compr_malloc_pages(struct snd_compr_stream *stream, size_t size)
+{
+	struct snd_dma_buffer *dmab;
+	int ret;
+
+	if (snd_BUG_ON(!(stream) || !(stream)->runtime))
+		return -EINVAL;
+	dmab = kzalloc(sizeof(*dmab), GFP_KERNEL);
+	if (!dmab)
+		return -ENOMEM;
+	dmab->dev = stream->dma_buffer.dev;
+	ret = snd_dma_alloc_pages(dmab->dev.type, dmab->dev.dev, size, dmab);
+	if (ret < 0) {
+		kfree(dmab);
+		return ret;
+	}
+
+	snd_compr_set_runtime_buffer(stream, dmab);
+	stream->runtime->dma_bytes = size;
+	return 1;
+}
+EXPORT_SYMBOL(snd_compr_malloc_pages);
+
+int snd_compr_free_pages(struct snd_compr_stream *stream)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+
+	if (snd_BUG_ON(!(stream) || !(stream)->runtime))
+		return -EINVAL;
+	if (runtime->dma_area == NULL)
+		return 0;
+	if (runtime->dma_buffer_p != &stream->dma_buffer) {
+		/* It's a newly allocated buffer. Release it now. */
+		snd_dma_free_pages(runtime->dma_buffer_p);
+		kfree(runtime->dma_buffer_p);
+	}
+
+	snd_compr_set_runtime_buffer(stream, NULL);
+	return 0;
+}
+EXPORT_SYMBOL(snd_compr_free_pages);
+
 /* revisit this with snd_pcm_preallocate_xxx */
 static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 		struct snd_compr_params *params)
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
