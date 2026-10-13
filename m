Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F81CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:04:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B065601A5;
	Tue, 13 Oct 2026 15:04:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B065601A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791896683;
	bh=lA86Al6V7sXU4UI2Kbuzh1w9c2d+appMmJEFQVRANmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fO4WN1ipBljJhvxmrFX5OKwDe+7eD+HWuGF0qJAlDgVtLnJYXTDHvp1p4XVtUbK9R
	 oChrtNT48BII/cCYqg0rWQprst635a0FwzBeda/ne5Z++fC6+iB4KRumQydBUtLnOe
	 FGPviaveudLjTDF2Evr4D+nCNHJWTwbU7MUxRcA4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6305F8060D; Tue, 13 Oct 2026 15:03:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70115F8060A;
	Tue, 13 Oct 2026 15:03:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D786F80548; Tue, 13 Oct 2026 15:03:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791896621;
	b=F+zJL0NVQLs/kGtwFbLudyA2rTvIwqopJxaZrfJlT0DpsHPdYkCl6VyKVB+Kvz/I3mMf
	 V22tT2vxzhxpFj2OYnjpbGLJm24HOzH3tMd6K8edrVkdDZEDict1YHBSndlMwxN6pdHHO
	 8hKngXZUCys8pWo9S///iLFkIrbHNVTnk3Ss+ftpY+1omIWuOJ85dJ46YNF1C/uU0Q6d2
	 aofJrGracymdTsgXjzJhT7ZTVg+KJYrb+QOGhni9+XrReRwNfhgkrWA3GiI7mi5VzqETP
	 l//EDDPhmArEdynoLwtPU4MzilE2/wwUAh0vxTpL6sJU7Rq3OtDG7TbQzvE+K+wmF/Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791896621;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=lA86Al6V7sXU4UI2Kbuzh1w9c2d+appMmJEFQVRANmU=;
	b=QYDk64OzUbnnEb9IK+2rEu3RdOfXFiBYkVAZWgepxOK3grMQtarBNbG2l9sXmofXoLcB
	 mRQtVSBC/xX0/+2330ILEjBA/YGfM4Cws+l5J1wwlBAc2Ky2AuejUqS5krR63NGqB/DyY
	 Us63wkb5sVGd9G7PN9ECwcBfMqvrAMNVqt4u2f6rnbczfBohsryiXBn2CSvnVhFcTDfWA
	 a+V179MpUfmwORC4tnY0Zy8YhQLYhmVuNLwTZjcWhxWoazaMJorZey2vVe6CWOa/UefNA
	 q3+DwUAirVUL+KZGskFqqEzT9InMjrlqqZTVGt7Dv0WSGboEnqX69dpNuXs5ZEbiKqQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id A62ECF80495
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 15:03:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A62ECF80495
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AB.000000006ACE2C24.00339CB6;
 Tue, 13 Oct 2026 15:03:32 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: hda/tas2781: Assign total_sz at the end of the
 function
Date: Tue, 13 Oct 2026 15:02:20 +0200
Message-ID: 
 <4b357778dce1b70a647e7e47b5ab3f0a6b2fc0cc.1791895478.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791895478.git.soyer@irl.hu>
References: <cover.1791895478.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: FUOTSVFED5JECISMEH34DTLMO4GOUWFJ
X-Message-ID-Hash: FUOTSVFED5JECISMEH34DTLMO4GOUWFJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FUOTSVFED5JECISMEH34DTLMO4GOUWFJ/>
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
Changes in v2:
 - Zero total_sz at the beginning of the function as it may run multiple 
   times (Sashiko)

---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 5e5f46c9fb6b..cff8fab8133a 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -335,10 +335,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	}
 
 	cd->cali_dat_sz_per_dev = TAS2563_CAL_DATA_SIZE * TASDEV_CALIB_N;
+	cd->total_sz = 0;
 
 	/* extra byte for each device is the device number */
-	cd->total_sz = (cd->cali_dat_sz_per_dev + 1) * p->ndev;
-	data = cd->data = devm_kzalloc(p->dev, cd->total_sz,
+	data = cd->data = devm_kzalloc(p->dev,
+		(cd->cali_dat_sz_per_dev + 1) * p->ndev,
 		GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -352,7 +353,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 			if (ret < 0 || ret >= sizeof(var8) - 1) {
 				dev_err(p->dev, "%s: Read %s failed\n",
 					__func__, var8);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			/*
@@ -370,7 +370,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 				dev_warn(p->dev,
 					"Dev %d: Caldat[%d] read failed %ld\n",
 					i, j, status);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
@@ -379,12 +378,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
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

