Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49246C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 21:19:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF6B1726;
	Fri, 20 May 2022 23:18:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF6B1726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653081562;
	bh=wuumc8ngdy1UuMRDft+RyMRFXKpQrYXc5kbDXAD6KCI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hB6I18sSbBUmtAWVAIXCsOIJ0wC38fSAMs+dGTxtfLI7ZJpAfYVZrxa6UUpVeH9OG
	 aT3opiIn9Tz1X828SWJP8DkDgUTTTy1skWNGCNfAspxpQ4BxFnQiGmVkK40/s8B/ON
	 z0LrbKZG1iEM6EGQhCf2mdhce2mLYqeTfwmWjX/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E05ADF80529;
	Fri, 20 May 2022 23:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3A7DF80525; Fri, 20 May 2022 23:17:44 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC567F8019D
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 23:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC567F8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="mdUy8sh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653081459; x=1684617459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wuumc8ngdy1UuMRDft+RyMRFXKpQrYXc5kbDXAD6KCI=;
 b=mdUy8sh5mniuzTvKRY4YwAPUjrYrK8m9ucpgx6fVo8mNA0i2kcwBr8Hl
 kXHg3vwCmdcw7pMAg9o+3cquxE/wvtSicWibA6x1J8wjMd6D1dBpAajuR
 8oY3dXk9714/Q7R1XGV5lfLb1AFGWEZ1VQ4vJrkDWF4zbpqa32QuRpTjo
 TPxUJeJx4NF+6+NSI13DDYxgxgpmXT7aRIStjRos2KWF+Uav/cc2HZdWP
 MyMiatInExTPDWDuCSo6IHTbcAHr1eeccG7LWmzm7s0lLXWAVesAUpxfs
 NAf7dEe8jRd2iFFFO6+qixVTL9JzhDG0SNqVKU1tIl2EuMituHYBLELao w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270324225"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="270324225"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="674796014"
Received: from achsu-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.181.190])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:32 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 03/16] ASoC: wcd-mbhc-v2: remove useless initialization
Date: Fri, 20 May 2022 16:17:06 -0500
Message-Id: <20220520211719.607543-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
References: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck warning:

sound/soc/codecs/wcd-mbhc-v2.c:1309:17: style: Variable 'clamp_state'
is assigned a value that is never used. [unreadVariable]
 u8 clamp_state = 0;
                ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index c53c2ef33e1a2..31009283e7d4a 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1306,7 +1306,7 @@ static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
 static irqreturn_t wcd_mbhc_adc_hs_ins_irq(int irq, void *data)
 {
 	struct wcd_mbhc *mbhc = data;
-	u8 clamp_state = 0;
+	u8 clamp_state;
 	u8 clamp_retry = WCD_MBHC_FAKE_INS_RETRY;
 
 	/*
-- 
2.30.2

