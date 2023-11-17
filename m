Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D1C197A0
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Nov 2023 12:07:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1CCADFA;
	Fri, 17 Nov 2023 13:06:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1CCADFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700222837;
	bh=gR1Com1eW/AQxEIYG+ZwqjfqB9kT4ltLhiwwtTCtaYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RwVRPzd5EdiaLl0RCP7jDP8/FiFKNmUzz/VtNibkIsX18QQFlp6HBe6DCaIWG+Fd8
	 MljCs9V6NVKb/f8tV2dNlvXsFMgdF44G5FtQ32vrGInE8g9KiaR6VbGbreCybHTGFY
	 NfM9asWuhN/25DH97VM5bjoXW+1U7ebnTLHqPSvk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73D16F805D6; Fri, 17 Nov 2023 13:05:04 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4AC8F805C4;
	Fri, 17 Nov 2023 13:05:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC564F80551; Fri, 17 Nov 2023 13:04:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEAB4F8056F
	for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2023 13:04:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEAB4F8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eXidty9o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700222667; x=1731758667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gR1Com1eW/AQxEIYG+ZwqjfqB9kT4ltLhiwwtTCtaYE=;
  b=eXidty9o/hIqFlYDLEASvcuZ2pp/jFen2ThFZc8rfSytzzqafA8hBllQ
   JuxuWmfS7UIbP++Z/YnQhqHn0TM23KXNl2bSy2LtdFfnZ/Dn6r8XoIF+Q
   kfeLO4McKeyp2iIo6yt8cj6Sdg5VfL1ym0Uxh4d3c0d/K+v3AWv/Y6JbZ
   imfaCyI26bY9PJbNlbX1XjDDJ/6xEWdeFO+D2yc5Usb09/Lm22y2ddxuW
   jDyKa0KQXQ5DI0imKtwAIalcteRrHe8cvZ5etOhikmhz/9Sj7eYdIEkRE
   DsUhBSw6iXiu2RX22JtCmLh4UiA+cGIzGw3aYDxJ2A1ncoh0tQbwPwpG7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381675276"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600";
   d="scan'208";a="381675276"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 04:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883110197"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600";
   d="scan'208";a="883110197"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2023 04:04:23 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 10/16] ASoC: codecs: hdac_hdmi: Switch to new stream-format
 interface
Date: Fri, 17 Nov 2023 13:06:04 +0100
Message-Id: <20231117120610.1755254-11-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117120610.1755254-1-cezary.rojewski@intel.com>
References: <20231117120610.1755254-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WJN2BKAN5ZJOSXXMHHLQM3HAWMUKNINF
X-Message-ID-Hash: WJN2BKAN5ZJOSXXMHHLQM3HAWMUKNINF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJN2BKAN5ZJOSXXMHHLQM3HAWMUKNINF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To provide option for selecting different bit-per-sample than just the
maximum one, use the new format calculation mechanism.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 3e4f632d8665..b3b11225d483 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -468,13 +468,14 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_pcm *pcm;
+	unsigned int bits;
 	int format;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	format = snd_hdac_calc_stream_format(params_rate(hparams),
-			params_channels(hparams), params_format(hparams),
-			dai->driver->playback.sig_bits, 0);
+	bits = snd_hdac_stream_format_bits(params_format(hparams), SNDRV_PCM_SUBFORMAT_STD,
+					   dai->driver->playback.sig_bits);
+	format = snd_hdac_stream_format(params_channels(hparams), bits, params_rate(hparams));
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
 	if (!pcm)
-- 
2.25.1

