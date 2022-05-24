Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E5C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 24 May 2022 06:22:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F43316FA;
	Tue, 24 May 2022 08:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F43316FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653373340;
	bh=z7H4yDFZeFinEGL5VOFvMz/LlS87ZK4OWrIh8TflPxY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W+yEOP7koD21KGzidhctEKxNGV2gt81kvxQecHl7JNzlYK3RGOh9L0hIWL4JDAe8+
	 um1rkxEAq2L6tYpcwnhGMpLIJT2Z0kHz7bgh3kpMdGjV9Xc7DdnrwoZOm7cYYEY+4o
	 4pWUHCifqZDOQG4sGjkhv69nlDIGlsE77v8lFXXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6732F804CC;
	Tue, 24 May 2022 08:21:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B384F800E3; Tue, 24 May 2022 08:21:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01169F800E3
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2022 08:21:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01169F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="n0YAwBtf"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="NIF52iup"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9CE3A219D6;
 Tue, 24 May 2022 06:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653373279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wlQPlZsDd/6VSZIxGSQpTL0V6EXQm4jnKgSnm40c40s=;
 b=n0YAwBtfbFyKKsLUdlILGY+huHwXtw7Y4wzQXWoSz/Ghe393wLvN6VCvze4GtBUGoKDuNF
 MZdWLQMDp4QpXi7U64GphxebgxS2EUUm3sFZd9KStJNlCt8mWver5WmxStFIZeIhPuRmnE
 xvseKqmjmoeV9h3s/NpcUyxvbhJaOr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653373279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wlQPlZsDd/6VSZIxGSQpTL0V6EXQm4jnKgSnm40c40s=;
 b=NIF52iup0czewm2zIMO+S0GhytnJnOFOomRACAEbq1tYLRZmIjSO9U/R6lyvFpyTodJJhJ
 UNAxEr80ty7XeYBQ==
Received: from valkyrie.site.de (unknown [10.163.18.242])
 by relay2.suse.de (Postfix) with ESMTP id 31A9B2C141;
 Tue, 24 May 2022 06:21:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Configure sync endpoints before data
Date: Tue, 24 May 2022 08:21:15 +0200
Message-Id: <20220524062115.25968-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Craig McLure <craig@mclure.net>
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

From: Craig McLure <craig@mclure.net>

Devices such as the TC-Helicon GoXLR require the sync endpoint to be
configured in advance of the data endpoint in order for sound output
to work.

This patch simply changes the ordering of EP configuration to resolve
this.

Fixes: bf6313a0ff76 ("ALSA: usb-audio: Refactor endpoint management")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215079
Signed-off-by: Craig McLure <craig@mclure.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 6d699065e81a..b470404a5376 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -439,16 +439,21 @@ static int configure_endpoints(struct snd_usb_audio *chip,
 		/* stop any running stream beforehand */
 		if (stop_endpoints(subs, false))
 			sync_pending_stops(subs);
+		if (subs->sync_endpoint) {
+			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
+			if (err < 0)
+				return err;
+		}
 		err = snd_usb_endpoint_configure(chip, subs->data_endpoint);
 		if (err < 0)
 			return err;
 		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
-	}
-
-	if (subs->sync_endpoint) {
-		err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
-		if (err < 0)
-			return err;
+	} else {
+		if (subs->sync_endpoint) {
+			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	return 0;
-- 
2.35.3

