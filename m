Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2AEC2BA16
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:54:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876E920748
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DOsr+bEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E920748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E855C1674;
	Tue,  7 Apr 2020 10:53:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E855C1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586249646;
	bh=JEEo8xoIo4QVlHZSMuO7ZXIV6j/HI0ajSoE77xtN4AY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOsr+bEHV3y7K3E7lIbAu07sm80xrinlOtS6h5ZuSKM025wUXlD53Y0vDHCslsv0O
	 JFHr17KEmgmL+b2Qsvh2RA1YIHUHg0zv3c+TPFaeIR00UXbg60jordmLQK1nRY/+Xk
	 er9sKP0LpOM2YhyvYgYXhEVpDJx4oi98u8fAMTpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CA23F80278;
	Tue,  7 Apr 2020 10:51:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C39DF801F9; Tue,  7 Apr 2020 10:31:13 +0200 (CEST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 225E1F801DA
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 10:31:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 225E1F801DA
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4C806C37CFCB8ABD4D1B;
 Tue,  7 Apr 2020 16:31:05 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 16:30:58 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH 1/4] ASoC: wm8994: remove wm1811_snd_controls and
 mixin_boost_tlv
Date: Tue, 7 Apr 2020 16:29:29 +0800
Message-ID: <20200407082932.41511-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200407082932.41511-1-yanaijie@huawei.com>
References: <20200407082932.41511-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 07 Apr 2020 10:51:32 +0200
Cc: Jason Yan <yanaijie@huawei.com>
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

Fix the following gcc warning:

sound/soc/codecs/wm8994.c:736:38: warning: ‘wm1811_snd_controls’ defined
but not used [-Wunused-const-variable=]
 static const struct snd_kcontrol_new wm1811_snd_controls[] = {
                                      ^~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/soc/codecs/wm8994.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 15ce64a48a87..55d0b9be6ff0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -285,7 +285,6 @@ static const DECLARE_TLV_DB_SCALE(st_tlv, -3600, 300, 0);
 static const DECLARE_TLV_DB_SCALE(wm8994_3d_tlv, -1600, 183, 0);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
-static const DECLARE_TLV_DB_SCALE(mixin_boost_tlv, 0, 900, 0);
 
 #define WM8994_DRC_SWITCH(xname, reg, shift) \
 	SOC_SINGLE_EXT(xname, reg, shift, 1, 0, \
@@ -733,13 +732,6 @@ SOC_SINGLE_TLV("AIF2DAC Noise Gate Threshold Volume",
 	       7, 1, ng_tlv),
 };
 
-static const struct snd_kcontrol_new wm1811_snd_controls[] = {
-SOC_SINGLE_TLV("MIXINL IN1LP Boost Volume", WM8994_INPUT_MIXER_1, 7, 1, 0,
-	       mixin_boost_tlv),
-SOC_SINGLE_TLV("MIXINL IN1RP Boost Volume", WM8994_INPUT_MIXER_1, 8, 1, 0,
-	       mixin_boost_tlv),
-};
-
 /* We run all mode setting through a function to enforce audio mode */
 static void wm1811_jackdet_set_mode(struct snd_soc_component *component, u16 mode)
 {
-- 
2.17.2

