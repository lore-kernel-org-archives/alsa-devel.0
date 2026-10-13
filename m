Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47D7CA9ED2
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:04:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30E3D601EF;
	Tue, 13 Oct 2026 15:04:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30E3D601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791896664;
	bh=uVjcc/KF4L/qAuKP4Nvyrp/+uPdvAFWs4UANUOE+N8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BVMbfxqwOvW6SEPDYAf1KH/5wHcFl/f3Ybz2ldqi5OFFzStot5jS/GlkB1Xpt8m4T
	 xY6NPt7NHolE4F9EBYMVUV26DHS6sioICA89YYzDHNRrRUsuwifViSAgW31gg7064g
	 BqoCBZwwDKtAemMnH7+ND9dhv2MBtQmFideI0SYo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE312F805FB; Tue, 13 Oct 2026 15:03:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50D27F805FA;
	Tue, 13 Oct 2026 15:03:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A825F800B0; Tue, 13 Oct 2026 15:03:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791896621;
	b=Mrv0vD3UfifIibM/+N63yZBJCkiveIb80bJ2dBSZkNja4o3h8z5lzL+V3ZI10G7Glsb3
	 3WLxQG1nT0yiT+O6Me8M6bD3vRpa8+gO1WSA0C+ScKreM9GgTwG/bFhPLd3/Bxvq2OGCi
	 PVFeTdNNqEqUuLU0qEcmb+x7Nu7WqvRfDY/MfMVE0NeVLCetIpdsmH9VDJ7mTiCrpLEmr
	 /h4csIof9uLqoWxBjAjH6mQ8Hub9i5JEk7jrBrLIs3TlSamN0RB8kLZJ+IvOC6fQgj6fZ
	 +jIE2Tft6qejCbbCuZkhTo+oE2Gp6BwDixE5q/r/OUsuNGQRqS8ZgRIwE3pJnpbbyew==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791896621;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=uVjcc/KF4L/qAuKP4Nvyrp/+uPdvAFWs4UANUOE+N8s=;
	b=hIeLgXf934JJP8HONAdJYhneaXK1A65Q7hq0vKLJ874BDYAHuMuQ6DnHL3U2ihKx6XHX
	 lLpGb4bRLFM301YvdzPx1x2a6Eh78vbEaxGgKKP7M6UrwLo/0DXWcRisiboeyPi+ca7Nd
	 tR4+BTsdQhTICKqv4XF4oaJ4FoGyAJxrAgkS9dH/gDgOsD/XwkNPIKWkRoyYp57ZgFu+i
	 mEVUh9Et5PNaEf5h3o+HitihYc6lTbFN1n+4f0jsZUwqTJZu5UG69oO6Z6Fo0ar4rShnF
	 tX5LScqD7fHFTRdZNZJ7lUtz7yL3Z6ppJPMyx9CdHwRDtyxm/Obg2rPB3XCYWp6FofA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 8C851F800B0
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 15:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C851F800B0
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70B2.000000006ACE2C24.00339CD6;
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
Subject: [PATCH v2 2/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI
 calibration data
Date: Tue, 13 Oct 2026 15:02:21 +0200
Message-ID: 
 <12a1ab265a1dc0e3a062a54287c8ef48682c4efc.1791895478.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791895478.git.soyer@irl.hu>
References: <cover.1791895478.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: ZBMY6FWZ7H4EYGDWNORCWFAV5EP2H2BB
X-Message-ID-Hash: ZBMY6FWZ7H4EYGDWNORCWFAV5EP2H2BB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZBMY6FWZ7H4EYGDWNORCWFAV5EP2H2BB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some Lenovo 14ARB7 laptops do not have proper calibration data.

Skip these zero calibration values and fall back to the calibration data
provided by the DSP firmware.

Tested-by: Georg Wenzel <g.wenzel@gmail.com>
Fixes: c3ca4458cc2f ("ALSA: hda/tas2781: add TAS2563 support for 14ARB7")
Cc: <stable@vger.kernel.org> # 6.18
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes is v2:
 - none

---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index cff8fab8133a..44855f593daf 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -372,6 +372,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			if (*(uint32_t *)&data[offset] == 0) {
+				dev_warn(p->dev,
+					 "Dev %d: Caldat[%d] is zero\n", i, j);
+				return -EINVAL;
+			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
 			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
-- 
2.56.0

