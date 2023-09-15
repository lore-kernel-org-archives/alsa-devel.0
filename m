Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7226EE643D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 08:31:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F7EFA4B;
	Fri, 15 Sep 2023 10:30:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F7EFA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694766690;
	bh=Lt/hIy/1tnu3UPTOgfh3v9R0/TEDD+hbx/g9M0mibrc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KgMJQBlkO5wuEmNbeqdXYP+b4YFMaSB51K/0mUuyax+lXAVyYGZBrAsND5rw0LTEW
	 r7cza7lLlNC3RutxNZyXzlE3aIpGMw7M9verdehENYjoXbe+B10Et2gQH3CsGB8eo9
	 yuJkqbw7XKgB58V61Re0gIiQBuRP3kxwTeY6bvzU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 541A8F805C9; Fri, 15 Sep 2023 10:28:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC80F805C9;
	Fri, 15 Sep 2023 10:28:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 748BDF805A1; Fri, 15 Sep 2023 10:28:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75B19F80425
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 10:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75B19F80425
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=wrYCC/5O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=seNJdhC8
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91B2021865;
	Fri, 15 Sep 2023 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1694766486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhWztegqhaXp02JZC3Qx9Fou0nC7eYXPCB+PqPMTJl8=;
	b=wrYCC/5ONlPvYoo+Tln/e/0U59hGN6eO7lkyyq0WpXxmaLxMiTRPHmrvsCMdY98hdCn/Ax
	V4riEkaSlk0fFqwSMRJ7PcEY/Uz1H3yxEkuGxXDe6qVs3bVmdFZBOBhkCER7xtg8YJaiY6
	atno4CoMmAz+38cwfq1xXVi9Bvx46FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694766486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhWztegqhaXp02JZC3Qx9Fou0nC7eYXPCB+PqPMTJl8=;
	b=seNJdhC8LErKVn/T8vjOkN4Gc4keF96PjgUooHpCqfid31CEhXPvrJVVjyByeCEmXimxTv
	p+xiNDLcCXhpu8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7522313A34;
	Fri, 15 Sep 2023 08:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WBVZG5YVBGVfQQAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 15 Sep 2023 08:28:06 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/13] ALSA: seq: ump: Fix -Wformat-truncation warning
Date: Fri, 15 Sep 2023 10:27:50 +0200
Message-Id: <20230915082802.28684-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230915082802.28684-1-tiwai@suse.de>
References: <20230915082802.28684-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7FF6HENH37ZBPKJLZH4JT5PENU2AMWQ6
X-Message-ID-Hash: 7FF6HENH37ZBPKJLZH4JT5PENU2AMWQ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7FF6HENH37ZBPKJLZH4JT5PENU2AMWQ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The filling of a port name string got a warning with W=1 due to the
potentially too long group name.  Add the string precision to limit
the size.

Fixes: 81fd444aa371 ("ALSA: seq: Bind UMP device")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_ump_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index a60e3f069a80..2db371d79930 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -207,7 +207,7 @@ static void fill_port_info(struct snd_seq_port_info *port,
 		SNDRV_SEQ_PORT_TYPE_PORT;
 	port->midi_channels = 16;
 	if (*group->name)
-		snprintf(port->name, sizeof(port->name), "Group %d (%s)",
+		snprintf(port->name, sizeof(port->name), "Group %d (%.53s)",
 			 group->group + 1, group->name);
 	else
 		sprintf(port->name, "Group %d", group->group + 1);
-- 
2.35.3

