Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E065CC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 21:42:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C567D1AE0;
	Thu, 16 Jun 2022 23:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C567D1AE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655415758;
	bh=QMmuQMIoyk3evoICDnvg5ksdkBHEjgOQsHHOA+U3ct0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dwDoKVrCgYVZ/oGaMhh1G1nnc8m6tYk3kOSubeFnI4R9niAqDdi0Yic91AMuaBzHT
	 bFQmUKMhGQPXlpFMAPLIcYhtdcdb/TGmUX/NLXRhbC/3HVwJlYYUL4ErAT0x/ny2lp
	 8P8EBX5BYrgAMF2yrad38wruhf/WMpWM4X+vkkdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24509F80529;
	Thu, 16 Jun 2022 23:41:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26A0EF804D0; Thu, 16 Jun 2022 23:41:14 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F5A8F800D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 23:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F5A8F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="KcfKQ76L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655415668; x=1686951668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QMmuQMIoyk3evoICDnvg5ksdkBHEjgOQsHHOA+U3ct0=;
 b=KcfKQ76LYiVhvNOIdvlmiOSrg8A2mbXQG4VwhC7iN/fvAOpgPl3ISebX
 rCJyD6APHztZui7NDX7D97H/ENyYZ/ZOtARAVSgP6YmQ9FNh6CNLo7C+/
 lcEi0ktCDCJVk/E8mdzZlDzsTsFGRcDRRIC/LSOsnhcjZAxRBOrDjrzQQ
 F/v8XA/kJI3FUaYNRDqkIl7lzAzclSa5XOUziXh7acK+Ggz67SImNsyIc
 8P6YYsmM75GWw1/57GV6C2yfstLJq7CIwfGeGJHk8YQiT/T1Vc3LgWlot
 h+32kyzqNPVwssbRCHk6PS9WxO3XZwstekwJaIgsrmL3uLSqgJIDdY07B g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276932410"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="276932410"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 14:41:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="831746730"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 14:41:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/13] ASoC: Intel: skl_nau88l25_max98357a: remap jack pins
Date: Thu, 16 Jun 2022 16:40:43 -0500
Message-Id: <20220616214055.134943-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616214055.134943-1-pierre-louis.bossart@linux.intel.com>
References: <20220616214055.134943-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

The card did not map jack pins to controls, which prevents
PulseAudio/PipeWire from dealing with jack detection. It's likely that
jack detection was only tested with the CRAS server and extensions of
UCM.

Suggested-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .../soc/intel/boards/skl_nau88l25_max98357a.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 8e2d03e360792..8dceb0b025812 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -97,6 +97,17 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 			SND_SOC_DAPM_POST_PMD),
 };
 
+static struct snd_soc_jack_pin jack_pins[] = {
+	{
+		.pin    = "Headphone Jack",
+		.mask   = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin    = "Headset Mic",
+		.mask   = SND_JACK_MICROPHONE,
+	},
+};
+
 static const struct snd_soc_dapm_route skylake_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{ "Headphone Jack", NULL, "HPOL" },
@@ -163,9 +174,11 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
 	 */
-	ret = snd_soc_card_jack_new(&skylake_audio_card, "Headset Jack",
-			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset);
+	ret = snd_soc_card_jack_new_pins(&skylake_audio_card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset,
+					 jack_pins,
+					 ARRAY_SIZE(jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
-- 
2.34.1

