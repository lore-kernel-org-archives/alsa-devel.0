Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E54EB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 08:24:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C6E483E;
	Thu, 20 Jul 2023 10:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C6E483E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689841484;
	bh=KzzCJszpUd0J3SXbCewIsRuHijL8llFGLNfDm1O6n8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oeLHw8J3fA+K8FSeFaHP9LLWbwGjZz4n5DbSNuDsMA0HxasFj8JBP8vymCqerJ+SO
	 sgxMgbxMnt48S2i1N/is+1UzHrDO6lDtNdj99SYjbWV/I3lVUVd3B0vak/Ox/ksiM0
	 IRVa2XRsmxTnvqJBeKSdf1frlxIy7Z5lwqO6mfho=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5818F805ED; Thu, 20 Jul 2023 10:21:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C287F805E8;
	Thu, 20 Jul 2023 10:21:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A9DEF805BF; Thu, 20 Jul 2023 10:21:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5C4CF80570
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 10:21:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5C4CF80570
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=lOl2/qWS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=hCP5lEZO
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 034732059D;
	Thu, 20 Jul 2023 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1689841277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T3kG7ZHa/EgSbYDuam2xxh8RuXEIX5kvIC9Sx2D4oY=;
	b=lOl2/qWSlDVkqe3gpLwxfMYSPE18SfUFBaAwh+2sAVHbkcMil/RhTHzyLEksxZCly8QebQ
	/Nb7EH49ysv4XPJG/MVoKYRQ/N/ieIkdrNVf+suv0yRW3W4D+hBZ/Se8vTv9t6sqk9kE/t
	aBmyH2rBgqVutDEEfdxLV/Ue89jtbpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689841277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T3kG7ZHa/EgSbYDuam2xxh8RuXEIX5kvIC9Sx2D4oY=;
	b=hCP5lEZOqeyZxEINJO95VcAZNBqLlap5YOLoH13V7usXdZO0FN0BOxc4DJ1/bHlXuo+92U
	rvqto+nZaaIuR9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D86F6133DD;
	Thu, 20 Jul 2023 08:21:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yM1GMnzuuGQmIgAAMHmgww
	(envelope-from <tiwai@suse.de>); Thu, 20 Jul 2023 08:21:16 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/11] ALSA: via82xx: Simplify with snd_ctl_find_id_mixer()
Date: Thu, 20 Jul 2023 10:21:05 +0200
Message-Id: <20230720082108.31346-9-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720082108.31346-1-tiwai@suse.de>
References: <20230720082108.31346-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KQ2OBAM5WP73TO4ECLNGALPV4WWOSUYV
X-Message-ID-Hash: KQ2OBAM5WP73TO4ECLNGALPV4WWOSUYV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KQ2OBAM5WP73TO4ECLNGALPV4WWOSUYV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace an open code with the new snd_ctl_find_id_mixer().
There is no functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/via82xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 361b83fd721e..d8666ff7bdfa 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1984,11 +1984,7 @@ static int snd_via8233_init_misc(struct via82xx *chip)
 		/* when no h/w PCM volume control is found, use DXS volume control
 		 * as the PCM vol control
 		 */
-		struct snd_ctl_elem_id sid;
-		memset(&sid, 0, sizeof(sid));
-		strcpy(sid.name, "PCM Playback Volume");
-		sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		if (! snd_ctl_find_id(chip->card, &sid)) {
+		if (!snd_ctl_find_id_mixer(chip->card, "PCM Playback Volume")) {
 			dev_info(chip->card->dev,
 				 "Using DXS as PCM Playback\n");
 			err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_via8233_pcmdxs_volume_control, chip));
-- 
2.35.3

