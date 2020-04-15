Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2BDC2BB1D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:06:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B7120678
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RVJu9kig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B7120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 123EB1614;
	Wed, 15 Apr 2020 05:05:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 123EB1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586919991;
	bh=JiDTU113TLqBt/29YQpTqi6N7IfnQRaumFQ5gKlaJbs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RVJu9kigk5rmquvUhBYWg9bHpSPKZTqs3nyIYc/btlBGjomMLkOBVK41tDHBTRILY
	 rfrCt/KA7iFh4lsTzmDAOsOYWwDMzA0G7QFu1mj8LxAcztTTXvIpgO2rBewpcbqsTv
	 ZmiX0UBx3VrkPMPtC8FqBJ1T3x5icQXeV17ceE5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FEFFF80229;
	Wed, 15 Apr 2020 05:05:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87243F800ED; Wed, 15 Apr 2020 05:04:55 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97D43F80124
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 05:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97D43F80124
IronPort-SDR: Q+ybTRAyK2FN1DK+tJb4cTyUreHbRvi2+wiBDDvUcaJ3Hhyr+bzv84DnSWxexFeBOcIO/JQiNj
 qzOBtYg1jouQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 20:04:46 -0700
IronPort-SDR: k13gwpNachUvWNZnqWP1YowJ/ySmFyy5caWQHW40jfrrS4ag6t2WWMONBaiz3OcURxOtmBbZo5
 vCIgkvx3QvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="332370012"
Received: from dweeratu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.109.154])
 by orsmga001.jf.intel.com with ESMTP; 14 Apr 2020 20:04:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC TEST] ASoC: soc-dai: revert all changes to DAI startup/shutdown
 sequence
Date: Tue, 14 Apr 2020 22:04:37 -0500
Message-Id: <20200415030437.23803-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Baytrail/Cherrytrail, the Atom/SST driver fails miserably:

[    9.741953] intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
[    9.832992] intel_sst_acpi 80860F28:00: FW sent error response 0x40034
[    9.833019] intel_sst_acpi 80860F28:00: FW alloc failed ret -4
[    9.833028] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[    9.833033] sst-mfld-platform sst-mfld-platform: ASoC: DAI prepare error: -5
[    9.833037]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port failed
[    9.853942] intel_sst_acpi 80860F28:00: FW sent error response 0x40034
[    9.853974] intel_sst_acpi 80860F28:00: FW alloc failed ret -4
[    9.853984] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[    9.853990] sst-mfld-platform sst-mfld-platform: ASoC: DAI prepare error: -5
[    9.853994]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port failed

Commit b56be800f1292 ("ASoC: soc-pcm: call
snd_soc_dai_startup()/shutdown() once") was the initial problematic
commit.

Commit 1ba616bd1a6d5e ("ASoC: soc-dai: fix DAI startup/shutdown sequence")
was an attempt to fix things but it does not work on Baytrail,
reverting all changes seems necessary for now.

Fixes: 1ba616bd1a6d5e ("ASoC: soc-dai: fix DAI startup/shutdown sequence")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

Sending as RFC since I don't have a good understanding of the
root-cause and for others to confirm my findings. Tested on top of
v5.7-rc1.

 include/sound/soc-dai.h |  1 -
 sound/soc/soc-dai.c     | 11 ++---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index d4825b82c7a3..b33abe93b905 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -351,7 +351,6 @@ struct snd_soc_dai {
 
 	/* bit field */
 	unsigned int probed:1;
-	unsigned int started[SNDRV_PCM_STREAM_LAST + 1];
 };
 
 static inline struct snd_soc_pcm_stream *
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 8f3cad8db89a..31c41559034b 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -295,24 +295,17 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
 {
 	int ret = 0;
 
-	if (!dai->started[substream->stream] &&
-	    dai->driver->ops->startup)
+	if (dai->driver->ops->startup)
 		ret = dai->driver->ops->startup(substream, dai);
 
-	if (ret == 0)
-		dai->started[substream->stream] = 1;
-
 	return ret;
 }
 
 void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 			 struct snd_pcm_substream *substream)
 {
-	if (dai->started[substream->stream] &&
-	    dai->driver->ops->shutdown)
+	if (dai->driver->ops->shutdown)
 		dai->driver->ops->shutdown(substream, dai);
-
-	dai->started[substream->stream] = 0;
 }
 
 int snd_soc_dai_prepare(struct snd_soc_dai *dai,
-- 
2.20.1

