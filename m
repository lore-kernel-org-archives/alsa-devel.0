Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9044CC4828D
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:26:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26BE2826;
	Wed,  7 Feb 2024 12:26:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26BE2826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707305210;
	bh=+lBCuozkfb4dH57/mhvItVLQfr5uIzBiLc2iqrYe83Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=A5nCacJRqTReBSS+9MM0ooUNAkX4FbcS7Qj7yPst2PuGCa6agrAZ56AvBnqDL4wrT
	 L/yPFMWPzoN8QySisKCjijZcn65l4RPDa2s/GbeOwKaFcreKd08JF/DbK7wCvsvgt0
	 hLQ57EICo0khgt7zx14dvUUJGSPAB+l/ZltlyDzo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 421FEF805AC; Wed,  7 Feb 2024 12:26:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DDC7BF805AA;
	Wed,  7 Feb 2024 12:26:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A27EF801EB; Wed,  7 Feb 2024 12:26:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 671F2F800E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2024 12:26:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 671F2F800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Wol8qw3r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707305165; x=1738841165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+lBCuozkfb4dH57/mhvItVLQfr5uIzBiLc2iqrYe83Q=;
  b=Wol8qw3r9CzOb8RKwDeFfZ/xcE7lWrQNsaAc6GqEz5iQObgV9yIXvNRN
   qrL6nW0CNqQiB7fyRxj8hcMT0o9sAEu3I+Q1eidYZ1S5FmoCHK0mAR/Mx
   YvdvWpMi0nxst/2srsntiFadTUJ1PaPmF5bthZOyTXuF2SuSwZ6A/LS+8
   QZ6ZQumyw8LKhX03+PF+IqXkK4Z+nrele+6Dxs4m/lxy+RBiCZg6HgDr9
   BDFemlkWhegsVEH+AOKdwEAuBlZzO9tWE6ASztaMb1nufN79l46f+pqQx
   dwwYVgdQT2q3yoknto068/MX0I6k6Mg+K8no7II+H6xAgAXPeINHNJEWN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="858343"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400";
   d="scan'208";a="858343"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2024 03:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400";
   d="scan'208";a="5936191"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2024 03:25:56 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Majczak?= <lma@chromium.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ASoC: Intel: avs: Fix dynamic port assignment when TDM is set
Date: Wed,  7 Feb 2024 12:26:24 +0100
Message-Id: <20240207112624.2132821-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZEHIQO6VANROBBEVFDFPMRGPYIHYP535
X-Message-ID-Hash: ZEHIQO6VANROBBEVFDFPMRGPYIHYP535
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEHIQO6VANROBBEVFDFPMRGPYIHYP535/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In case TDM is set in topology on SSP0, parser will overwrite vindex
value, because it only checks if port is set. Fix this by checking whole
field value.

Fixes: e6d50e474e45 ("ASoC: Intel: avs: Improve topology parsing of dynamic strings")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 778236d3fd280..48b3c67c91032 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -857,7 +857,7 @@ assign_copier_gtw_instance(struct snd_soc_component *comp, struct avs_tplg_modcf
 	}
 
 	/* If topology sets value don't overwrite it */
-	if (cfg->copier.vindex.i2s.instance)
+	if (cfg->copier.vindex.val)
 		return;
 
 	mach = dev_get_platdata(comp->card->dev);
-- 
2.34.1

