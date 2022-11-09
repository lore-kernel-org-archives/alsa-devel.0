Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F771C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Nov 2022 06:53:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D60615CA;
	Thu, 10 Nov 2022 07:52:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D60615CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668063225;
	bh=c/DQyuJrqj3A3rcH2mu7EKu6GdPoG+wZ+dPrb8sqJoU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XiyMU1hHuNYq5dKd3m9H9seHhDxL/d1eiuoKTVsxhZP0SZg3dDCuIOA58mXtolDT8
	 kyLIz8g/VIqETUEb9RWOAhOsB/Pd3nDtD1G+9XYbz5Fg6dAMacfDMJ4Lmu9cpaH5Hj
	 lu1XyiSF17CIq7khqFX/7KVR+2D5zp/sK5klFm8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15280F80162;
	Thu, 10 Nov 2022 07:52:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DEF5F80217; Thu, 10 Nov 2022 00:49:43 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9046BF80121
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2022 00:49:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9046BF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="nQLY707j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668037777; x=1699573777;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c/DQyuJrqj3A3rcH2mu7EKu6GdPoG+wZ+dPrb8sqJoU=;
 b=nQLY707jYOmeHySXiAzHeYLxKBMqnFbRAzTl5XDaGR9kO6rBurq39Z53
 0y84E38k3wbYmmYzSJlHy5tMaKf+yRoAq0A5FYcHLMOR8/DgdhAcwtoEW
 vrC/AeOpPp4cV26Nk6TmWO9JbkmGFYVpxGZWd7+pox0e1uHhIlJS5HxUE
 tzUx2Yfo1Mfk/M9I9UFz2tlO+XIdmrSrQIfOh1AcUayqeuVWTP5whwOxT
 H0yr6nZHia61tHprwu1XQneZQVhxafgeBlVslzz4ezSn1KULRQH7q4Uqv
 y+2smPwP4yVmJdE0N+jGISiSjS682dTrVn/MK3G9y0+m6mnZJ0aD8D5YZ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309869208"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="309869208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 15:49:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700568161"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="700568161"
Received: from junxiaochang.bj.intel.com ([10.238.135.52])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 15:49:18 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 furong.zhou@intel.com, cezary.rojewski@intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 junxiao.chang@intel.com
Subject: [PATCH] ASoC: hdac_hda: fix hda pcm buffer overflow issue
Date: Thu, 10 Nov 2022 07:40:23 +0800
Message-Id: <20221109234023.3111035-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Nov 2022 07:52:54 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When KASAN is enabled, below log might be dumped with Intel EHL hardware:
[   48.583597] ==================================================================
[   48.585921] BUG: KASAN: slab-out-of-bounds in hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.587995] Write of size 4 at addr ffff888103489708 by task pulseaudio/759

[   48.589237] CPU: 2 PID: 759 Comm: pulseaudio Tainted: G     U      E     5.15.71-intel-ese-standard-lts #9
[   48.591272] Hardware name: Intel Corporation Elkhart Lake Embedded Platform/ElkhartLake LPDDR4x T3 CRB, BIOS EHLSFWI1.R00.4251.A01.2206130432 06/13/2022
[   48.593010] Call Trace:
[   48.593648]  <TASK>
[   48.593852]  dump_stack_lvl+0x34/0x48
[   48.594404]  print_address_description.constprop.0+0x1f/0x140
[   48.595174]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.595868]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.596519]  kasan_report.cold+0x7f/0x11b
[   48.597003]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.597885]  hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]

HDAC_LAST_DAI_ID is last index id, pcm buffer array size should
be +1 to avoid out of bound access.

Fixes: 608b8c36c371 ("ASoC: hdac_hda: add support for HDMI/DP as a HDA codec")
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Furong Zhou <furong.zhou@intel.com>
---
 sound/soc/codecs/hdac_hda.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index fc19c34ca00e5..b65560981abb2 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -14,7 +14,7 @@ enum {
 	HDAC_HDMI_1_DAI_ID,
 	HDAC_HDMI_2_DAI_ID,
 	HDAC_HDMI_3_DAI_ID,
-	HDAC_LAST_DAI_ID = HDAC_HDMI_3_DAI_ID,
+	HDAC_DAI_ID_NUM
 };
 
 struct hdac_hda_pcm {
@@ -24,7 +24,7 @@ struct hdac_hda_pcm {
 
 struct hdac_hda_priv {
 	struct hda_codec *codec;
-	struct hdac_hda_pcm pcm[HDAC_LAST_DAI_ID];
+	struct hdac_hda_pcm pcm[HDAC_DAI_ID_NUM];
 	bool need_display_power;
 };
 
-- 
2.25.1

