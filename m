Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC19CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 22:07:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33EA61B2B;
	Fri, 17 Jun 2022 00:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33EA61B2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655417236;
	bh=l2zzEpI/NGYD3sJTCPiXWhJ1G6S1YXmPElHQQZQzDlU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJDFkYpEND2rF73K0nablUfvG7uSvx4V99rUCKMhZXAdD/s6eg77KA3juDha2H5AC
	 fNWx6RAVtpeZxfd9k/+pVUvLUi4e2RdlqXhevkEVkmNmoxcsLARFREq+LxrYMBEvDI
	 2yZZ0RgLosXKnZdia8eFvhEhvLweT7aouxKXaSnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6107F8053A;
	Fri, 17 Jun 2022 00:04:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61AF3F80539; Fri, 17 Jun 2022 00:04:53 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3570EF8051F
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 00:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3570EF8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="NoZnjH47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655417086; x=1686953086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l2zzEpI/NGYD3sJTCPiXWhJ1G6S1YXmPElHQQZQzDlU=;
 b=NoZnjH47tLvQ5jvFYpwuNU7tlPIMvSnt6lMJjelrqADdYn7kOqXoiPhC
 0e2PcgUeqkWUJf4l1/1jq5+Kgn57IBnNBxsJH5+57Zctd0KLG1Z2xMYuJ
 Q33E1diddLum1YrFpjgU9MAIsyZoJzbS4PI7V7XuLv50dzLECn04NzcZs
 gERYnHZQ5Bo68TT2QgtHEms1kKIKOnMZxtxxkTLB0us8BZHUTntlJT5ms
 l3/ke9NNj19alFnnpJO3P4DTkOEBiQzNqQbmn+IG9EanmblM9UrdAhhXy
 nEKXLsVykr9bkzSA+noumM5Ru1wN9szNHED7LxDM5C0tJjWeEfqygsLr/ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304810925"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="304810925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="728084991"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/11] ASoC: wcd-mbhc-v2: use pm_runtime_resume_and_get()
Date: Thu, 16 Jun 2022 17:04:20 -0500
Message-Id: <20220616220427.136036-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

simplify the flow. No functionality change, except that on -EACCESS
the reference count will be decreased.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 31009283e7d4a..98baef594bf31 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -714,12 +714,11 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 	struct snd_soc_component *component = mbhc->component;
 	int ret;
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(component->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(component->dev);
 		return ret;
 	}
 
@@ -1097,12 +1096,11 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
 	component = mbhc->component;
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(component->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(component->dev);
 		return;
 	}
 	micbias_mv = wcd_mbhc_get_micbias(mbhc);
-- 
2.34.1

