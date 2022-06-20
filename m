Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6214C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 10:41:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98C3B18FC;
	Mon, 20 Jun 2022 12:40:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98C3B18FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655721702;
	bh=jgajvZSVbngwPdv8HnL0huL7PBUl2O1JJE8YZ5rwuQs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bKHwVdOWzjWhQT7dhKeTDjyv5b05geS6lGgJP9c40Sht8JgEW6Ly7ho9yPhNmrm1i
	 ezWhN4jiHkBRZxJp4JasCy5mOGQNpHTIu5gjhMcYxwwGu33zKTAVeNy3KnK2gsG3Wx
	 KFn8Bq+xjsSvBKsWNhuNvlohTt4nYXrXiauLV5+g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C309AF804DA;
	Mon, 20 Jun 2022 12:40:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1FCEF804DA; Mon, 20 Jun 2022 12:40:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5B0CF804CF
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 12:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5B0CF804CF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="F0YaDMv5"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="PYo72Xv3"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62DCE21BF0;
 Mon, 20 Jun 2022 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655721611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4We8pPMCTJdlem82aPMrZco7LO4PI+1zH3wBmd56jI=;
 b=F0YaDMv58oaihiNOC1hMu45bMjGYlNEs2yzqbMNdeqgNqLjoZaXzM2+KPjEMqIbvxgMGWO
 oZ9tUQjTEqNsHasQgamb42BeuHZupnw+ZCKG7hx6oouq31TL3n0k68lbI+UnqLNbB3cMSj
 +8BDswmIk6PWdpPXFyWm0KwKIzNTx4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655721611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4We8pPMCTJdlem82aPMrZco7LO4PI+1zH3wBmd56jI=;
 b=PYo72Xv3YDo+bgxdWGTasQtnVynZHGFCZ8uoihh0x7EYe55JY0snjNzWl44Y4pkjBewNga
 8aY+7GwV2ORtZWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A4A713A79;
 Mon, 20 Jun 2022 10:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2PV6EYtOsGJkaAAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 20 Jun 2022 10:40:11 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: hda/via: Fix missing beep setup
Date: Mon, 20 Jun 2022 12:40:08 +0200
Message-Id: <20220620104008.1994-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620104008.1994-1-tiwai@suse.de>
References: <20220620104008.1994-1-tiwai@suse.de>
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

Like the previous fix for Conexant codec, the beep_nid has to be set
up before calling snd_hda_gen_parse_auto_config(); otherwise it'd miss
the path setup.

Fix the call order for addressing the missing beep setup.

Fixes: 0e8f9862493a ("ALSA: hda/via - Simplify control management")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216152
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index a05304f340df..aea7fae2ca4b 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -518,11 +518,11 @@ static int via_parse_auto_config(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
+	err = auto_parse_beep(codec);
 	if (err < 0)
 		return err;
 
-	err = auto_parse_beep(codec);
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
 		return err;
 
-- 
2.35.3

