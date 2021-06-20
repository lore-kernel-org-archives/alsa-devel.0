Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A0C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:51:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81FA61042
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81FA61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 580DB16B8;
	Sun, 20 Jun 2021 18:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 580DB16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207906;
	bh=LD7pPiQRaobvTuyJo1rF16uokIsXO0W8WKK58x7XmEA=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b3ANdKrDB0+TWRMSGj62aGfhZ+u/Rkrg7oylWQqZy81zMnoPi1rGVVbMemMde6agA
	 PG042rH8rXUzjzjEl5K5Q18LYkQjSnx2rl+/Yz7v4y5wjhVV0wK8vY/DBwHfxf1uuC
	 +LVOyz3EIYfflcMiqWHeDU5wG07dnBAoM1p9ykmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF8D3F80527;
	Sun, 20 Jun 2021 18:46:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B45DBF804DF; Sun, 20 Jun 2021 18:46:50 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC44FF804DF
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC44FF804DF
Received: by m.b4.vu (Postfix, from userid 1000)
 id 3815761E5F1B; Mon, 21 Jun 2021 02:16:45 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:45 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/14] ALSA: usb-audio: scarlett2: Fix scarlett2_*_ctl_put()
 return values
Message-ID: <20210620164645.GA9221@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

Mixer control put callbacks should return 1 if the value is changed.
Fix the sw_hw, level, pad, and button controls accordingly.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index d6298ab1de56..fe142b7ddb32 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1304,6 +1304,8 @@ static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
 	/* Send SW/HW switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_SW_HW_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1364,6 +1366,8 @@ static int scarlett2_level_enum_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1414,6 +1418,8 @@ static int scarlett2_pad_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PAD_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1469,6 +1475,8 @@ static int scarlett2_dim_mute_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_DIM_MUTE,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
-- 
2.31.1

