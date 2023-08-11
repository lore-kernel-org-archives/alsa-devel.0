Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42623C41513
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 16:52:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78EC7950;
	Fri, 11 Aug 2023 18:51:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78EC7950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691772756;
	bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DXcQigpxCwtIzLdP6lRFToWtuTfVcaNhr5kANeva44CT/0EbAcoJnbPRhGJukFBJr
	 n3pOtb1iJwXcqomiwbH7r0yoZKjfX5vZL2YEQdxi9xpdDcIIDN+bKQOkVL/Fix9jbI
	 /6fef5POBK10hY5/Fn27bTyBa+oGWIHtrpfay6As=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0924F805DA; Fri, 11 Aug 2023 18:50:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E07EF805D6;
	Fri, 11 Aug 2023 18:49:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 782C0F805BD; Fri, 11 Aug 2023 18:49:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0D4D6F805AC
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 18:49:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D4D6F805AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eDCqLwig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691772584; x=1723308584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
  b=eDCqLwig4Q18oD4jtaqbxrl91pJcWMN2cYtFPWo9qbGptX4eejRnkOkF
   pc31eKC5FaT0g5PX984vWqHIuUwE4FM+5bxM+kTIUdP/Qfgqb2Y4WkjjB
   XePXSsQrunXQS826Bjs9mjlg30xu3tKTKfuu1WbxkAYUVn72yhZCWv03q
   h8l2LWQSECEJIBVUfuqFlFstgEcm42rHIMLB+dp9Cj1Z8H7Oj/kgM4q/r
   WO75BfBRjZeqne23yNy0CSv4TPkS4uY/PiwKj0R/k+g2sprcburXoR+U6
   kB7h6lyzgHQjb/vQtuALuSadBBEkUxfE9nJmdRYAoUaLwNHcBsAjyW0Pl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371725064"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200";
   d="scan'208";a="371725064"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2023 09:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="846842786"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200";
   d="scan'208";a="846842786"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2023 09:49:20 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [RFC PATCH 06/17] ALSA: hda: Switch to new stream-format interface
Date: Fri, 11 Aug 2023 18:48:42 +0200
Message-Id: <20230811164853.1797547-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811164853.1797547-1-cezary.rojewski@intel.com>
References: <20230811164853.1797547-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MSORA2H2ZUPVFKIFA46A75I6JFZ2W3YU
X-Message-ID-Hash: MSORA2H2ZUPVFKIFA46A75I6JFZ2W3YU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MSORA2H2ZUPVFKIFA46A75I6JFZ2W3YU/>
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

