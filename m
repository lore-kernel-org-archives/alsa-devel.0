Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF7CC77B75
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 08:04:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5A4F86E;
	Tue, 23 May 2023 10:03:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5A4F86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684829054;
	bh=2S5bfPVDlHq2XWH5E9lmadAP9vsgL5Zpzg3k5L+MxQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I9U2YTOlSyt1mi1HkMjQY+1SOjIMplSY9C0Fb063KJRlWXUIyuMxeovNR38a9fhB2
	 2XSM4o7sIwFAYxB09FTVlTWNcaz6FgwgmP1+J6n8rd0hE6ie5fw8XiQvn5+rQa/jmw
	 DwgR4pb2iiVJzL6ag5MNa7ivnynIl1VUYhJoyTM4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BD5FF805E6; Tue, 23 May 2023 09:56:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EE7DF805E4;
	Tue, 23 May 2023 09:56:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C068F806C3; Tue, 23 May 2023 09:55:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D230FF80588
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 09:54:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D230FF80588
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=oNNRfBQT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=J2iFqDWu
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E51532041B;
	Tue, 23 May 2023 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1684828452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHQrHilsIqjDo5H9WbGUCwqE2MfITTbQXGoxi+ShiBk=;
	b=oNNRfBQT3taA3ZwcuPQW/0mjshFULGlgmhc6kUnxcP8nnH5tPXrF/DB4aNRMlcOifEu9S1
	7G3q00cEOGbbQHw9nLRq5ojJZG+q3Ye31sSq/++yc1uJ5ZuBO+T6tw2qQy3i4aCeYF15Xu
	//7rUUx0bJyePpwtbxVdUE5X7CltAWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684828452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHQrHilsIqjDo5H9WbGUCwqE2MfITTbQXGoxi+ShiBk=;
	b=J2iFqDWuHzBL+wLK3QYiN/SFbj/S1l1zrT7vBaa0QmuU+J8kKwPwdBGsqrixTAy+cv+AyK
	5fzyDyRPTjodJEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 965A513588;
	Tue, 23 May 2023 07:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WCEtIiRxbGT4KgAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:12 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/37] ALSA: seq: Print UMP Endpoint and Block information
 in proc outputs
Date: Tue, 23 May 2023 09:53:56 +0200
Message-Id: <20230523075358.9672-36-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OQOFKEFUL7MMGJAZH2QQHPT32PKNTUFO
X-Message-ID-Hash: OQOFKEFUL7MMGJAZH2QQHPT32PKNTUFO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OQOFKEFUL7MMGJAZH2QQHPT32PKNTUFO/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch enhances the /proc/asound/seq/clients output to show a few
more information about the assigned UMP Endpoint and Blocks.

The "Groups" are shown in 1-based group number to align with the
sequencer client name and port number.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 03ca78ea2cce..8cce8061ca55 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2120,6 +2120,33 @@ static void terminate_ump_info_strings(void *p, int type)
 	}
 }
 
+#ifdef CONFIG_SND_PROC_FS
+static void dump_ump_info(struct snd_info_buffer *buffer,
+			  struct snd_seq_client *client)
+{
+	struct snd_ump_endpoint_info *ep;
+	struct snd_ump_block_info *bp;
+	int i;
+
+	if (!client->ump_info)
+		return;
+	ep = client->ump_info[SNDRV_SEQ_CLIENT_UMP_INFO_ENDPOINT];
+	if (ep && *ep->name)
+		snd_iprintf(buffer, "  UMP Endpoint: \"%s\"\n", ep->name);
+	for (i = 0; i < SNDRV_UMP_MAX_BLOCKS; i++) {
+		bp = client->ump_info[i + 1];
+		if (bp && *bp->name) {
+			snd_iprintf(buffer, "  UMP Block %d: \"%s\" [%s]\n",
+				    i, bp->name,
+				    bp->active ? "Active" : "Inactive");
+			snd_iprintf(buffer, "    Groups: %d-%d\n",
+				    bp->first_group + 1,
+				    bp->first_group + bp->num_groups);
+		}
+	}
+}
+#endif
+
 /* UMP-specific ioctls -- called directly without data copy */
 static int snd_seq_ioctl_client_ump_info(struct snd_seq_client *caller,
 					 unsigned int cmd,
@@ -2654,6 +2681,9 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 			    c, client->name,
 			    client->type == USER_CLIENT ? "User" : "Kernel",
 			    midi_version_string(client->midi_version));
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+		dump_ump_info(buffer, client);
+#endif
 		snd_seq_info_dump_ports(buffer, client);
 		if (snd_seq_write_pool_allocated(client)) {
 			snd_iprintf(buffer, "  Output pool :\n");
-- 
2.35.3

