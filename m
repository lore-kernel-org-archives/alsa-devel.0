Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34926C001DE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 16:55:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0844EAEA;
	Fri, 11 Aug 2023 18:54:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0844EAEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691772914;
	bh=WJ3TCJilsjS4OK8O1CmfN+cDm/YSkU3dXRkVRiXzRjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p7BUeBv5UzVs9CIx9TZ23pVabo875Q4Q3oXbxwZzwY1XiMBxKAlR+7k2P6n6GYMmx
	 3ji8x3+T8/5xwWubruTDuwo0KwRm6tc3oG5J0DiM6sZmp/v8cX1hHnoSmCtlJ6n+4v
	 nufBYkoshvE9sneaAkcAtgagm6Xrud/9pOLP5/OA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E655FF80567; Fri, 11 Aug 2023 18:50:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39BD2F805A8;
	Fri, 11 Aug 2023 18:50:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A605AF8016E; Fri, 11 Aug 2023 18:50:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5FC92F8058C
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 18:49:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FC92F8058C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bKY9MrvF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691772586; x=1723308586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJ3TCJilsjS4OK8O1CmfN+cDm/YSkU3dXRkVRiXzRjc=;
  b=bKY9MrvFGDIh469BusbnPPVfwvNa8GU5ZLcVW9uixiT6Kija44tN9M2r
   p5ztwUdilTYnze9u9BsHybUrH+QFyMulkptpP6tbQ2KhupC480XmsJJw5
   JtsZZ1CTdiXK9hV7PyuCCgzN9q8Pnkky7dSQW71HABsQsf9pjB0p/lpzL
   LH4lXO6dmFjbqTPSVUB1FGbaB8YktJVVFzUv+i/WcuY7YF8NwUjmVNcjr
   /ZwFwcIPJkZ/TG8J0YatouXdG00miCqu/7kA7/Zma6FyO//jC9KjJopUL
   FLQbzLGhUxfqK6wj9+RfThM46CtMwL+AdmYjMSTcjSfaqCb0ODEPQJCCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371725104"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200";
   d="scan'208";a="371725104"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2023 09:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="846842808"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200";
   d="scan'208";a="846842808"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2023 09:49:26 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [RFC PATCH 09/17] ASoC: codecs: hda: Switch to new stream-format
 interface
Date: Fri, 11 Aug 2023 18:48:45 +0200
Message-Id: <20230811164853.1797547-10-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811164853.1797547-1-cezary.rojewski@intel.com>
References: <20230811164853.1797547-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I5BPOQGGHQFMPL3S4AC5YN4C3TVFONC3
X-Message-ID-Hash: I5BPOQGGHQFMPL3S4AC5YN4C3TVFONC3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I5BPOQGGHQFMPL3S4AC5YN4C3TVFONC3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To provide option for selecting different bit-per-sample than just the
maximum one, use the new format calculation mechanism.

While at it, complete PCM stream initialization with subformat options.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/codecs/hda-dai.c | 6 ++++--
 sound/soc/codecs/hda.c     | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hda-dai.c b/sound/soc/codecs/hda-dai.c
index 5371ff086261..20b070c66c6f 100644
--- a/sound/soc/codecs/hda-dai.c
+++ b/sound/soc/codecs/hda-dai.c
@@ -76,13 +76,15 @@ static int hda_codec_dai_prepare(struct snd_pcm_substream *substream, struct snd
 	struct hdac_stream *stream;
 	struct hda_codec *codec;
 	unsigned int format;
+	unsigned int bps;
 	int ret;
 
 	codec = dev_to_hda_codec(dai->dev);
 	stream = substream->runtime->private_data;
 	stream_info = snd_soc_dai_get_dma_data(dai, substream);
-	format = snd_hdac_calc_stream_format(runtime->rate, runtime->channels, runtime->format,
-					     runtime->sample_bits, 0);
+
+	bps = snd_hdac_stream_format_bps(runtime->format, runtime->subformat, stream_info->maxbps);
+	format = snd_hdac_stream_format(runtime->channels, bps, runtime->rate);
 
 	ret = snd_hda_codec_prepare(codec, stream_info, stream->stream_tag, format, substream);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/hda.c b/sound/soc/codecs/hda.c
index 7f53b1981a14..8a9d0674555e 100644
--- a/sound/soc/codecs/hda.c
+++ b/sound/soc/codecs/hda.c
@@ -52,6 +52,7 @@ static int hda_codec_create_dais(struct hda_codec *codec, int pcm_count,
 		stream->channels_max = pcm->stream[dir].channels_max;
 		stream->rates = pcm->stream[dir].rates;
 		stream->formats = pcm->stream[dir].formats;
+		stream->subformats = pcm->stream[dir].subformats;
 		stream->sig_bits = pcm->stream[dir].maxbps;
 
 capture_dais:
@@ -71,6 +72,7 @@ static int hda_codec_create_dais(struct hda_codec *codec, int pcm_count,
 		stream->channels_max = pcm->stream[dir].channels_max;
 		stream->rates = pcm->stream[dir].rates;
 		stream->formats = pcm->stream[dir].formats;
+		stream->subformats = pcm->stream[dir].subformats;
 		stream->sig_bits = pcm->stream[dir].maxbps;
 	}
 
-- 
2.25.1

