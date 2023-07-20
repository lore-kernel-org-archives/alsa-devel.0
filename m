Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3172CEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 08:27:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4024E200;
	Thu, 20 Jul 2023 10:27:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4024E200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689841676;
	bh=/GkoOe3o90wZZyP0e0Y0uFIPGWntQPNFMNFR+AcvQIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CLisYW5h45cNQMH27uraDu++XmnqZXXDlsYP5roRucmIUMcnrSwbEgkUMMR/cSV8Q
	 0XEtb97BhoIZccvN1QOQLbZcPcdl9ON3Z17zSolIdkjsZISIaWXyyMS24xySe4bGJZ
	 EK8zDJCkCbX1xpUqVfYWwAa8ykixzXMVeAqRpsH4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E391F8058C; Thu, 20 Jul 2023 10:26:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F152BF80588;
	Thu, 20 Jul 2023 10:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE9EEF80544; Thu, 20 Jul 2023 10:26:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 67232F8047D
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 10:25:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67232F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Gqu2Jjns;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=JoFUpUnn
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3529122A24;
	Thu, 20 Jul 2023 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1689841557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTQ14JC6mQ5BgjoLhLF6hiXxW4MD7lvfHG7W+rD963g=;
	b=Gqu2Jjnsg9Zc7UHw8arpvV5z9Mt0o3fIkxT1GcqP/MCatnpI5CMbADamJEqRP4+VNYaQTs
	ZyutFQH/8hqVaiXaPEFhzu5BUXd4KmqAECOVJpbyTgk67k4B4fxn1xTTjQk9X/IVhBp2Me
	53dlq/KSndrxBpl0HxqUWt7F31podhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689841557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTQ14JC6mQ5BgjoLhLF6hiXxW4MD7lvfHG7W+rD963g=;
	b=JoFUpUnnwEMBjW0lMbU8zOV0P6EtEQWS88fKnj5AOzX3MtcATCR8ruBpn3NF9DC/tQ94ru
	z5vHCtzwsouxkoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B702133DD;
	Thu, 20 Jul 2023 08:25:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WPWOBZXvuGRrJAAAMHmgww
	(envelope-from <tiwai@suse.de>); Thu, 20 Jul 2023 08:25:57 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: ice1712: Use the standard snd_ctl_add_followers()
 helper
Date: Thu, 20 Jul 2023 10:25:54 +0200
Message-Id: <20230720082554.31891-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720082554.31891-1-tiwai@suse.de>
References: <20230720082554.31891-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MLHP33KKRXCD6MIFWB7EXTD6DXWCDFWH
X-Message-ID-Hash: MLHP33KKRXCD6MIFWB7EXTD6DXWCDFWH
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MLHP33KKRXCD6MIFWB7EXTD6DXWCDFWH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Instead of open-code, use the new standard helper to manage vmaster
stuff for code simplification.

Also, handle the errors from the helper more properly instead of
silently ignoring.

The code changes the call order of snd_ctl_add() of the vmaster object
and its followers for avoiding the possible memory leaks at error
path.  But there should be no difference in the functionality.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/juli.c    | 19 +++----------------
 sound/pci/ice1712/quartet.c | 15 +++------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index d80ecf1edc16..d679842ae1bd 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -408,21 +408,6 @@ static const char * const follower_vols[] = {
 static
 DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
 
-static void add_followers(struct snd_card *card,
-			  struct snd_kcontrol *master,
-			  const char * const *list)
-{
-	for (; *list; list++) {
-		struct snd_kcontrol *follower =
-			snd_ctl_find_id_mixer(card, *list);
-		/* dev_dbg(card->dev, "add_followers - %s\n", *list); */
-		if (follower) {
-			/* dev_dbg(card->dev, "follower %s found\n", *list); */
-			snd_ctl_add_follower(master, follower);
-		}
-	}
-}
-
 static int juli_add_controls(struct snd_ice1712 *ice)
 {
 	struct juli_spec *spec = ice->spec;
@@ -445,8 +430,10 @@ static int juli_add_controls(struct snd_ice1712 *ice)
 					      juli_master_db_scale);
 	if (!vmaster)
 		return -ENOMEM;
-	add_followers(ice->card, vmaster, follower_vols);
 	err = snd_ctl_add(ice->card, vmaster);
+	if (err < 0)
+		return err;
+	err = snd_ctl_add_followers(ice->card, vmaster, follower_vols);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 9450c4b104f7..f61ee9f5c754 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -766,17 +766,6 @@ static const char * const follower_vols[] = {
 static
 DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
 
-static void add_followers(struct snd_card *card,
-			  struct snd_kcontrol *master, const char * const *list)
-{
-	for (; *list; list++) {
-		struct snd_kcontrol *follower =
-			snd_ctl_find_id_mixer(card, *list);
-		if (follower)
-			snd_ctl_add_follower(master, follower);
-	}
-}
-
 static int qtet_add_controls(struct snd_ice1712 *ice)
 {
 	struct qtet_spec *spec = ice->spec;
@@ -797,8 +786,10 @@ static int qtet_add_controls(struct snd_ice1712 *ice)
 			qtet_master_db_scale);
 	if (!vmaster)
 		return -ENOMEM;
-	add_followers(ice->card, vmaster, follower_vols);
 	err = snd_ctl_add(ice->card, vmaster);
+	if (err < 0)
+		return err;
+	err = snd_ctl_add_followers(ice->card, vmaster, follower_vols);
 	if (err < 0)
 		return err;
 	/* only capture SPDIF over AK4113 */
-- 
2.35.3

