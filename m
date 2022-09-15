Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165B5ECAAD3
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Sep 2022 09:00:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D7F118F4;
	Thu, 15 Sep 2022 10:59:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D7F118F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663232449;
	bh=pzVKI9VIuq3gSHnz8FsPWP7JpIHr5wL2ljtvBA7RHTU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oRHt9WEEYVMD6NOYCrpTPPRZWbW242jpHABeulliYI2q6a68MMwXkAnJvDyE/inSI
	 JYBFTL5M5Q0b5qmFEArUeqgiUV2Aqh/2Dn83QkHZEFvnV3y7DRy7A28SAqgJtMCWt1
	 LmQ/GaBHzjl91+xc/k9wMe4ta+UOVqh6JXufhCiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16959F8013D;
	Thu, 15 Sep 2022 10:59:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A001CF80238; Thu, 15 Sep 2022 10:59:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57ADEF800B5
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 10:59:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57ADEF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="PYemaeOY"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="twg2NEEi"
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A7F95CCF6;
 Thu, 15 Sep 2022 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1663232390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=02QYV8muV3WLcYhIGKHWIq/OEahSQP0rVx+4N0enhLY=;
 b=PYemaeOYJwdhmLeAVppa9271AdTq0AfL4RRt5enFrAj4TovHeGWQZ7buRoOvzott89/Vmj
 AMY7GzOc02D+oRk+rUyyZCF9Vpya+S/snGwHbpzZnYUvfS4GwhJdYIGcBrqS805BUu/ktD
 D0NftcUrRaCYAHu1kH7IGQr7fxIulHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1663232390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=02QYV8muV3WLcYhIGKHWIq/OEahSQP0rVx+4N0enhLY=;
 b=twg2NEEiSeeXOCayd0kzoASDnGUhOFZ20ldPwOhcXbMFyzroS9QCoWET3e/e08XHqRDeGK
 q7qyDMxI5qEVYABA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 51665132BD;
 Thu, 15 Sep 2022 08:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id /WX/EobpImMtEwAAGKfGzw
 (envelope-from <tiwai@suse.de>); Thu, 15 Sep 2022 08:59:50 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix last interface check for registration
Date: Thu, 15 Sep 2022 10:59:47 +0200
Message-Id: <20220915085947.7922-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

The recent fix in commit 6392dcd1d0c7 ("ALSA: usb-audio: Register card
at the last interface") tried to delay the card registration until the
last found interface is probed.  It assumed that the probe callback
gets called for those later interfaces, but it's not always true; as
the driver loops over the descriptor and probes the matching ones,
it's not separately called via multiple probe calls.  This results in
the missing card registration, i.e. no sound device.

For addressing this problem, replace the check whether the last
interface is processed with usb_interface_claimed() instead of the
comparison with the probe interface number.

Fixes: 6392dcd1d0c7 ("ALSA: usb-audio: Register card at the last interface")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 3aea241435fb..a5ed11ea1145 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -884,7 +884,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 	 * one given via option
 	 */
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum) {
+	    usb_interface_claimed(usb_ifnum_to_if(dev, chip->last_iface))) {
 		err = snd_card_register(chip->card);
 		if (err < 0)
 			goto __error;
-- 
2.35.3

