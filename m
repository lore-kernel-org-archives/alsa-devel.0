Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AC0C83F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 09:33:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2FC584B;
	Tue,  5 Sep 2023 11:32:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2FC584B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693906394;
	bh=hUr/8IUGLP5QLAwTrGpuE0VsiSzWyJGARzryW1Gbn34=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bertRCC9SQTJfchJgv8+LPK9xbSjWGSh8rB8unViH9z0ctTZhz/Qi06WKVWU8+nwt
	 gyNIHKKvoowsZHIzm24Tt8Q/UVYrDQBj894IoGBUP88hDPYBd7wPFZggaanFKigyoI
	 CVxRUFX8kbBySNX75y99BQJFXtsSHi/S8yAFu0Vo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD0E5F80494; Tue,  5 Sep 2023 11:31:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72E66F800F5;
	Tue,  5 Sep 2023 11:31:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD8C4F8047D; Tue,  5 Sep 2023 11:31:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 11168F80141
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 11:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11168F80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QQzh+EBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693906311; x=1725442311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hUr/8IUGLP5QLAwTrGpuE0VsiSzWyJGARzryW1Gbn34=;
  b=QQzh+EBsspSr7po/9WOPAcBLuI+lkeCLfP+YaJPmWJxOcdt+wtQyqmo5
   t/S24fvW1ym8QTvEsFfJ9WGCl83jEgpgLO645UNuDG2Qq7KaX++RbD5sE
   i6JIGevF9AZwVBVW5jEl5G33V3zX8B6zkjqyIGlRESw2jBV2N8/ztKGHZ
   1nc5t7suDE4EQohy48wmqr3ZJaQxmtsVVUGGQi9/0YMVNPU8LqOqas/BR
   5BZNFnBGREOg7+vDbu8GlqS453Z3Ow0cWQ+R6S70+H1YlQfIDAlpHoZfo
   pVGf55eRQgmPZIKdeZGsJOCdnErdeEqcVkRdrk1QAiZO5z1/h51D+yi7f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="374141090"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000";
   d="scan'208";a="374141090"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 02:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="1071905173"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000";
   d="scan'208";a="1071905173"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2023 02:31:43 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ASoC: Intel: avs: Provide support for fallback topology
Date: Tue,  5 Sep 2023 11:31:47 +0200
Message-Id: <20230905093147.1960675-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LRQBZDDXO4GGEG3KLUBN554UXZDMAGRK
X-Message-ID-Hash: LRQBZDDXO4GGEG3KLUBN554UXZDMAGRK
X-MailFrom: amadeuszx.slawinski@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LRQBZDDXO4GGEG3KLUBN554UXZDMAGRK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

HDA and HDMI devices are simple enough that in case of user not having
topology tailored to their device, they can use fallback topology.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/pcm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 1fbb2c2fadb5..8565a530706d 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -796,6 +796,28 @@ static int avs_component_probe(struct snd_soc_component *component)
 
 	ret = avs_load_topology(component, filename);
 	kfree(filename);
+	if (ret == -ENOENT && !strncmp(mach->tplg_filename, "hda-", 4)) {
+		unsigned int vendor_id;
+
+		if (sscanf(mach->tplg_filename, "hda-%08x-tplg.bin", &vendor_id) != 1)
+			return ret;
+
+		if (((vendor_id >> 16) & 0xFFFF) == 0x8086)
+			mach->tplg_filename = devm_kasprintf(adev->dev, GFP_KERNEL,
+							     "hda-8086-generic-tplg.bin");
+		else
+			mach->tplg_filename = devm_kasprintf(adev->dev, GFP_KERNEL,
+							     "hda-generic-tplg.bin");
+
+		filename = kasprintf(GFP_KERNEL, "%s/%s", component->driver->topology_name_prefix,
+				     mach->tplg_filename);
+		if (!filename)
+			return -ENOMEM;
+
+		dev_info(card->dev, "trying to load fallback topology %s\n", mach->tplg_filename);
+		ret = avs_load_topology(component, filename);
+		kfree(filename);
+	}
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

