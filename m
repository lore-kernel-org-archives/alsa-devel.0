Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15382C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDFD60EDF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EDFD60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1765168B;
	Thu, 14 Oct 2021 15:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1765168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634216885;
	bh=JA9FK3eJiGhP9jAB4ELZo4r7Q2en6tU7cHdpzeAGfHk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fnKBFROQq4Iv9g465t88k0f3e5fh99C7Tj41xfl0xeO7/Bn55vLJYj9BjDrMo/qSs
	 RX6muMWXMPhNuHRa70z9ijN5yNqiIQqpSBcygHVPXsPqi0sGBqUT8n9lr3J65PuN5Z
	 LsIGzK5zT7sK3lrYPXGOb2e9icANl0vOCMV7VfvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8914DF804E4;
	Thu, 14 Oct 2021 15:06:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D016EF804E5; Thu, 14 Oct 2021 15:06:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80069F8016C
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 15:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80069F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="1n/svAA7"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="zu/Hd3JN"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 207841FD36;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634216799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/c8fJy4bKqMYhmQkaVpdRsEYGLwA9KNgZQcwQdyy8b8=;
 b=1n/svAA7Q1NUeQ6WgwgxlhVtsphidcEOk/w9iUjX1vNh6zjDSg6edFyhwzWRL6bJ2qzwCQ
 fKaZSX0JhOK8DtH/wYPIyDvkAwCN8JvReFGWM4HxEP4ysHH7H52Nw6+8xB7MxVaIfS/1o/
 l6Qlch4qoZYkdTbfmFIK7vn/pR9fPrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634216799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/c8fJy4bKqMYhmQkaVpdRsEYGLwA9KNgZQcwQdyy8b8=;
 b=zu/Hd3JNzDbceXVa1EtqEE3xeyd2DPGUjZMgipgl3cXa2Z5UqKGsxLTEcx7w4gVxVbftKl
 1iIcy9O6zPN6VRCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 0E00FA3B84;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ALSA: usb-audio: Drop superfluous error message after
 disconnection
Date: Thu, 14 Oct 2021 15:06:35 +0200
Message-Id: <20211014130636.17860-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014130636.17860-1-tiwai@suse.de>
References: <20211014130636.17860-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

The error from snd_usb_lock_shutdown() indicates that the device is
disconnected, hence it makes no sense to show any further control
message error in get_ctl_value_v2().  Return the error directly
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a20af9243155..60d394361a43 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -361,9 +361,8 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 
 	memset(buf, 0, sizeof(buf));
 
-	ret = snd_usb_lock_shutdown(chip) ? -EIO : 0;
-	if (ret)
-		goto error;
+	if (snd_usb_lock_shutdown(chip))
+		return -EIO;
 
 	idx = mixer_ctrl_intf(cval->head.mixer) | (cval->head.id << 8);
 	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
@@ -372,7 +371,6 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 	snd_usb_unlock_shutdown(chip);
 
 	if (ret < 0) {
-error:
 		usb_audio_dbg(chip,
 			"cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 			request, validx, idx, cval->val_type);
-- 
2.26.2

