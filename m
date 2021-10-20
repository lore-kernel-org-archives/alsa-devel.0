Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64233C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 15:27:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9A661371
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 15:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D9A661371
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AF99168F;
	Wed, 20 Oct 2021 17:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AF99168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634743675;
	bh=CE3xAhSZp/6tcl/r/3qwygCbpvLygcXbmqamY6V8mNY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p7cdQ29tVJiHsTWgb5jRZjq8MS9zTcGzwdPBVY8T7fRyhtXar2ZGveG4QZX1UEoxo
	 QRdIG23wkxs9mN9xCbgfH/xG+4n/ITxdSQYGFdQpG4EFfbw0A+uEBxtBQna5NDFzMK
	 I6mMLVYinI5O08JUCYNJ88xPqE11gUyHw0DHIPlI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D7E7F80253;
	Wed, 20 Oct 2021 17:26:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CE7FF802E0; Wed, 20 Oct 2021 17:26:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F2ADF80253
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 17:26:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F2ADF80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="SODgY0MV"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="cxsQX5wD"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A2C541FD39
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634743570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=489TJPc7O/FGwqXHKEz17ETkdogvLRstQrdHsa6WMbU=;
 b=SODgY0MV8rbwh7x9TLbmAVXXIFXqi+erPbxwqsR1HxeYeKylGiKnwyRh0CPdjeu4dCLEVD
 6//MsBnw/ObU1nbeRdFEx75Din+1iSNIJR7yL/s3OUzcA5lssXbo8R7Eqd5i0C7IUApglP
 wDGrCU5yIn8WUcQtVIuHQ5mkqi8Os/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634743570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=489TJPc7O/FGwqXHKEz17ETkdogvLRstQrdHsa6WMbU=;
 b=cxsQX5wD+Qih6SPT2JNfd693MiMs5tS43wocbnkI4siwd78x9osGKRwqhV+8rtpfbI1om6
 lokkmgg9UmO7c8Dg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 91B4BA3B81;
 Wed, 20 Oct 2021 15:26:10 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils 1/2] alsamixer: Check the availability of mouse
Date: Wed, 20 Oct 2021 17:26:07 +0200
Message-Id: <20211020152608.27985-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

Let's check the availiabiy via has_mouse().  Otherwise the program
aborts unexpectedly just focusing on my rxvt terminal :-(

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsamixer/mainloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsamixer/mainloop.c b/alsamixer/mainloop.c
index e67c0f821e8a..cdbe28e390fd 100644
--- a/alsamixer/mainloop.c
+++ b/alsamixer/mainloop.c
@@ -50,7 +50,7 @@ void initialize_curses(bool use_color, bool use_mouse)
 #endif
 	window_size_changed(); /* update screen_lines/cols */
 	init_colors(use_color);
-	if (use_mouse)
+	if (use_mouse && has_mouse())
 		mousemask(ALL_MOUSE_EVENTS, NULL);
 	snd_lib_error_set_handler(black_hole_error_handler);
 }
-- 
2.26.2

