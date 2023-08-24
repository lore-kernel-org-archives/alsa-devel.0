Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2968C6FA8F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:11:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D724850;
	Fri, 25 Aug 2023 00:11:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D724850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692915112;
	bh=tFnLCN2g4gf0OOoduH7LW9BJfU0IRcutqh/CyLEhwnY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=T2M4ZW+AnnHz3RW8tNQ6yA9y31pAc5SAIQprRuOQASBCHV2TpqMsOR2v3RhIPYwWb
	 ttIT5mOMQpr9JtM5MFIgkIAMdjiKMCuI0EtTWW6Qqh0CDkGlUvhoK2NwOWtxrjEPQz
	 4gug3Dou6gIIM9UlyxrOuquImBjtUAbtS2SJZskc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DA77F805E2; Fri, 25 Aug 2023 00:10:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B702DF805DA;
	Fri, 25 Aug 2023 00:10:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65854F805DA; Fri, 25 Aug 2023 00:10:35 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4912F805C9
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 00:10:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4912F805C9
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qZIWz-0001X5-8H; Fri, 25 Aug 2023 00:10:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qZIWx-001NPr-Lx; Fri, 25 Aug 2023 00:10:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qZIWx-00FrXF-1i; Fri, 25 Aug 2023 00:10:19 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	alsa-devel@alsa-project.org,
	kernel@pengutronix.de
Subject: [PATCH] ALSA: hda/tas2781: Switch back to use struct i2c_driver's
 .probe()
Date: Thu, 24 Aug 2023 22:02:19 +0200
Message-Id: <20230824200219.9569-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=tFnLCN2g4gf0OOoduH7LW9BJfU0IRcutqh/CyLEhwnY=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk57dKU47UARpABHuWxLefr6+98gJj7/5IYuzEY
 mb2mtGlv1yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZOe3SgAKCRCPgPtYfRL+
 TljECACaRS59S7MizMp8pOQTs3sqzgBnt7Ye1+mg7VHxzZaye1pjWFF2rbvCLREJidapfeOF2qp
 wEXMqZ8+nZI9pSV35LJvMvgY3yhx+gZCXMPbIVxsqrmxjLMF1E/8ugvaX83AMT6PnKXZdYbd0ol
 mSsCVUkuD6wJb1ER5Znq7cO1M8BcJ/ouoYIvkklPFLg8kJ2kuyIhWmCbPOooyAwt8h18AJ6ucMB
 g4GKk3hDUJoowu1n5pR8s0u5PulS4ou+h8qOajajwzgUPff6U/JJqebXjIxPo2yx/evONDy7vQX
 K32SqbcLf2G2GNgXIvg7hZ2U0MoXLizs/GAykAu6AN5uBV1J
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: LPKUI5SXFUS746LH47SP3A56BKNLX7N5
X-Message-ID-Hash: LPKUI5SXFUS746LH47SP3A56BKNLX7N5
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LPKUI5SXFUS746LH47SP3A56BKNLX7N5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

struct i2c_driver::probe_new is about to go away. Switch the driver to
use the probe callback with the same prototype.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this driver was introduced in next-20230821. As I plan to drop
.probe_new in next after v6.6-rc1, it would be great if this patch made
it in until then, too.

Thanks
Uwe

 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 35dafc4aec4f..cf62a87563ea 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -847,7 +847,7 @@ static struct i2c_driver tas2781_hda_i2c_driver = {
 		.pm		= &tas2781_hda_pm_ops,
 	},
 	.id_table	= tas2781_hda_i2c_id,
-	.probe_new	= tas2781_hda_i2c_probe,
+	.probe		= tas2781_hda_i2c_probe,
 	.remove		= tas2781_hda_i2c_remove,
 };
 module_i2c_driver(tas2781_hda_i2c_driver);

base-commit: 5be27f1e3ec98975c18a91e220d4847d0dec9671
-- 
2.40.1

