Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0443CD37B0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 13:43:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51B77A4D;
	Mon, 18 Sep 2023 15:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51B77A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695044597;
	bh=uFo3JTP2alB99rkg19E443MKdeHnjsbmxR/ux1VI5Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rurP6Sv0H9fQ2jXp4INL9POGI/+WDWrkA6XOWTjrCC1+EOADIq4Enlr1IySM9VF8C
	 pV5UHrwG3ah8+qsHE5jusRwx/4GvChvfpg8ssygG6bB0j88OVA8y+by97oV2IxGo0i
	 SABffUE/yYIKHQV+1w1k6f83L6xDdCzzD1moctRE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA809F805DF; Mon, 18 Sep 2023 15:40:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0BFAF805D7;
	Mon, 18 Sep 2023 15:40:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E78CF805B2; Mon, 18 Sep 2023 15:40:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B00E4F8025A
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 15:40:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B00E4F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MgmDqqFS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695044433; x=1726580433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFo3JTP2alB99rkg19E443MKdeHnjsbmxR/ux1VI5Z8=;
  b=MgmDqqFSHvqlczY2dTh0QiUB1Ni9Au8/iIzsTM0+a9STrpXnOrLBFwjp
   nnTirBrDPh5C8mvc8My4nlXvpi+LPiLJcUUlqMFaWCHIcpIL3JRGEYsfr
   i4NLgDoU9A2Vw+/V2NkNkWWXSYJHJPeJDBf4A/cMwUB7+rxdn9XEPu1xr
   jYWZtIJ8qnJJ8lslVDwIIrP75tzFehwnmoHmCAaIVJVhDyw9bvUmpoKdu
   wJS/AUBmjETLR39Ih2wCbOsim/B5f8UaTqK/QkgBjLif8Uq9k9Y+bozz4
   8dEMexRb4aPnK/8/EHQ9V1Grx7PRYhiYdhK+2QMEpxy9BDQNkLFhKhpbJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466003812"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="466003812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 06:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="745825941"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="745825941"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2023 06:40:19 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 08/17] ALSA: hda/ca0132: Switch to new stream-format
 interface
Date: Mon, 18 Sep 2023 15:39:31 +0200
Message-Id: <20230918133940.3676091-9-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918133940.3676091-1-cezary.rojewski@intel.com>
References: <20230918133940.3676091-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MWY34PRS5QXFRZBN2XPGMNZ2JRTZCCO2
X-Message-ID-Hash: MWY34PRS5QXFRZBN2XPGMNZ2JRTZCCO2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MWY34PRS5QXFRZBN2XPGMNZ2JRTZCCO2/>
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
 sound/pci/hda/patch_ca0132.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 748a3c40966e..aa312441604f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3022,8 +3022,7 @@ static int dma_convert_to_hda_format(struct hda_codec *codec,
 {
 	unsigned int format_val;
 
-	format_val = snd_hdac_calc_stream_format(sample_rate,
-				channels, SNDRV_PCM_FORMAT_S32_LE, 32, 0);
+	format_val = snd_hdac_stream_format(channels, 32, sample_rate);
 
 	if (hda_format)
 		*hda_format = (unsigned short)format_val;
-- 
2.25.1

