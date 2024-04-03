Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D76CD1294
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:32:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13A8C2C85;
	Wed,  3 Apr 2024 11:31:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13A8C2C85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712136724;
	bh=40mSvovdxw4jGIUnLpVxakwvKHEA8sRzb5ALrIoAwMw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZUgA6oEHzhezjqgLEhkdN+mUER4hYm5fQFbwyu3OciONQnJ6bFWUCZjo1jnAHcH2K
	 Qvaj34TzKSttKuP68c397m0VBhgeJ5p4qB795Q2iEXRi2fsjnpnqK69nBwi1elHbAy
	 FiFLNLpmf8naawB3rMRY3jBv024BIDtQM4Ntr2Nw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26CBFF80236; Wed,  3 Apr 2024 11:31:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D259F8055C;
	Wed,  3 Apr 2024 11:31:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2DE3F8056F; Wed,  3 Apr 2024 11:31:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD905F80130
	for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2024 11:31:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD905F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PirwigBI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136677; x=1743672677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=40mSvovdxw4jGIUnLpVxakwvKHEA8sRzb5ALrIoAwMw=;
  b=PirwigBI1xyBDRvQCYuC5S6wuRoCM+7ajOCj6mQCzB0ODNKjMdE/TcuD
   Ixfg2/3cjETu7xz7b86MsXmescPCkuwtZUDN1ZWmjQIshOGMiaBCS/Rcd
   NNYXb3nGAVkXlJGvv8HLhM/1nKKDQFXeOJcizM8WUUlyaKYc4cTEeCNVK
   VDDTTfNWzZEaRgdAY30ppwhi8lo+yPlIC3zdqaqwvaKHqAnCMS9mYrlTd
   vpY2wh/nIHUvaeRoj1JtA6oNE6zx8VRc9MXDGkQJGfMxeyULQK87REavl
   1NVvF4JL8q3wMHMNjTVxsviJDFxzF0VQSyXFI0JwOXZbWMffB0KTLnD/O
   Q==;
X-CSE-ConnectionGUID: /11g3hbXSmqooQEjoxcTiw==
X-CSE-MsgGUID: byPAZ0ANSOm1Gb2pmtqumw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7218673"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000";
   d="scan'208";a="7218673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 02:31:13 -0700
X-CSE-ConnectionGUID: 0uG/nLzbSla+T6GVNb0Q/g==
X-CSE-MsgGUID: qAX4Qi05TnWODjytcOpwnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000";
   d="scan'208";a="18797531"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa007.jf.intel.com with ESMTP; 03 Apr 2024 02:31:11 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 00/10] Use const where applicable
Date: Wed,  3 Apr 2024 11:31:35 +0200
Message-Id: <20240403093145.3375857-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OSKYXA7CT6TMV4N66XAPIEWYNB4KPIKL
X-Message-ID-Hash: OSKYXA7CT6TMV4N66XAPIEWYNB4KPIKL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OSKYXA7CT6TMV4N66XAPIEWYNB4KPIKL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use devm_kstrdup_const in few places to possibly save a bit of memory.
Mark some of the structs as const, as they are not modified and used as
is.

Amadeusz Sławiński (10):
  ASoC: Intel: avs: hdaudio: Use devm_kstrdup_const
  ASoC: Intel: avs: Use devm_kstrdup_const
  ASoC: Intel: avs: hdaudio: Constify probing_link
  ASoC: Intel: avs: es8336: Constify card_headset_pins
  ASoC: Intel: avs: nau8825: Constify card_headset_pins
  ASoC: Intel: avs: rt274: Constify card_headset_pins
  ASoC: Intel: avs: rt286: Constify card_headset_pins
  ASoC: Intel: avs: rt298: Constify card_headset_pins
  ASoC: Intel: avs: rt5663: Constify card_headset_pins
  ASoC: Intel: avs: rt5682: Constify card_headset_pins

 sound/soc/intel/avs/avs.h            | 2 +-
 sound/soc/intel/avs/boards/es8336.c  | 2 +-
 sound/soc/intel/avs/boards/hdaudio.c | 6 +++---
 sound/soc/intel/avs/boards/nau8825.c | 2 +-
 sound/soc/intel/avs/boards/rt274.c   | 2 +-
 sound/soc/intel/avs/boards/rt286.c   | 2 +-
 sound/soc/intel/avs/boards/rt298.c   | 2 +-
 sound/soc/intel/avs/boards/rt5663.c  | 2 +-
 sound/soc/intel/avs/boards/rt5682.c  | 2 +-
 sound/soc/intel/avs/utils.c          | 8 ++++----
 10 files changed, 15 insertions(+), 15 deletions(-)


base-commit: 36d464cba8bdfd268282a97e9fdc701aca2ed8cb
-- 
2.34.1

