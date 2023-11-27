Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AA2C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 13:37:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D3FADFA;
	Mon, 27 Nov 2023 14:37:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D3FADFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701092238;
	bh=XMJbAFksP411ofVpMDO/KVwjonxDCGm52V+AjTcAeY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eMX7MMqoFlON9Y4Dy5EqHXaHGj4yeDxGTn4hKnGuVrRIcjMOEoyJb7JkawzNg54Xr
	 8n8lX48cjuDpOL3sifcI2Khc8q1r3EAJkDb75eeArjmibxJ3riMFgFwy4zt/TXPTnf
	 7rPGgRL8EWC7Um+txZhpgMmSLuKAFlHaL7rHRvU4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B621F805E2; Mon, 27 Nov 2023 14:36:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57D56F805F3;
	Mon, 27 Nov 2023 14:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 919E0F802BE; Mon, 27 Nov 2023 14:36:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41F57F8016E
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 14:35:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41F57F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NEnhoJFd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701092160; x=1732628160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMJbAFksP411ofVpMDO/KVwjonxDCGm52V+AjTcAeY0=;
  b=NEnhoJFdB6kfh1NAERQGlzoGZkQc3xzO7VG3hcPEF+4EJq+EJAcNk8Nh
   8zwIkDQRx2IVUWXCySFRjefXzbxp6f/Lsd9a7p5PEiADNDZ9ocmNPPFzs
   L0eJvbmDzeA9XhMfy43+A/xFJlpVl3DIipld1KXHQdGI+Sc0FPRM6LaSV
   WFkpO2Jf81Q7JUT93RlD5rkoVysrtmWze4kVwgOYj8B17aeX++cKm7UHS
   4G0ts+a7xLhq7OkZFwIUq20L9ytxnu433ym/4ngvNCoHZ0CW3SIUIdMmg
   nTaiZMt6OAR98u4txbvNPvukQgel1TEJ9yShHVDHXkoUddAm3KhcGXvD3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391578531"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="391578531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="891743760"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="891743760"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:34:21 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	cezary.rojewski@intel.com,
	yung-chuan.liao@linux.intel.com,
	ckeepax@opensource.cirrus.com,
	yong.zhi@intel.com,
	chao.song@linux.intel.com
Subject: [PATCH 2/7] ASoC: Intel: sof_sdw: remove unused function declaration
Date: Mon, 27 Nov 2023 15:34:43 +0200
Message-ID: <20231127133448.18449-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127133448.18449-1-peter.ujfalusi@linux.intel.com>
References: <20231127133448.18449-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T6UTXTSC7FDB4OK5ZFBFQ5ETBPXAAUZX
X-Message-ID-Hash: T6UTXTSC7FDB4OK5ZFBFQ5ETBPXAAUZX
X-MailFrom: peter.ujfalusi@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T6UTXTSC7FDB4OK5ZFBFQ5ETBPXAAUZX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Chao Song <chao.song@linux.intel.com>

The functions sof_sdw_rt712_sdca_init() and sof_sdw_rt712_sdca_exit()
declared in header file are never implemented and used, remove them.

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index e6b98523b4e7..9528f147b719 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -138,12 +138,6 @@ int sof_sdw_rt_sdca_jack_init(struct snd_soc_card *card,
 int sof_sdw_rt_sdca_jack_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
 
 /* RT712-SDCA support */
-int sof_sdw_rt712_sdca_init(struct snd_soc_card *card,
-			    const struct snd_soc_acpi_link_adr *link,
-			    struct snd_soc_dai_link *dai_links,
-			    struct sof_sdw_codec_info *info,
-			    bool playback);
-int sof_sdw_rt712_sdca_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
 int sof_sdw_rt712_spk_init(struct snd_soc_card *card,
 			   const struct snd_soc_acpi_link_adr *link,
 			   struct snd_soc_dai_link *dai_links,
-- 
2.43.0

