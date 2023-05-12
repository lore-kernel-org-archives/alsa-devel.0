Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63012C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 18:20:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29397E9D;
	Fri, 12 May 2023 20:19:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29397E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683915617;
	bh=DqoX+I1XAdcSnzKfH3JuoyUpgQ3+T416wika4LyKTc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KmTfUVdZuxLkVXjr59DlXG2felAuihGDpHtC2uz/LOY6svdZ55z2kjVxukmRTObzH
	 3Cm5pNmNRzKuwVi2KdcbgBRH+m7aDRJStgx1vl4SYLAs4P+5MW6xoSjo+PBd8w5J2T
	 stMtton7lymp5CDo6tq0tj2IKquEC8SoqqyU/4Ng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59CBDF805A8; Fri, 12 May 2023 20:17:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4A33F805A8;
	Fri, 12 May 2023 20:17:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DACD9F8052E; Fri, 12 May 2023 20:17:47 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87AABF8052E
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 20:17:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87AABF8052E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O8fmBTWt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683915465; x=1715451465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqoX+I1XAdcSnzKfH3JuoyUpgQ3+T416wika4LyKTc0=;
  b=O8fmBTWtRlGJJvAkHI0lkTYmTPIPX3VFUBWQjD562kNnPuIojvngiqMw
   2ArDG5RnPXacoMFqgmuUigMpV0srhnaJzG8ISz4bbA+AHCrqE1GgZuxMY
   fYnFG+2+mbljpb6Ku5nbsse1gzBjqdfq2BwlSZVaZGPsDKsgfJ8CIrkFm
   GCEe/iN4e9y8Gr5QDqkayAYKC+Qu8aKssRq3A0CyRgtlQAtgZYotjXSxp
   BAhthWtHtZLsX/WcI5gyDThrO60D8Qe2Zw2mwZgdNDJnmZqKa5yKP2oww
   M1uoUQ51afeX/vc0AB8vdHq/5f5SJjFwjuL03j4hGOl/vmYJ0xncFkW0e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331223228"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="331223228"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 11:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="769895093"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="769895093"
Received: from winkelru-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.144.249])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 11:17:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 7/9] ASoC: SOF: Intel: hda-dai: mark functions as
 __maybe_unused
Date: Fri, 12 May 2023 13:17:00 -0500
Message-Id: <20230512181702.117483-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512181702.117483-1-pierre-louis.bossart@linux.intel.com>
References: <20230512181702.117483-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5OVIHB5DNTNKESIHGMXGR6R3OOEVY3I3
X-Message-ID-Hash: 5OVIHB5DNTNKESIHGMXGR6R3OOEVY3I3
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5OVIHB5DNTNKESIHGMXGR6R3OOEVY3I3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

hda_dai_hw_params, hda_dai_trigger(), hda_dai_hw_free are currently
only used for HDaudio codec support, but will be reused for
SSP/DMIC/SoundWire in the LunarLake/ACE2.x case. To avoid 'defined but
not used' errors or added complexity in Kconfig, mark all these
functions as __maybe_used.

When SSP/DMIC/SoundWire are added, some of these changes may be
reverted. For now this avoids compilation warnings.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index cdd842288811..729f750fe746 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -206,7 +206,8 @@ static int hda_link_dma_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int hda_dai_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai)
+static int __maybe_unused hda_dai_hw_free(struct snd_pcm_substream *substream,
+					  struct snd_soc_dai *cpu_dai)
 {
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, cpu_dai);
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -226,9 +227,9 @@ static int hda_dai_hw_free(struct snd_pcm_substream *substream, struct snd_soc_d
 	return hda_link_dma_cleanup(substream, hext_stream, cpu_dai, codec_dai);
 }
 
-static int hda_dai_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
+static int __maybe_unused hda_dai_hw_params(struct snd_pcm_substream *substream,
+					    struct snd_pcm_hw_params *params,
+					    struct snd_soc_dai *dai)
 {
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(dai, substream->stream);
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, dai);
@@ -263,7 +264,8 @@ static int hda_dai_hw_params(struct snd_pcm_substream *substream,
  * In contrast to IPC3, the dai trigger in IPC4 mixes pipeline state changes
  * (over IPC channel) and DMA state change (direct host register changes).
  */
-static int hda_dai_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
+static int __maybe_unused hda_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+					  struct snd_soc_dai *dai)
 {
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, dai);
 	struct hdac_ext_stream *hext_stream;
-- 
2.37.2

