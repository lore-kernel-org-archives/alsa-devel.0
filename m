Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DCCC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:59:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39CB860228;
	Tue, 13 Oct 2026 11:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39CB860228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885545;
	bh=elZlIXvUMnp/geopM9cCW2TMimJmZqdyLzKhbGMqQNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y72l452PcGJYGPrkCR8PRGJtsfu5oWRNLUNa/MjC1kwK3IbN/wIIaEuteLVSVDdzw
	 xnz4QUFVrOPBnYV1jVVNmIHnwhsZZNwzF11UWiTQ+nrloTD219FtMfAWBcvvTfeFBP
	 afM8C6xCvw/GmsroIXvH4tHyI1cuCzNUS0Svp++k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C56AF80636; Tue, 13 Oct 2026 11:58:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B66D3F80652;
	Tue, 13 Oct 2026 11:58:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 840EEF80495; Tue, 13 Oct 2026 11:57:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791885467;
	b=Z8MQP7V8HZ+e2TBjLKWHs9sUfZnA2ST6h6amhluSRm87x8Ikt5YAzEh/Kuf3trbC/me+
	 2v43XX6dI6QpkzuDt3g53jNbx18O4eQZDepMyZGIscaQGazYb8ggo2OY77/q1UwTf/Pik
	 TJbHoALPI4MFwwXTtPL4iZibr4yizdBiePrqBKlaMoKPYGyBdTxqjJ7LPrX5W82iar60b
	 bovcdGojAQ1j5hjs7pDMyoKA17xCTEA2uB1baO0QX/zOzF9MfUDKKpQp13QpSb+GaOgb7
	 bHMT3qoup+gWRETDXgr3dj9w63y55N/8NjBaLNUWyV+cyZ6L+K5VTicZSkLOrWfAO2Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885467;
	h=From:To:Subject:Date:Message-ID:Mime-Version;
	bh=elZlIXvUMnp/geopM9cCW2TMimJmZqdyLzKhbGMqQNI=;
	b=ofLcfwvuCnx1s8X3Gl8mjDSc7pGmS9tFX0UbY/Y75Fi/jHGEsFxbOUTC+4eRIlu+36nC
	 tbathWZK4kPyulv0N6yIM/2Cx4O+UfXmsl1JIKVVp8K4Pq74q9/6EudH6uqF7a1vVirAe
	 BoZk46rkx59splZVi+1xKfNOEuohHVkNOT0orVdhNdK5UZA/h/goDL/sTjXZ5FVv3OKrN
	 UWlKnOaY8IgvmYfnFuu7RH+OlY4RSAzWpYSZRiWuSQXN4/QW/cGLaKvl287hDq1t51OnU
	 hFxrJoZxvD3qqtv7S1WvK7l3i284S3YqbpEp0sHmmoRZKzhkmA2P/CQy8UvkoyZERLA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id E9131F800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 11:57:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9131F800EE
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu
 [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70B2.000000006ACE0098.003393F6;
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
Subject: [PATCH 2/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration
 data
Date: Tue, 13 Oct 2026 11:57:04 +0200
Message-ID: 
 <36db4b33db6ef538103867afb793f12f86520ae0.1791883592.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791883592.git.soyer@irl.hu>
References: <cover.1791883592.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Message-ID-Hash: GX3XL2DRVOSMXRNP6I6O6BESETI7DLLU
X-Message-ID-Hash: GX3XL2DRVOSMXRNP6I6O6BESETI7DLLU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GX3XL2DRVOSMXRNP6I6O6BESETI7DLLU/>
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
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index f1329bb6adcd..53d9c101b421 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -371,6 +371,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
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

