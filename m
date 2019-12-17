Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B82C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0A7207FF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hmUTirzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0A7207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55EA21615;
	Tue, 17 Dec 2019 11:04:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55EA21615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576577121;
	bh=XeZ32v0e6KMZtok/ShOFqwUaQ/d8Y/F5lL6Qp5hfrIU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hmUTirzAMTueakY3U7jmuiMxCssxGjiFioXYCTmTTdG7x577coMV6ixjyKIahGel2
	 R9sVUbF8D1wWbxaprouaa6E/3E9q7iVZcSRVT3esoeK/M7UUZ/RSBhWXBY2Gz0b3hT
	 TjZYFOmnKnTpChwQvQDiNhY/gLXUxt/Kmdy5dJEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C589F802A9;
	Tue, 17 Dec 2019 10:59:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE494F8028B; Tue, 17 Dec 2019 10:59:36 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEB37F80234
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 10:59:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEB37F80234
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 01:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="221717027"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 01:59:28 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 10:58:51 +0100
Message-Id: <20191217095851.19629-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217095851.19629-1-cezary.rojewski@intel.com>
References: <20191217095851.19629-1-cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH 7/7] ASoC: SOF: Intel: Account for compress
	streams when servicing IRQs
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

Update stream irq handler definition to correctly set hdac_stream
current position when servicing stream interrupts for compress streams.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/hdaudio.h          |  1 +
 sound/soc/sof/intel/hda-stream.c | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 9a8bf1eb7d69..9a24d57f0cf2 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -496,6 +496,7 @@ struct hdac_stream {
 	bool locked:1;
 	bool stripe:1;			/* apply stripe control */
 
+	unsigned long curr_pos;
 	/* timestamp */
 	unsigned long start_wallclk;	/* start + minimum wallclk */
 	unsigned long period_wallclk;	/* wallclk for period */
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index c0ab9bb2a797..ddf755a5a730 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -571,6 +571,23 @@ bool hda_dsp_check_stream_irq(struct snd_sof_dev *sdev)
 	return ret;
 }
 
+static void hda_dsp_update_bytes_transferred(struct hdac_stream *hstream,
+					     u64 buffer_size)
+{
+	unsigned int prev_pos;
+	int pos, num_bytes;
+
+	div_u64_rem(hstream->curr_pos, buffer_size, &prev_pos);
+	pos = snd_hdac_stream_get_pos_posbuf(hstream);
+
+	if (pos < prev_pos)
+		num_bytes = (buffer_size - prev_pos) +  pos;
+	else
+		num_bytes = pos - prev_pos;
+
+	hstream->curr_pos += num_bytes;
+}
+
 static bool hda_dsp_stream_check(struct hdac_bus *bus, u32 status)
 {
 	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
@@ -588,14 +605,19 @@ static bool hda_dsp_stream_check(struct hdac_bus *bus, u32 status)
 			snd_hdac_stream_writeb(s, SD_STS, sd_status);
 
 			active = true;
-			if (!s->substream ||
+			if ((!s->substream && !s->cstream) ||
 			    !s->running ||
 			    (sd_status & SOF_HDA_CL_DMA_SD_INT_COMPLETE) == 0)
 				continue;
 
 			/* Inform ALSA only in case not do that with IPC */
-			if (sof_hda->no_ipc_position)
+			if (s->substream && sof_hda->no_ipc_position) {
 				snd_sof_pcm_period_elapsed(s->substream);
+			} else if (s->cstream) {
+				hda_dsp_update_bytes_transferred(s,
+					s->cstream->runtime->buffer_size);
+				snd_compr_fragment_elapsed(s->cstream);
+			}
 		}
 	}
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
