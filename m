Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4556C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:55:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04B06103E
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B04B06103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 497C71673;
	Wed,  6 Oct 2021 18:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 497C71673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633539339;
	bh=dokJ7N0J2NhcnkJvrD7BfIAbKtcptE7zXO/QjUe/PIM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKy0qXEvOuK11j1Pp4p4mnR0Y2MXAx5mxjRNp6/nOKJoEsPtIt8KCn1cf+KjVhpJQ
	 2CCjGdhJ2QleT0o0OoAOlGBxq3e2wFOPGFGiEMraSXgyjfaqnGXcwj5126eJ9A22OL
	 sieWAQln9HryRLESlFe7d0MkV4SB6cYCFmP021Ak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04013F804EB;
	Wed,  6 Oct 2021 18:54:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74596F804EC; Wed,  6 Oct 2021 18:54:37 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACAC1F804EB
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 18:54:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACAC1F804EB
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="212987218"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="212987218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 09:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="439965080"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 06 Oct 2021 09:52:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 56F0F1C8; Wed,  6 Oct 2021 19:52:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ASoC: Intel: bytcht_es8316: Use temporary variable for
 struct device
Date: Wed,  6 Oct 2021 19:52:26 +0300
Message-Id: <20211006165228.1692-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006165228.1692-1-andriy.shevchenko@linux.intel.com>
References: <20211006165228.1692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 4360519fbb0c..171f3d8c5996 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -493,7 +493,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		put_device(&adev->dev);
 		byt_cht_es8316_dais[dai_index].codecs->name = codec_name;
 	} else {
-		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENXIO;
 	}
 
@@ -596,7 +596,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	byt_cht_es8316_card.long_name = long_name;
 #endif
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
-- 
2.33.0

