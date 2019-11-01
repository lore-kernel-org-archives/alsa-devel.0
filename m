Return-Path: <SRS0=I1aD=YZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7142CA9ECF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2EE217D9
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iPqgxasI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2EE217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B1C821CA;
	Fri,  1 Nov 2019 18:09:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B1C821CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572628217;
	bh=VM+MS1iSyLwnvbT4Gy3Vuf7Cy6yNJErFCJloqQbQK40=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iPqgxasIdBk9XOvGeJKWZOOn9ORJ0jGE93Nj7WO+RjdhTbsffEe49tXhRjm9LGGP9
	 vVT1PhTGzyQzidglBugwWNvQUdMZcH+Lp9fxju+HjgNGsvsVbYs5M/EbjJsMW86bk5
	 WUycgx85AAzTIX9s0a8ZrJGuEy2KNkZnBD8r+BIA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1441F80363;
	Fri,  1 Nov 2019 18:09:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BA53F803D6; Fri,  1 Nov 2019 18:09:25 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E54FF80120
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2019 18:09:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E54FF80120
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 10:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; d="scan'208";a="284246527"
Received: from nkpatel-mobl.amr.corp.intel.com (HELO
 yzhi-desktop.amr.corp.intel.com) ([10.255.34.174])
 by orsmga001.jf.intel.com with ESMTP; 01 Nov 2019 10:09:04 -0700
From: Yong Zhi <yong.zhi@intel.com>
To: broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com
Date: Fri,  1 Nov 2019 12:08:50 -0500
Message-Id: <1572628130-16955-1-git-send-email-yong.zhi@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, sathyanarayana.nujella@intel.com,
 ryans.lee@maximintegrated.com, Yong Zhi <yong.zhi@intel.com>
Subject: [alsa-devel] [PATCH] ASoC: max98373: Fix calls to free_gpio()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Don't Call free_gpio() when request_gpio() fails, call it
at error paths to avoid resource leak.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/codecs/max98373.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index eb709d528259..83984b5244c5 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -964,7 +964,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 		if (ret) {
 			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
 				__func__, max98373->reset_gpio);
-			gpio_free(max98373->reset_gpio);
 			return -EINVAL;
 		}
 		gpio_direction_output(max98373->reset_gpio, 0);
@@ -979,16 +978,23 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0) {
 		dev_err(&i2c->dev,
 			"Failed to read: 0x%02X\n", MAX98373_R21FF_REV_ID);
-		return ret;
+		goto err_gpio_free;
 	}
 	dev_info(&i2c->dev, "MAX98373 revisionID: 0x%02X\n", reg);
 
 	/* codec registeration */
 	ret = devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_max98373,
 		max98373_dai, ARRAY_SIZE(max98373_dai));
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		goto err_gpio_free;
+	}
+
+	return 0;
 
+err_gpio_free:
+	if (gpio_is_valid(max98373->reset_gpio))
+		gpio_free(max98373->reset_gpio);
 	return ret;
 }
 
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
