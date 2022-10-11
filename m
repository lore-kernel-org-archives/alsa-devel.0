Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABD7C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Oct 2022 07:02:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 480FD3777;
	Tue, 11 Oct 2022 09:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 480FD3777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665471766;
	bh=IiOTpXIxfyNJ9J4iLCeOmUmlD/6qzn1KHAFI5aTFSRU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bFGuOZh09QqSvpYtidrYhHQgY5tc6avExQXMwZ3Gh+Dj1Y1gZLoYdt4kH29aI/o5u
	 A9LOj14CLEsGP66iLGMtoRnlVQUNi7ifjmdx1aGwhGHUCt8nro+A61kzlUyILv/3Cx
	 i3K70VXejhXfrzZURJ8vfgMk7VOJJ3QLwkKJOVU0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA6BBF801D5;
	Tue, 11 Oct 2022 09:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F381F8021D; Tue, 11 Oct 2022 09:01:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1184EF800C0
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2022 09:01:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1184EF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="dm0idmEu"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="vdMcecHy"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66F7021D7E;
 Tue, 11 Oct 2022 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665471712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyDTxgfEGR6I75hzLWiKpi7+ZfpDT2sS648uVSEXRAQ=;
 b=dm0idmEuNV1XRGzApLsWp0U9T0sr2ysrAiV5PKPyCoE44QhV9VgmYKLB0eIwcnxzca9QWw
 +NTMhaVjj3ogbRZ9IQSDJ4wA+d+D4ugb7IwWLQPIgdazPcndp/DJEkfa9Fkvui6RAXdMUW
 3HTr3vsatwBooLEcUeASxBZ2sEQbBJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665471712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyDTxgfEGR6I75hzLWiKpi7+ZfpDT2sS648uVSEXRAQ=;
 b=vdMcecHyoUQV/HwhZC9xItOVL3l57Pl1M0D9aRtFJu8FZdj/enquAmtHZZga7Nlc9pSPgL
 0etxrTfxqbi8IWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B6013ACA;
 Tue, 11 Oct 2022 07:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gINQEOAURWOafAAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 11 Oct 2022 07:01:52 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: oss: Fix potential deadlock at unregistration
Date: Tue, 11 Oct 2022 09:01:47 +0200
Message-Id: <20221011070147.7611-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011070147.7611-1-tiwai@suse.de>
References: <20221011070147.7611-1-tiwai@suse.de>
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

We took sound_oss_mutex around the calls of unregister_sound_special()
at unregistering OSS devices.  This may, however, lead to a deadlock,
because we manage the card release via the card's device object, and
the release may happen at unregister_sound_special() call -- which
will take sound_oss_mutex again in turn.

Although the deadlock might be fixed by relaxing the rawmidi mutex in
the previous commit, it's safer to move unregister_sound_special()
calls themselves out of the sound_oss_mutex, too.  The call is
race-safe as the function has a spinlock protection by itself.

Link: https://lore.kernel.org/r/CAB7eexJP7w1B0mVgDF0dQ+gWor7UdkiwPczmL7pn91xx8xpzOA@mail.gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/sound_oss.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 7ed0a2a91035..2751bf2ff61b 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -162,7 +162,6 @@ int snd_unregister_oss_device(int type, struct snd_card *card, int dev)
 		mutex_unlock(&sound_oss_mutex);
 		return -ENOENT;
 	}
-	unregister_sound_special(minor);
 	switch (SNDRV_MINOR_OSS_DEVICE(minor)) {
 	case SNDRV_MINOR_OSS_PCM:
 		track2 = SNDRV_MINOR_OSS(cidx, SNDRV_MINOR_OSS_AUDIO);
@@ -174,12 +173,18 @@ int snd_unregister_oss_device(int type, struct snd_card *card, int dev)
 		track2 = SNDRV_MINOR_OSS(cidx, SNDRV_MINOR_OSS_DMMIDI1);
 		break;
 	}
-	if (track2 >= 0) {
-		unregister_sound_special(track2);
+	if (track2 >= 0)
 		snd_oss_minors[track2] = NULL;
-	}
 	snd_oss_minors[minor] = NULL;
 	mutex_unlock(&sound_oss_mutex);
+
+	/* call unregister_sound_special() outside sound_oss_mutex;
+	 * otherwise may deadlock, as it can trigger the release of a card
+	 */
+	unregister_sound_special(minor);
+	if (track2 >= 0)
+		unregister_sound_special(track2);
+
 	kfree(mptr);
 	return 0;
 }
-- 
2.35.3

