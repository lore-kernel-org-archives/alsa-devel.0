Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D8C11F69
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBA761448
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBA761448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25D961712;
	Sat, 10 Jul 2021 04:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25D961712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884357;
	bh=q6r+96DNfehs42FToLeU7CUqZMXqYiP4s8FIw2Wg+/8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKhfaYuOgOoRl8PewnWTXTYVux3rn3/lXZz4BtuHTNAhP4mfrouls6VC1jjxRra67
	 /dJ2m7Vf+0loY6KoZ5hO6S8XQvpaKzRwUYUt128I6M5NIYnkQpBHexLQ9h+OkTAuNp
	 H6qZoJf/aIBPxsG9b78EekDxXDONOh5SWDnPPlVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E582EF805AB;
	Sat, 10 Jul 2021 04:24:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50A4AF805A0; Sat, 10 Jul 2021 04:24:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CCFAF8053E
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CCFAF8053E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WjCrZ/mP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23CB06140C;
 Sat, 10 Jul 2021 02:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883841;
 bh=q6r+96DNfehs42FToLeU7CUqZMXqYiP4s8FIw2Wg+/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WjCrZ/mPvbBrlE9w458mYRrJ2zVZxVEbKC+DUCHZ7rIM7L7jbl+w2I45zhoSfdhB7
 OztXbkLNbZ6QU+vYiw+seabQW9AGmpy9PU3RioW/WfN0AsWoDIpotAIiwlmjYBiSDB
 DeCBfXrJhw1BnTy2t/obZtblYqsYcUS84fVP213gAh+8w+Bh8bmGx9zIwmYGgYQVub
 lUwVyv89KEZzD3yiHWOIJnuVds1tEURbX/WK+bp0Uh/gaV+EkIfU2fUkI13GPrsAmK
 /4jxRzFfFZp5an8L426Pd8gz7kvdahbk4JGX6UI/E/x1BgnOcq0bND+HaMOuJ9lVDb
 Mlpd7m3GVjoUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 087/104] ALSA: usb-audio: scarlett2: Fix
 scarlett2_*_ctl_put() return values
Date: Fri,  9 Jul 2021 22:21:39 -0400
Message-Id: <20210710022156.3168825-87-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, "Geoffrey D. Bennett" <g@b4.vu>
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

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit c5d8e008032f3cd5f266d552732973a960b0bd4b ]

Mixer control put callbacks should return 1 if the value is changed.
Fix the sw_hw, level, pad, and button controls accordingly.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/20210620164645.GA9221@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 63d6a5e45ba9..a829c3c7a30c 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1179,6 +1179,8 @@ static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
 	/* Send SW/HW switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_SW_HW_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1239,6 +1241,8 @@ static int scarlett2_level_enum_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1289,6 +1293,8 @@ static int scarlett2_pad_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PAD_SWITCH,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
@@ -1344,6 +1350,8 @@ static int scarlett2_button_ctl_put(struct snd_kcontrol *kctl,
 	/* Send switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_BUTTONS,
 				       index, val);
+	if (err == 0)
+		err = 1;
 
 unlock:
 	mutex_unlock(&private->data_mutex);
-- 
2.30.2

