Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AFEC00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 11:34:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90A8B847;
	Mon, 15 Aug 2022 13:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90A8B847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660563291;
	bh=dHGQeLSi//e5FUlXLZC1w3Wkn3UCAOkJ1whOyECrFj8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pTuwCOwO2xP0fGkj5f3ptgKASnASj9uVFccAFkDEWeoWioyhoBtOlWdOxnciq8Hie
	 maS+bVU0gZJ+AZmoJzGn7xm5G0jRAsJGMQK2YFQTi6SJI0LMH+6G9LsBT5H0nkrpL7
	 DQoecHwXwcAsFXg0m96qja2lL+qdfop0j5CN2ScM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3199CF80245;
	Mon, 15 Aug 2022 13:34:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85180F8025A; Mon, 15 Aug 2022 13:33:59 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56F3EF80082
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 13:33:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56F3EF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="QOYPwyzu"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F6Gifp000354;
 Mon, 15 Aug 2022 06:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=CdlJBI37lWNvixE57726zjypfORIkbpeqIqDkA6MwRI=;
 b=QOYPwyzuH6DHJQE8udHEZunK2icIkEYzVslZT6+tZ1MGP4biTSCXUcy3dMsdsu8foRJD
 AFK9CA6Ou86tuTQDI/rLWXK1g1odfTdZWpqb8ql7rRlwb8xzKLQOpjxp+OIUB4sbsTsn
 S7mCkMqk2O/WYY9FiQ11KfvcxA17XWKM1nfpapZWwxBajKxxOiNo4hIT+f27rPSFf+Rt
 FGmVdL/+03Y9Q3EMuN26qKlv3UzNXWrSjWH5uAXNMGJCz+Divy3QRO1PwxyMfrG771t+
 Z1IcnHuqj/XnK1KxC9dz2PyxC/CKBJ8EzjD4vbCecsdcvfxMKcILnCX6BwImAkHy4dkU 2Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1t435-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Aug 2022 06:33:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 15 Aug
 2022 06:33:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 15 Aug 2022 06:33:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.95])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A79F5B06;
 Mon, 15 Aug 2022 11:33:46 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: soc-utils: Improve kerneldoc for
 snd_soc_tdm_params_to_bclk()
Date: Mon, 15 Aug 2022 12:33:46 +0100
Message-ID: <20220815113346.3805075-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LX-acjpnRm2C_z4MKRHKdNb55aGAD31p
X-Proofpoint-GUID: LX-acjpnRm2C_z4MKRHKdNb55aGAD31p
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

The statement that snd_soc_tdm_params_to_bclk() is equivalent to
snd_soc_params_to_bclk() if tdm_width==tdm_slots==0 is not accurate,
it is only true is slot_multiple is also <2.

However, the description of special-case behaviour in terms of pairs of
tdm_width and tdm_slot values is not particularly helpful so we might as
well take the opportunity to rework the description to say the same thing
in a simpler way. The behaviour of a pair of values is obvious from a
description of each argument. At the same time make a few edits to clarify
the rest of the description.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/soc-utils.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 70c380c0ac7b..a3b6df2378b4 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -56,23 +56,24 @@ EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
 /**
  * snd_soc_tdm_params_to_bclk - calculate bclk from params and tdm slot info.
  *
- * Calculate the bclk from the params sample rate and the tdm slot count and
- * tdm slot width. Either or both of tdm_width and tdm_slots can be 0.
+ * Calculate the bclk from the params sample rate, the tdm slot count and the
+ * tdm slot width. Optionally round-up the slot count to a given multiple.
+ * Either or both of tdm_width and tdm_slots can be 0.
  *
- * If tdm_width == 0 and tdm_slots > 0:	the params_width will be used.
- * If tdm_width > 0 and tdm_slots == 0:	the params_channels will be used
- *					as the slot count.
- * Both tdm_width and tdm_slots are 0:	this is equivalent to calling
- *					snd_soc_params_to_bclk().
+ * If tdm_width == 0:	use params_width() as the slot width.
+ * If tdm_slots == 0:	use params_channels() as the slot count.
  *
- * If slot_multiple > 1 the slot count (or params_channels if tdm_slots == 0)
- * will be rounded up to a multiple of this value. This is mainly useful for
+ * If slot_multiple > 1 the slot count (or params_channels() if tdm_slots == 0)
+ * will be rounded up to a multiple of slot_multiple. This is mainly useful for
  * I2S mode, which has a left and right phase so the number of slots is always
  * a multiple of 2.
  *
+ * If tdm_width == 0 && tdm_slots == 0 && slot_multiple < 2, this is equivalent
+ * to calling snd_soc_params_to_bclk().
+ *
  * @params:        Pointer to struct_pcm_hw_params.
- * @tdm_width:     Width in bits of the tdm slots.
- * @tdm_slots:     Number of tdm slots per frame.
+ * @tdm_width:     Width in bits of the tdm slots. Must be >= 0.
+ * @tdm_slots:     Number of tdm slots per frame. Must be >= 0.
  * @slot_multiple: If >1 roundup slot count to a multiple of this value.
  *
  * Return: bclk frequency in Hz, else a negative error code if params format
-- 
2.30.2

