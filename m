Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9846EC25B10
	for <alsa-devel@archiver.kernel.org>; Thu,  9 May 2024 16:38:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7612E9F;
	Thu,  9 May 2024 18:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7612E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715272688;
	bh=jrB8Du6KzynA1SE9fINLjjbN0MfJwOUYOIk3RscTY1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=No7ENdQEt07BYRPFAoHsddIS4PWyq+zu4Nr+F8/12dk+2d/p5RRYrIzfjRIVY6EH/
	 98T4+VxZJOxlXSm36cr1b0wzCnd/tScd69fk8m0ApthionwKJNrT9/pt5msJu0k2vF
	 0HDwjcZHA8zxotG2tf+EB/YvCV05lcBueyoOZnUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DBEAF80717; Thu,  9 May 2024 18:35:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62133F805A9;
	Thu,  9 May 2024 18:35:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EBD8F80579; Thu,  9 May 2024 18:34:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3B23CF80579
	for <alsa-devel@alsa-project.org>; Thu,  9 May 2024 18:34:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B23CF80579
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZKYtiC3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715272482; x=1746808482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jrB8Du6KzynA1SE9fINLjjbN0MfJwOUYOIk3RscTY1A=;
  b=ZKYtiC3PdgH4BfOlju6N6kXJigV6h/N6QsVIArSrkkk6pRaYQHP6vRzt
   tBf33E4fkPcnPAy6vutEoSlWaTnzcPrr7z20YUFBCcxMpNwao6Fgua6TX
   86/sr945YmzNVep1+9r3fh636i+SBivUivF9lihwqy0sn4FxHOWd6QBPw
   8TZtNeG/7PUDFq69zIOWf3MYmHYfHC+kUsc8/z2IycgNckEHNJw107iEb
   OdaHW7dS/qjsyv2kg/A8Lr9Je49JRauxFYagVT8HsjV7Yjzy/1kdJNcd0
   qZlCxJICTGbtPXuz5JMKwHFoavIxVz56VDeZYL7ZREMXJJieSBvzwaIXg
   w==;
X-CSE-ConnectionGUID: HRJxaz2VQcioTzII+mMQLw==
X-CSE-MsgGUID: WNmFT2O0THK+CJHp3vTFqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15017597"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000";
   d="scan'208";a="15017597"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 09:34:32 -0700
X-CSE-ConnectionGUID: LExlptZ8QZKVKNeuvcXeyw==
X-CSE-MsgGUID: 2lty1cfgQwCXsMwEUTycvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000";
   d="scan'208";a="33761038"
Received: from ajunnare-mobl.amr.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.213.181.85])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 09:34:32 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/18] ASoC: Intel: sof_sdw_cs_amp: rename Speakers to Speaker
Date: Thu,  9 May 2024 11:34:13 -0500
Message-Id: <20240509163418.67746-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240509163418.67746-1-pierre-louis.bossart@linux.intel.com>
References: <20240509163418.67746-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2IKP42ZTF34OS26SO5MQU4YWNI5MTJUK
X-Message-ID-Hash: 2IKP42ZTF34OS26SO5MQU4YWNI5MTJUK
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2IKP42ZTF34OS26SO5MQU4YWNI5MTJUK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

To be consistent to other amps that used in the machine driver.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_cs_amp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_cs_amp.c b/sound/soc/intel/boards/sof_sdw_cs_amp.c
index e29a586ce7c0..3538d3c752b7 100644
--- a/sound/soc/intel/boards/sof_sdw_cs_amp.c
+++ b/sound/soc/intel/boards/sof_sdw_cs_amp.c
@@ -15,7 +15,7 @@
 #define CODEC_NAME_SIZE	8
 
 static const struct snd_soc_dapm_widget sof_widgets[] = {
-	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
 int cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd)
@@ -24,7 +24,7 @@ int cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_card *card = rtd->card;
 	char codec_name[CODEC_NAME_SIZE];
 	char widget_name[16];
-	struct snd_soc_dapm_route route = { "Speakers", NULL, widget_name };
+	struct snd_soc_dapm_route route = { "Speaker", NULL, widget_name };
 	struct snd_soc_dai *codec_dai;
 	int i, ret;
 
-- 
2.40.1

