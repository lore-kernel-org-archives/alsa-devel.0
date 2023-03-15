Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC2BC61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:12:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83F37125D;
	Wed, 15 Mar 2023 16:12:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83F37125D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678893175;
	bh=58pwx6LCcANvd2JiSXBwBOaBRAasufu5xSQZ0gnGNI4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dx1fsdKtit8J0PcD0m6c+MZs/7Wi/1qrS5ma8+Nn/iwy+qfoYhxLSiey6gcykYf/h
	 5aZ30Pslm3qGJzINUFU6Z/jjUlcbTf54tuf6z2DaYSSUNbF2CYVxiO3luNpKKayCTv
	 Nk5psiCRV1J1EbD9w4+HssuQ/tSklLfdfxxY9/uM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2522BF80580;
	Wed, 15 Mar 2023 16:09:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8E9BF805E0; Wed, 15 Mar 2023 16:08:27 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C07C8F804B1
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C07C8F804B1
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjQ-00076r-Sk; Wed, 15 Mar 2023 16:08:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjQ-004KUR-5D; Wed, 15 Mar 2023 16:08:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjP-0057cZ-23; Wed, 15 Mar 2023 16:07:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 012/173] ALSA: sh_dac_audio: Convert to platform remove
 callback returning void
Date: Wed, 15 Mar 2023 16:05:04 +0100
Message-Id: <20230315150745.67084-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=58pwx6LCcANvd2JiSXBwBOaBRAasufu5xSQZ0gnGNI4=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd1Mag0KQu4LR+fUCnhsNPXIcsRXf/6m7a8oP
 /426+epKxqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHdTAAKCRDB/BR4rcrs
 CQYtB/9lYDayxVlNUVoQup/O6MFWg2vDH6KQv/+k26HVq5WCb0C4PNHkvUOn/xjI5HZvONDu9hj
 tqwjzafkrlHViYDB8Co4nPBLBYo/aYQcKZ+0DtGP0uGfG4VPplMBx/rmcYzKQ7UJJ3lwK4O7xYq
 /i3FBZNYdw8Wy8VLuGeoFsW7m4ELZ2GRg+5aIeA0LN+SIpjKDxdjs+612pbmKlR1ijLZZWVhBRy
 tLA4Ev+2qNUon5dNAFUvdwlxY7Tz5tynHIegR+aO3XF5pWbC7AfRKczqXN7sDb8LOHIVkGYyAmm
 HQst8XCwCcMoLtQtNHaejGSeHqVzBFjWDL4Ktx9Bme7nK7F3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: X76M3XXY5HOT6QZUEN2LHP35TO6DJP3S
X-Message-ID-Hash: X76M3XXY5HOT6QZUEN2LHP35TO6DJP3S
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, kernel@pengutronix.de
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X76M3XXY5HOT6QZUEN2LHP35TO6DJP3S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/sh/sh_dac_audio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 8ebd972846ac..8cf571955c9d 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -257,10 +257,9 @@ static int snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
 
 
 /* driver .remove  --  destructor */
-static int snd_sh_dac_remove(struct platform_device *devptr)
+static void snd_sh_dac_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	return 0;
 }
 
 /* free -- it has been defined by create */
@@ -403,7 +402,7 @@ static int snd_sh_dac_probe(struct platform_device *devptr)
  */
 static struct platform_driver sh_dac_driver = {
 	.probe	= snd_sh_dac_probe,
-	.remove = snd_sh_dac_remove,
+	.remove_new = snd_sh_dac_remove,
 	.driver = {
 		.name = "dac_audio",
 	},
-- 
2.39.2

