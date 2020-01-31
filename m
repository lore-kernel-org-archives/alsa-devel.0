Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0615AC33CB2
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85582206F0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hbWq0BU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85582206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2DD71693;
	Fri, 31 Jan 2020 13:33:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2DD71693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580474057;
	bh=L/eZyvWc9xaSqklRpGiGcZpWxw9EnmOheCyXz1iD0UU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hbWq0BU5KyO+rC/phjahn81SmGZTIibendDihnDLCwHRJ+UjGTErhkBUxcdAnvrqh
	 XndEsFfWYXnFYlyolef2FY1j6YTpwww//kfLihmosFun2hQRVZtG3eKn/fp6TdCgVU
	 45ghRA0jwicLoH1S2/3pxHHJ0+bwCuwHeQipSM38=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86958F80273;
	Fri, 31 Jan 2020 13:31:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C6D2F8023F; Fri, 31 Jan 2020 13:31:45 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EE9EF8021E
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 13:31:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE9EF8021E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 04:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="262532361"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2020 04:31:36 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 31 Jan 2020 13:31:06 +0100
Message-Id: <20200131123115.14247-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131123115.14247-1-cezary.rojewski@intel.com>
References: <20200131123115.14247-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
 tiwai@suse.com, vkoul@kernel.org, broonie@kernel.org
Subject: [alsa-devel] [PATCH v4 02/11] ALSA: hda: Prepare for compress
	stream support
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

Before introducing compress specific changes, adjust BDL and parameters
setup functions so these are not tightly coupled with PCM streams.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_stream.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 682ed39f79b0..5259cf366011 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -408,11 +408,15 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 {
 	struct hdac_bus *bus = azx_dev->bus;
 	struct snd_pcm_substream *substream = azx_dev->substream;
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime;
+	struct snd_dma_buffer *dmab;
 	__le32 *bdl;
 	int i, ofs, periods, period_bytes;
 	int pos_adj, pos_align;
 
+	runtime = substream->runtime;
+	dmab = snd_pcm_get_dma_buf(substream);
+
 	/* reset BDL address */
 	snd_hdac_stream_writel(azx_dev, SD_BDLPL, 0);
 	snd_hdac_stream_writel(azx_dev, SD_BDLPU, 0);
@@ -426,7 +430,7 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 	azx_dev->frags = 0;
 
 	pos_adj = bus->bdl_pos_adj;
-	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
+	if (runtime && !azx_dev->no_period_wakeup && pos_adj > 0) {
 		pos_align = pos_adj;
 		pos_adj = (pos_adj * runtime->rate + 47999) / 48000;
 		if (!pos_adj)
@@ -440,8 +444,7 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 				 pos_adj);
 			pos_adj = 0;
 		} else {
-			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
-					 azx_dev,
+			ofs = setup_bdle(bus, dmab, azx_dev,
 					 &bdl, ofs, pos_adj, true);
 			if (ofs < 0)
 				goto error;
@@ -451,13 +454,11 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 
 	for (i = 0; i < periods; i++) {
 		if (i == periods - 1 && pos_adj)
-			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
-					 azx_dev, &bdl, ofs,
-					 period_bytes - pos_adj, 0);
+			ofs = setup_bdle(bus, dmab, azx_dev,
+					 &bdl, ofs, period_bytes - pos_adj, 0);
 		else
-			ofs = setup_bdle(bus, snd_pcm_get_dma_buf(substream),
-					 azx_dev, &bdl, ofs,
-					 period_bytes,
+			ofs = setup_bdle(bus, dmab, azx_dev,
+					 &bdl, ofs, period_bytes,
 					 !azx_dev->no_period_wakeup);
 		if (ofs < 0)
 			goto error;
@@ -482,26 +483,25 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_setup_periods);
 int snd_hdac_stream_set_params(struct hdac_stream *azx_dev,
 				 unsigned int format_val)
 {
-
-	unsigned int bufsize, period_bytes;
 	struct snd_pcm_substream *substream = azx_dev->substream;
-	struct snd_pcm_runtime *runtime;
+	unsigned int bufsize, period_bytes;
+	unsigned int no_period_wakeup;
 	int err;
 
 	if (!substream)
 		return -EINVAL;
-	runtime = substream->runtime;
 	bufsize = snd_pcm_lib_buffer_bytes(substream);
 	period_bytes = snd_pcm_lib_period_bytes(substream);
+	no_period_wakeup = substream->runtime->no_period_wakeup;
 
 	if (bufsize != azx_dev->bufsize ||
 	    period_bytes != azx_dev->period_bytes ||
 	    format_val != azx_dev->format_val ||
-	    runtime->no_period_wakeup != azx_dev->no_period_wakeup) {
+	    no_period_wakeup != azx_dev->no_period_wakeup) {
 		azx_dev->bufsize = bufsize;
 		azx_dev->period_bytes = period_bytes;
 		azx_dev->format_val = format_val;
-		azx_dev->no_period_wakeup = runtime->no_period_wakeup;
+		azx_dev->no_period_wakeup = no_period_wakeup;
 		err = snd_hdac_stream_setup_periods(azx_dev);
 		if (err < 0)
 			return err;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
