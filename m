Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239B0C46CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 13:44:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E947DF2;
	Mon, 18 Sep 2023 15:43:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E947DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695044641;
	bh=rkNK1lKSl8mrVguYpTBfwATzZJymRowUkjzleoBO+hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WISben8vodXUR5NkZYRFpuyoRSqFHIaQWdhlVD4M59a3B53GZtXBLgLfTVRkBPl4H
	 JLwSlp5qJfc/ojSvsBZOgVtAGXn4jm8F9JGIG+fhjMrTy8u7Vbhem08BZUKhSr76Pm
	 sdyJ3+nFbc28pw/2WtMYZFrVs3OiVDdzovwaFcYM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23C1FF805F2; Mon, 18 Sep 2023 15:40:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCFD9F805EE;
	Mon, 18 Sep 2023 15:40:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3DEDF805C2; Mon, 18 Sep 2023 15:40:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D86E8F805AF
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 15:40:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D86E8F805AF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QbU3v/qr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695044435; x=1726580435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkNK1lKSl8mrVguYpTBfwATzZJymRowUkjzleoBO+hM=;
  b=QbU3v/qrWVbmRr/3LzPE5EoeUOD3nt8pJOFKEkI6xI+0UoUdrVgu5yZF
   EZCHbil8cGm0caLhLbUjVW6/i2ivebTPOCpzvSakbCmwgsU0Llw3mBMCQ
   5aYHQ3krcWeIEug7kv4gKVpLxZuggfw2i18bbYFf9qPcbvcsh1Wr/f16C
   +kczWpLt3oOTlFkGL314rteRtUqFxhhE21stpWxjEeW3QUmZoxE6H0pVs
   4pe/f2fyyoLL1D6rAD18X4RDZis4TaxrOsAVAd16oBO49Cfxm4gx0G39K
   3CSQ2aFsfpKz9a00DU1bIed/FxfuV+jMk8Dgs2oibgQDWCllAlKgXLM6W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466003819"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="466003819"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 06:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="745825959"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="745825959"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2023 06:40:22 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 09/17] ASoC: codecs: hda: Switch to new stream-format
 interface
Date: Mon, 18 Sep 2023 15:39:32 +0200
Message-Id: <20230918133940.3676091-10-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918133940.3676091-1-cezary.rojewski@intel.com>
References: <20230918133940.3676091-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UNDVHSIOG3TYLLTZVJ2NBBJV2A53CJBK
X-Message-ID-Hash: UNDVHSIOG3TYLLTZVJ2NBBJV2A53CJBK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UNDVHSIOG3TYLLTZVJ2NBBJV2A53CJBK/>
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

Acked-by: Mark Brown <broonie@kernel.org>
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
index d57b043d6bfe..d2117e36ddd1 100644
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

