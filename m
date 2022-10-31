Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B7ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 15:52:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D1151675;
	Mon, 31 Oct 2022 16:51:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D1151675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667231565;
	bh=Fql4FZO7uX5rRWQgwds/n4gQKmqe/m9nuV8VPMYmhOc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+wkmWh5pjTnxLGZLDhH52DNxmE9co008MWI5ik8/NJqcQFsWjEnbAsU6uk2Z2y/a
	 HxCZDVNC0r8oh1QE+8S74X+hoYwocKM4iaJbKz35eIUrlu6OBUBK37GDnYlJrJcQCS
	 +3H8huHrmqCOE/pKZKnNeqvhHTu0f/FCOTjAmvug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEB62F8057F;
	Mon, 31 Oct 2022 16:50:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E65B1F80580; Mon, 31 Oct 2022 16:50:05 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6135F80557
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 16:49:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6135F80557
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="natOvrZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667231399; x=1698767399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fql4FZO7uX5rRWQgwds/n4gQKmqe/m9nuV8VPMYmhOc=;
 b=natOvrZva3/J+R9qKhNpWgGd+1iHSGp+GEhRE4yR1rBCDL+AquGuZf6X
 /X4w6XB8EVSWsLwhVluFlrppuc3R9lIbqQKbk4g7YcFxaW95vas/ukATC
 Ex5SPRL5GmTqGFR7rvc3oqGC3xx5sP6PMuJl5ZQpGuGie5b1wK2TuLHEd
 nMM1f8xLezd0+m7N7acSNQuMK98fVqz255+TYIHZZVktSk5nK4+UCjUzB
 FZDDJYE9o7umD++X6Lk3pA1mbST7r4nmJRU5Dm7tCXwYY8iYehIqDt54h
 /hj11LUqJCY7KnAbpU+CvmOViYU4fTYQMNR7VB/Q6IZirF+5Q4dWitDmK Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="308929981"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; d="scan'208";a="308929981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2022 08:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="776178958"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; d="scan'208";a="776178958"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2022 08:49:55 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 7/7] ASoC: codecs: da7219: Do not export internal symbols
Date: Mon, 31 Oct 2022 17:02:27 +0100
Message-Id: <20221031160227.2352630-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031160227.2352630-1-cezary.rojewski@intel.com>
References: <20221031160227.2352630-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Vijendar.Mukunda@amd.com,
 heiko@sntech.de, AjitKumar.Pandey@amd.com, linux-rockchip@lists.infradead.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, jiaxin.yu@mediatek.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, Syed.SabaKareem@amd.com,
 amadeuszx.slawinski@linux.intel.com, trevor.wu@mediatek.com
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

With all users utilizing component->set_jack(), there is no need to
export da7219_aad_jack_det() function.

While at it, remove exports from all other functions as well.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/codecs/da7219-aad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index bba73c44c219..9bf8d73b4f58 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -43,7 +43,6 @@ void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_soc_jac
 			    DA7219_ACCDET_EN_MASK,
 			    (jack ? DA7219_ACCDET_EN_MASK : 0));
 }
-EXPORT_SYMBOL_GPL(da7219_aad_jack_det);
 
 /*
  * Button/HPTest work
@@ -930,7 +929,6 @@ int da7219_aad_init(struct snd_soc_component *component)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(da7219_aad_init);
 
 void da7219_aad_exit(struct snd_soc_component *component)
 {
@@ -948,7 +946,6 @@ void da7219_aad_exit(struct snd_soc_component *component)
 	cancel_work_sync(&da7219_aad->btn_det_work);
 	cancel_work_sync(&da7219_aad->hptest_work);
 }
-EXPORT_SYMBOL_GPL(da7219_aad_exit);
 
 /*
  * AAD related I2C probe handling
@@ -972,7 +969,6 @@ int da7219_aad_probe(struct i2c_client *i2c)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(da7219_aad_probe);
 
 MODULE_DESCRIPTION("ASoC DA7219 AAD Driver");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
-- 
2.25.1

