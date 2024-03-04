Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8391DC48BF6
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:05:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2E5B850;
	Mon,  4 Mar 2024 20:05:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2E5B850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709579144;
	bh=JwZ+hTwodZVOZjjcv5y82g/XjxBtI97P5qvbPi/nw5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X5ZVCvcS/wV5YPqxatdQupSjEYjiNDLHYaeqbQ+TJeFyEoayZACsIEQ0D5og4MEGL
	 EVkORS5rhqKNgLVzlcmQheWZGZ1kXaSUGHtQtgAiwetHvcKs98Kk4/ihW1E8FVWBuU
	 hTdskX+6/0ROU3WdQQMSMUUarhGGeXAf8Etfnw/E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC2B2F805DA; Mon,  4 Mar 2024 20:04:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13FD8F805F8;
	Mon,  4 Mar 2024 20:04:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CD9EF80496; Mon,  4 Mar 2024 20:04:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5B2BF80093
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 20:04:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5B2BF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gan3UviL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709579075; x=1741115075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwZ+hTwodZVOZjjcv5y82g/XjxBtI97P5qvbPi/nw5s=;
  b=gan3UviLLYIW5RjFi29sTZGRE9QcCpYEM8LchxGe0RTezEv44hD55BqM
   qjT01Q42nVY4QhJJuDLfZDTPF9yaPZZwE2Scu6gk66wCDdcvsp+a+s4+7
   hbbEhx+7ryrtvHi8SqqEdRgzg+Eya763nkZm9cNxn0AKflmIZDUBYIoV9
   eV075Bgxi0nE/t5ZDKWPDQPwuCuMNaAz+DI3LEE9iss9iHf4agBOYtrRQ
   lvG/FW270fvlTeDPBoz4+Ieotr4ZbaAcKHQci5gD5B4DYSunw1ShnISjg
   yL6wxNwQ3p0lQ2n4DRxTouVbX7vS3QZM9puD1mP/PH99cu6/RuOXsc9OK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4257299"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000";
   d="scan'208";a="4257299"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 11:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000";
   d="scan'208";a="13788291"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2024 11:04:30 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: avs: ssm4567: Board cleanup
Date: Mon,  4 Mar 2024 20:05:35 +0100
Message-Id: <20240304190536.1783332-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304190536.1783332-1-cezary.rojewski@intel.com>
References: <20240304190536.1783332-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RI3ZCF6XZUR6EZLNS4PFANKQCBI6HZEV
X-Message-ID-Hash: RI3ZCF6XZUR6EZLNS4PFANKQCBI6HZEV
X-MailFrom: cezary.rojewski@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RI3ZCF6XZUR6EZLNS4PFANKQCBI6HZEV/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The card-name suffix and the DP-widgets are an unintended copy-paste
from skl_nau88215_ssm4567.c. Both are redundant.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/boards/ssm4567.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index b64be685dc23..abb87bb88fff 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -37,8 +37,6 @@ static const struct snd_kcontrol_new card_controls[] = {
 static const struct snd_soc_dapm_widget card_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Speaker", NULL),
 	SND_SOC_DAPM_SPK("Right Speaker", NULL),
-	SND_SOC_DAPM_SPK("DP1", NULL),
-	SND_SOC_DAPM_SPK("DP2", NULL),
 };
 
 static const struct snd_soc_dapm_route card_base_routes[] = {
@@ -158,7 +156,7 @@ static int avs_ssm4567_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
-	card->name = "avs_ssm4567-adi";
+	card->name = "avs_ssm4567";
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	card->dai_link = dai_link;
-- 
2.25.1

