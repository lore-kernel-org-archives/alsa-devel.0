Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19878C00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 16:59:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59EC386E;
	Mon,  1 Aug 2022 18:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59EC386E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659373176;
	bh=a7ZYli3zwEc3NPRb6TCeo0s6OaDNsFq1z8j7Ftym5Ks=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrcbbQBTXU8FOno7TlnZlNZ6vGxSKQduj/F/WUwI7JiE2HwNVxH58C/96bGjWBj3/
	 Zy9PZtnORTTsa8zCc/dhBnQXWm+YwiUgiT0vv0GVqtoAeV2AQunTTSQ6tLsvugfAha
	 FJfNgrFIyKXTuxQrmBg27aIBP7in30NWgyq87Ga4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94389F8057B;
	Mon,  1 Aug 2022 18:57:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E717BF80543; Mon,  1 Aug 2022 18:56:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25C23F80539
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 18:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25C23F80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="zwf/SAlX"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="mdaocXIJ"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C34B20634;
 Mon,  1 Aug 2022 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659373003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en3FH7KP8atLaCOct0SjAHt2FjqcoX64pmm7Fiubz6Y=;
 b=zwf/SAlXrmA4XEFwta9xnAJx2cEzhKP9CgIImsleX1VGzP0QZqAfJI7gw3QE/AuWT3W7ol
 RUVFPaWLrvicZHmJJBqbZO/UnIvbpY1hlEc8Ry1YY/2v7jtuJPUM8Xsqx5iaOyoUSNhmnI
 If50MRykj5OvsCf+1bJg0ugtqrGewIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659373003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en3FH7KP8atLaCOct0SjAHt2FjqcoX64pmm7Fiubz6Y=;
 b=mdaocXIJYzvxIIQ/DWXt+cPYCdfYuQADUATVO+UGqQEYQfTyB2QtvIe3LBW07V64lK6vUJ
 GF8BpeoBcBiXnRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 010C713ADF;
 Mon,  1 Aug 2022 16:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SMobO8oF6GLXGgAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 01 Aug 2022 16:56:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/7] ALSA: control-led: Replace sprintf() with sysfs_emit()
Date: Mon,  1 Aug 2022 18:56:35 +0200
Message-Id: <20220801165639.26030-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801165639.26030-1-tiwai@suse.de>
References: <20220801165639.26030-1-tiwai@suse.de>
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

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co.  This patch replaces such sprintf()
calls with sysfs_emit() while simplifying the open code in
list_show().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control_led.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 207828f30983..f975cc85772b 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -405,7 +405,7 @@ static ssize_t mode_show(struct device *dev,
 	case MODE_ON:		str = "on"; break;
 	case MODE_OFF:		str = "off"; break;
 	}
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static ssize_t mode_store(struct device *dev,
@@ -443,7 +443,7 @@ static ssize_t brightness_show(struct device *dev,
 {
 	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
 
-	return sprintf(buf, "%u\n", ledtrig_audio_get(led->trigger_type));
+	return sysfs_emit(buf, "%u\n", ledtrig_audio_get(led->trigger_type));
 }
 
 static DEVICE_ATTR_RW(mode);
@@ -618,8 +618,7 @@ static ssize_t list_show(struct device *dev,
 	struct snd_ctl_led_card *led_card = container_of(dev, struct snd_ctl_led_card, dev);
 	struct snd_card *card;
 	struct snd_ctl_led_ctl *lctl;
-	char *buf2 = buf;
-	size_t l;
+	size_t l = 0;
 
 	card = snd_card_ref(led_card->number);
 	if (!card)
@@ -627,23 +626,19 @@ static ssize_t list_show(struct device *dev,
 	down_read(&card->controls_rwsem);
 	mutex_lock(&snd_ctl_led_mutex);
 	if (snd_ctl_led_card_valid[led_card->number]) {
-		list_for_each_entry(lctl, &led_card->led->controls, list)
-			if (lctl->card == card) {
-				if (buf2 - buf > PAGE_SIZE - 16)
-					break;
-				if (buf2 != buf)
-					*buf2++ = ' ';
-				l = scnprintf(buf2, 15, "%u",
-						lctl->kctl->id.numid +
-							lctl->index_offset);
-				buf2[l] = '\0';
-				buf2 += l + 1;
-			}
+		list_for_each_entry(lctl, &led_card->led->controls, list) {
+			if (lctl->card != card)
+				continue;
+			if (l)
+				l += sysfs_emit_at(buf, l, " ");
+			l += sysfs_emit_at(buf, l, "%u",
+					   lctl->kctl->id.numid + lctl->index_offset);
+		}
 	}
 	mutex_unlock(&snd_ctl_led_mutex);
 	up_read(&card->controls_rwsem);
 	snd_card_unref(card);
-	return buf2 - buf;
+	return l;
 }
 
 static DEVICE_ATTR_WO(attach);
-- 
2.35.3

