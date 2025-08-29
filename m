Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78099CA0FF9
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Aug 2025 16:07:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33401602C9;
	Fri, 29 Aug 2025 18:06:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33401602C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756483621;
	bh=oG/RqtqKieHZimm7gXgRkzsfB19O/IOZeItoUrALDIM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ma+6GJneTsgDJMwJEd7Hxfn03lljHDJBnDiSreJYNS3hTDki8/2aPqv2LY/KL5u4i
	 bjBHxCvGA8KxNDMTCuAM0YFRnnqPXbobx3jdxADpuuwaRcqdN4WkOZ58HOg35MHeIZ
	 N6qc4fbaC6ZsBNLFCb09FT3gmZkrPo1LrRui1xhk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F3DDF805C3; Fri, 29 Aug 2025 18:06:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD733F805C5;
	Fri, 29 Aug 2025 18:06:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BA57F80185; Fri, 29 Aug 2025 18:06:10 +0200 (CEST)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id CEBA0F80072
	for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2025 18:06:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEBA0F80072
Received: from fedori.lan (51b694d5.dsl.pool.telekom.hu
 [::ffff:81.182.148.213])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D58.0000000068B1CFEC.0023A913;
 Fri, 29 Aug 2025 18:06:04 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda: tas2781: fix tas2563 EFI data endianness
Date: Fri, 29 Aug 2025 18:04:49 +0200
Message-ID: <20250829160450.66623-1-soyer@irl.hu>
X-Mailer: git-send-email 2.51.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: P4ULNU537O6GQSDQSFOKBY3QCG7BI44S
X-Message-ID-Hash: P4ULNU537O6GQSDQSFOKBY3QCG7BI44S
X-MailFrom: soyer@irl.hu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P4ULNU537O6GQSDQSFOKBY3QCG7BI44S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Before conversion to unify the calibration data management, the
tas2563_apply_calib() function performed the big endian conversion and
wrote the calibration data to the device. The writing is now done by the
common tasdev_load_calibrated_data() function, but without conversion.

Put the values into the calibration data buffer with the expected
endianness.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index e34b17f0c9b9..1eac751ab2a6 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -310,6 +310,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	struct cali_reg *r = &cd->cali_reg_array;
 	unsigned int offset = 0;
 	unsigned char *data;
+	__be32 bedata;
 	efi_status_t status;
 	unsigned int attr;
 	int ret, i, j, k;
@@ -351,6 +352,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
+			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
 		}
 	}
-- 
2.51.0

