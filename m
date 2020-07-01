Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF91C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:16:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF6420853
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tfJVGMBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF6420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD2001690;
	Wed,  1 Jul 2020 20:15:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD2001690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593627396;
	bh=0nwwlCy04yr0X/fEAZOc2UJFjoZuAiIS48niIK4GUa4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfJVGMBe1/2TzoeZqh645gkGRGYGf1HAje9zrPrP6uHbK0Om2mR+4WmFDSuJkqY8v
	 ZFwKEXfE0mIu+5tDDW8PYEYEHDey8hp+gyTAMo6N9eoWKcV2xV4911/YsZAOfn4iG5
	 rsARN03LR+6bgfejtC162VhSnV6lYdo0qnzkJkBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E30AF80229;
	Wed,  1 Jul 2020 20:14:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55206F802A8; Wed,  1 Jul 2020 20:14:08 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71E69F801D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:14:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71E69F801D8
IronPort-SDR: cs1xsVQQIQD3nbzALB0cm5suNnWuxmj59moK0eN1QD53wuFDw0nlqH8CaLbUMTYheDz05aavfK
 r4tfcRppy/ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145753236"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="145753236"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:13:54 -0700
IronPort-SDR: Bz8aC1gLSecZHlOZKPJ84oaouaaJk6gNCO7rpa/59bd2BRnL4YM1JJ5R/tIm38scoXbDeDlepU
 Cru6zqLcI9DQ==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="481686347"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:13:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/7] ASoC: codecs: cs42l42: remove always-true comparisons
Date: Wed,  1 Jul 2020 13:13:15 -0500
Message-Id: <20200701181320.80848-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701181320.80848-1-pierre-louis.bossart@linux.intel.com>
References: <20200701181320.80848-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
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

Fix W=1 warnings:

cs42l42.c: In function 'cs42l42_handle_device_data':
cs42l42.c:1661:12: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
 1661 |   if ((val >= CS42L42_BTN_DET_INIT_DBNCE_MIN) &&
      |            ^~
cs42l42.c:1679:12: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
 1679 |   if ((val >= CS42L42_BTN_DET_EVENT_DBNCE_MIN) &&
      |            ^~
cs42l42.c:1698:23: warning: comparison of unsigned expression >= 0 is
always true [-Wtype-limits]
 1698 |    if ((thresholds[i] >= CS42L42_HS_DET_LEVEL_MIN) &&
      |                       ^~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cs42l42.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 3bc2fa229ef3..d391b5074904 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1658,8 +1658,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 	ret = of_property_read_u32(np, "cirrus,btn-det-init-dbnce", &val);
 
 	if (!ret) {
-		if ((val >= CS42L42_BTN_DET_INIT_DBNCE_MIN) &&
-			(val <= CS42L42_BTN_DET_INIT_DBNCE_MAX))
+		if (val <= CS42L42_BTN_DET_INIT_DBNCE_MAX)
 			cs42l42->btn_det_init_dbnce = val;
 		else {
 			dev_err(&i2c_client->dev,
@@ -1676,8 +1675,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 	ret = of_property_read_u32(np, "cirrus,btn-det-event-dbnce", &val);
 
 	if (!ret) {
-		if ((val >= CS42L42_BTN_DET_EVENT_DBNCE_MIN) &&
-			(val <= CS42L42_BTN_DET_EVENT_DBNCE_MAX))
+		if (val <= CS42L42_BTN_DET_EVENT_DBNCE_MAX)
 			cs42l42->btn_det_event_dbnce = val;
 		else {
 			dev_err(&i2c_client->dev,
@@ -1695,8 +1693,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 
 	if (!ret) {
 		for (i = 0; i < CS42L42_NUM_BIASES; i++) {
-			if ((thresholds[i] >= CS42L42_HS_DET_LEVEL_MIN) &&
-				(thresholds[i] <= CS42L42_HS_DET_LEVEL_MAX))
+			if (thresholds[i] <= CS42L42_HS_DET_LEVEL_MAX)
 				cs42l42->bias_thresholds[i] = thresholds[i];
 			else {
 				dev_err(&i2c_client->dev,
-- 
2.25.1

