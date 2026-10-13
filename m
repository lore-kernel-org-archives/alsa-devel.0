Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206D8CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:58:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 288CF6020A;
	Tue, 13 Oct 2026 11:58:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 288CF6020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885526;
	bh=prPWdv1ovPiV6mUJhBmuV/hQo6DoAeZ3psLRQ1K4zGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pBII/cWncjP98p9VVMgTqp4FurzFsCwEpx3/f4dCEyVst1P24N89ctgpK0mnROiU+
	 Xg7Wkq8BLY/6vvMRoL+on0s+/ihO9RHNBctwvXShtH/bDHnXsDPiMgtWp4zTrEsIuA
	 LuAsZh3wMcxJRfCG+k8AZol192tTdOuJK8TEje6c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D104F80614; Tue, 13 Oct 2026 11:57:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD0DCF8061F;
	Tue, 13 Oct 2026 11:57:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25530F80548; Tue, 13 Oct 2026 11:57:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791885466;
	b=alogsjBVAMRe5AoA4Q+qQ18ofNLtJohbfke0U0JSQKkzy3ooECSYCl31VH8KIvf7H7+y
	 j/KttrUhuL2t2CjPu8Kt8DGcCwB1RGBP2fUabQSjVNcn+vx9pB/DyMDFylUtbWGfyZ6J9
	 WdbzpQNJLFu2NcUgMccufWLDFwKFITa3oJAIBt9dQVJ6b0rl0N9QkcFzvZyewukuLetsp
	 bNVLYAbVy2Oxj+eccVrh2j19FhdzcVu8v6YJew7hgU3HYo7Dn0OBaMxJJx1spEPXxHf4V
	 HsO47nnGl5Kj1k3GHo9EA3qWqf8D7+tT2RMHsuVkgjur3vIjp+I4PSKnvJs2+SxGTlA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885466;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=prPWdv1ovPiV6mUJhBmuV/hQo6DoAeZ3psLRQ1K4zGY=;
	b=XjbsTUY6Jk6Xej9P6mK9R/nmWBly+C0YQ7PkzfboUc5UJry42nfTbXr0liUlCOP7r548
	 JfOKdRujytYrAtfn6LEp4lf75VU8X63B9y4rsxl72rWWvkPIqIfizYiW06SMFRj4OWeCo
	 XHWAi+eqGcKumvfDWtBo9Gu7yxzviQw5A1aT3MZ3AdQqaFWoBuHghyOj2UyYbgYIV4w7k
	 3gmVHOtXXSzdnxPxdXwRnrSiEzy2gYcSGP6SQKQHBGtCyAvY8sEgoSdCZbKB4pdSBcSeE
	 ARl34FgNMMQI+mf9X6VbJ/oSQod9r1Qh6ghBew85xhmKB7s6efx8zYMDvdhDTPlNpZQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id A0F67F8045D
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 11:57:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0F67F8045D
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AC.000000006ACE0098.003393E4;
 Tue, 13 Oct 2026 11:57:44 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/tas2781: Assign total_sz at the end of the
 function
Date: Tue, 13 Oct 2026 11:57:03 +0200
Message-ID: 
 <08ad212c4590c0570aed7b2bb870bcdf9a222434.1791883592.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791883592.git.soyer@irl.hu>
References: <cover.1791883592.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: Q57XYS5H3CBIT7HFZUCBOV2KIEJS6CVA
X-Message-ID-Hash: Q57XYS5H3CBIT7HFZUCBOV2KIEJS6CVA
X-MailFrom: soyer@irl.hu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q57XYS5H3CBIT7HFZUCBOV2KIEJS6CVA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In the tas2563_save_calibration() function, cd->total_sz is assigned in
several error paths.

Move the assignment to the end of the function.

Fixes: b6016332b889 ("ALSA: hda/tas2781: clear cali_data.total_sz when calibration read fails")
Cc: <stable@vger.kernel.org> # 6.18
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 5e5f46c9fb6b..f1329bb6adcd 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -337,8 +337,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	cd->cali_dat_sz_per_dev = TAS2563_CAL_DATA_SIZE * TASDEV_CALIB_N;
 
 	/* extra byte for each device is the device number */
-	cd->total_sz = (cd->cali_dat_sz_per_dev + 1) * p->ndev;
-	data = cd->data = devm_kzalloc(p->dev, cd->total_sz,
+	data = cd->data = devm_kzalloc(p->dev,
+		(cd->cali_dat_sz_per_dev + 1) * p->ndev,
 		GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -352,7 +352,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 			if (ret < 0 || ret >= sizeof(var8) - 1) {
 				dev_err(p->dev, "%s: Read %s failed\n",
 					__func__, var8);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			/*
@@ -370,7 +369,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 				dev_warn(p->dev,
 					"Dev %d: Caldat[%d] read failed %ld\n",
 					i, j, status);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
@@ -379,12 +377,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 		}
 	}
 
-	if (cd->total_sz != offset) {
-		dev_err(p->dev, "%s: tot_size(%lu) and offset(%u) mismatch\n",
-			__func__, cd->total_sz, offset);
-		cd->total_sz = 0;
-		return -EINVAL;
-	}
+	cd->total_sz = offset;
 
 	r->r0_reg = TAS2563_CAL_R0;
 	r->invr0_reg = TAS2563_CAL_INVR0;
-- 
2.56.0

