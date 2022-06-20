Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A39C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 10:41:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91F6318B1;
	Mon, 20 Jun 2022 12:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91F6318B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655721670;
	bh=yHEC4MsbckMLj/AjtOYyD2sR5iaJacTi5SgvIaXqQck=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WPsA5qKSKuV5IesQTssDLgxDCniFryPUgJdSgSsi9yfKZ3DawThOhRkPqHiZvhUGi
	 BENrbL/h6kKASoFWzjM0knvYnaRJhtQNLDoP+h7rZHWKxVRIMovLdHRAATyfpUF/Z8
	 jAo2Ubf2qS13cxi58DVznSvenNEEpXmRH/QHQziI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F730F804D2;
	Mon, 20 Jun 2022 12:40:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA2C9F800E3; Mon, 20 Jun 2022 12:40:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 926AFF800E3
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 12:40:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 926AFF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="TXhaxyb0"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="yOMdLCQp"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 48A411F86C;
 Mon, 20 Jun 2022 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655721611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HYTyGcGqVkdVHkmhSrloqtzhP7fP5XuzRyeO21MPDAE=;
 b=TXhaxyb08ggNW1iraZV8iP5LLrfCd9tBOSouW90bypK+z27Mz3Og+ORlymwXo9AZjK2qNq
 D/KNOf1xjf/qy83lELtSwGWQSA1ow5L9HIylcuRCoKDhK7uf2c4oloo1mKjc1iy3+cScOK
 JZ6nI668uj0mXTAhRTpj3VGPtuOzGNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655721611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HYTyGcGqVkdVHkmhSrloqtzhP7fP5XuzRyeO21MPDAE=;
 b=yOMdLCQpaEQStxuSoIR1EnVQCojrxmBbOkFQ3fkyyHByiAJO2RvofZSyF/X0E2Xzju1YC3
 buhT81cfHpCd01CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E89413638;
 Mon, 20 Jun 2022 10:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Pf5bCotOsGJkaAAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 20 Jun 2022 10:40:11 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: hda/conexant: Fix missing beep setup
Date: Mon, 20 Jun 2022 12:40:07 +0200
Message-Id: <20220620104008.1994-1-tiwai@suse.de>
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

Currently the Conexant codec driver sets up the beep NID after calling
snd_hda_gen_parse_auto_config().  It turned out that this results in
the insufficient setup for the beep control, as the generic parser
handles the fake path in snd_hda_gen_parse_auto_config() only if the
beep_nid is set up beforehand.

For dealing with the beep widget properly, call cx_auto_parse_beep()
before snd_hda_gen_parse_auto_config() call.

Fixes: 51e19ca5f755 ("ALSA: hda/conexant - Clean up beep code")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216152
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 1248d1a51cf0..3e541a4c0423 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1079,11 +1079,11 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
+	err = cx_auto_parse_beep(codec);
 	if (err < 0)
 		goto error;
 
-	err = cx_auto_parse_beep(codec);
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
 		goto error;
 
-- 
2.35.3

