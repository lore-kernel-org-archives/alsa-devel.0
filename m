Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF440EE49A0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 08:09:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC73B85D;
	Wed, 23 Aug 2023 10:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC73B85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692778158;
	bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ladYLmZxPrjoCbIHekmHVDXVrEuI/8umQlr5J4gHVksXfgWyo9wUuihUzXVp8sf8X
	 51TdBn2TaSrfTrj3+D+MeK56WYHS+VYFF+7H0iRS66JMBtoKqEk+KacmWXVNl0x4JP
	 b99A3NHnf4jQ3K4BmtZOf7qrik5G4FugXtqDfJAo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90F3AF8056F; Wed, 23 Aug 2023 10:07:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10E32F80570;
	Wed, 23 Aug 2023 10:07:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 716C9F80536; Wed, 23 Aug 2023 10:06:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05F89F8025F
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 10:06:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05F89F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jNMIXRY+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692777981; x=1724313981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk101+Pz+wVeoUEp8O7sm38EcYYseJljCF2jp3GvBj8=;
  b=jNMIXRY+5BOk4EJIHauQGX2rpNLFMB7mJs9JsA3uwobZqi6vU7ENJVWq
   rJpye/RcDuXfA0xsxwSY2/dcSs7f2BtI+nfIkwdCe2JpZNkxHavMbZ/+T
   yZsAUNqw+i8ORNyOnT7759IAR+YQ/zlR55HEy100z/FPUQxOMbtLm2YT+
   2b86BscJw+HtpiSkGQ4F63fzk1m6BoFrZqEHEJfGwhv2mI0PxOcPQjxC+
   bAe63QhdC53EbrqbWjUGR5AwuQp7e/FA1yQmFJHn5+JB7xD5KEkzFTbhz
   4KnF6VIUE7+rzcKie3fmkZR0wrZ2CERjdatC62BUXWAPt6KltW6cwwteg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372988061"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200";
   d="scan'208";a="372988061"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2023 01:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="766042697"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200";
   d="scan'208";a="766042697"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2023 01:06:16 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 06/17] ALSA: hda: Switch to new stream-format interface
Date: Wed, 23 Aug 2023 10:05:35 +0200
Message-Id: <20230823080546.2224713-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823080546.2224713-1-cezary.rojewski@intel.com>
References: <20230823080546.2224713-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DV4URX6JVMJ4T5PWDIJQDURLQUEJGM2M
X-Message-ID-Hash: DV4URX6JVMJ4T5PWDIJQDURLQUEJGM2M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DV4URX6JVMJ4T5PWDIJQDURLQUEJGM2M/>
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

