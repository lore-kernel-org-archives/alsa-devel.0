Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE15C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:28:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB57611C0
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB57611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63AA61758;
	Thu, 15 Jul 2021 10:28:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63AA61758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337730;
	bh=BcouPs2oiOXfISqCuhU9v3hJt1yTHbZsJ/KJv8DjMYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kwnh0PUB7zdm920NeXmIdd5qC0nFfe6+3qU8Eu8M49wQRuSaKDiKDcCsTuvjmiu6T
	 Dk4b7xiRQi4uyrGxviVkdOSQRIx53Tci5Wp7zRzZ72gyS58LaKGGd/XxMGvqROpfTt
	 HlQmU/+jqr67TKCF6GxTRED6EiKY2txHtv7wsSd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B93E0F80852;
	Thu, 15 Jul 2021 10:01:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B075F807DE; Thu, 15 Jul 2021 10:01:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6276BF804E5
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6276BF804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="pvUtnCip"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ALOOgWRi"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3B45622856
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBwQBJBGsn4PeR2I3zEBE2ni2A8jQnZMXEn2wo06JxI=;
 b=pvUtnCipJzm+FkYNV4hfK8pgwFJZEY7AuwpW3XDB8/icM9f9aCeFXPHnAO2shDFHdcx2Au
 0MJ6BJVnylVWhazH8dw+XpZakQBYk7VVA+hskPgC1B6X6MErZdGB2P0UP5ajyUCvtepV73
 sHwtrC4sPsW/6quvSMyxXrpp4cnou2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBwQBJBGsn4PeR2I3zEBE2ni2A8jQnZMXEn2wo06JxI=;
 b=ALOOgWRiR1LfwyzZKuhn8IvlPftp9tWH1TZehIYrhEYO7x4IJcH+otCKzLIXz7Xb1GYbtr
 TBU6vN3btUSzR+BQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 29E58A3B8F;
 Thu, 15 Jul 2021 08:00:24 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 73/79] ALSA: virmidi: Allocate resources with
 device-managed APIs
Date: Thu, 15 Jul 2021 09:59:35 +0200
Message-Id: <20210715075941.23332-74-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715075941.23332-1-tiwai@suse.de>
References: <20210715075941.23332-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch converts the card object management with devres as a clean
up.  The remove callback gets reduced by that.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/virmidi.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index 4206d93ab47e..7f7eed6faaae 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -75,8 +75,8 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 	int idx, err;
 	int dev = devptr->id;
 
-	err = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
-			   sizeof(struct snd_card_virmidi), &card);
+	err = snd_devm_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+				sizeof(struct snd_card_virmidi), &card);
 	if (err < 0)
 		return err;
 	vmidi = card->private_data;
@@ -94,7 +94,7 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 
 		err = snd_virmidi_new(card, idx, &rmidi);
 		if (err < 0)
-			goto __nodev;
+			return err;
 		rdev = rmidi->private_data;
 		vmidi->midi[idx] = rmidi;
 		strcpy(rmidi->name, "Virtual Raw MIDI");
@@ -106,18 +106,10 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 	sprintf(card->longname, "Virtual MIDI Card %i", dev + 1);
 
 	err = snd_card_register(card);
-	if (!err) {
-		platform_set_drvdata(devptr, card);
-		return 0;
-	}
-__nodev:
-	snd_card_free(card);
-	return err;
-}
+	if (err)
+		return err;
 
-static int snd_virmidi_remove(struct platform_device *devptr)
-{
-	snd_card_free(platform_get_drvdata(devptr));
+	platform_set_drvdata(devptr, card);
 	return 0;
 }
 
@@ -125,7 +117,6 @@ static int snd_virmidi_remove(struct platform_device *devptr)
 
 static struct platform_driver snd_virmidi_driver = {
 	.probe		= snd_virmidi_probe,
-	.remove		= snd_virmidi_remove,
 	.driver		= {
 		.name	= SND_VIRMIDI_DRIVER,
 	},
-- 
2.26.2

