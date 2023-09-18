Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32371CD37B0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 13:43:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40767BC0;
	Mon, 18 Sep 2023 15:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40767BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695044579;
	bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RaPy9vzh702SHV/Ci2SKT12vdQsFq91G6z0lT7zOE3NojB9nRRs5Ds41a81IuDBpB
	 Hh/fpe7akXUjA2zawdRifYpm53Fha47ahxnnHcE6JlZ3GsX9AHDvyP2R2clUMMoKQ9
	 raglW1URxdJQXsa1G8tMh8+JnznlsE2xh1RWBGKw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 991B7F805B1; Mon, 18 Sep 2023 15:40:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A8FAF805C3;
	Mon, 18 Sep 2023 15:40:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D5E5F805AF; Mon, 18 Sep 2023 15:40:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2239F805AF
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 15:40:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2239F805AF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V2Zm+PN7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695044433; x=1726580433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
  b=V2Zm+PN7dELWIine9h38bFbWVRBCq5/zzrnwsSKgqkyBPtVTrfYp4EIA
   seFA6QttV2poHiDD6w8c4sQVT+sA6m4/QAqqEyjKJpj4tYGqP3WGSxT6n
   SM5b6z8JmLfaSZ+sJiesypec98IKBGdPCUb4pzHf0tAmR9H5a9qJF1sut
   gZmB+w7kt0Lhg8XJdSUF21YeYQlRLt134nRrdr7Xs1SeAUEMEDDZW+Hzg
   1scoo/5RGD5xKEQ/QwIgod2gMq5Cso2mA7iqT+EeJA+18rXSZ28N/pSke
   90YEltB8U6Uu4CVQ8kBlMj9Y9Lz5qmVGasozFCXH1OQKaSBd5cOcNqClu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466003785"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="466003785"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 06:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="745825914"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="745825914"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2023 06:40:14 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 06/17] ALSA: hda: Switch to new stream-format interface
Date: Mon, 18 Sep 2023 15:39:29 +0200
Message-Id: <20230918133940.3676091-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918133940.3676091-1-cezary.rojewski@intel.com>
References: <20230918133940.3676091-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NXSRW7DN33G6EZ3RYPJOBMTETT4ZAQFM
X-Message-ID-Hash: NXSRW7DN33G6EZ3RYPJOBMTETT4ZAQFM
X-MailFrom: cezary.rojewski@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NXSRW7DN33G6EZ3RYPJOBMTETT4ZAQFM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To provide option for selecting different bit-per-sample than just the
maximum one, use the new format calculation mechanism.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/pci/hda/hda_controller.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 406779625fb5..0646ef0afd49 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -151,7 +151,7 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int format_val, stream_tag;
+	unsigned int format_val, stream_tag, bps;
 	int err;
 	struct hda_spdif_out *spdif =
 		snd_hda_spdif_out_of_nid(apcm->codec, hinfo->nid);
@@ -165,11 +165,9 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	snd_hdac_stream_reset(azx_stream(azx_dev));
-	format_val = snd_hdac_calc_stream_format(runtime->rate,
-						runtime->channels,
-						runtime->format,
-						hinfo->maxbps,
-						ctls);
+	bps = snd_hdac_stream_format_bps(runtime->format, SNDRV_PCM_SUBFORMAT_STD, hinfo->maxbps);
+
+	format_val = snd_hdac_spdif_stream_format(runtime->channels, bps, runtime->rate, ctls);
 	if (!format_val) {
 		dev_err(chip->card->dev,
 			"invalid format_val, rate=%d, ch=%d, format=%d\n",
-- 
2.25.1

