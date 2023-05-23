Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D8C7EE23
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 08:05:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43C5DEA9;
	Tue, 23 May 2023 10:04:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43C5DEA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684829100;
	bh=ZdlTPH9tx9kHqQ9wgVUvTHqhV3bd9Irh3kp04UL0Xhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mBIzKhHjO796/1egNs7WCbqOrscAv4SKobeLm1SLMSoIdNnmT8JQqJ4Y9n88YjcX8
	 qZmiJUnXhkA5u5Yu1lJE73dJ1hkxq5H0XJ3MEhJe2p+teXWFWGmv4Lxurhn9gMT8aM
	 fy58mp8Eq1ejgBP9+eE9oiW8N4NAhUOuvJRFJacM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F692F80551; Tue, 23 May 2023 09:56:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 476CFF805C9;
	Tue, 23 May 2023 09:56:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 505A3F805C9; Tue, 23 May 2023 09:56:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27F60F80249
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 09:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27F60F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=PKJPHpLd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kz87lPoH
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A06A227A4;
	Tue, 23 May 2023 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1684828442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b27Ref8ImoJXjyPyFCsfRMw/pwLg1dpXQ6Knv5YaWzU=;
	b=PKJPHpLdfovv6Ped0GtzgzELQxM8mRsu3WqXvCdt8I/E58Qazm1Pm91iqalS7QJIcBIjA4
	I8mBnrm5/Vap0GtQFpj/lPlHM7X7qapDnWXhaKPFsA1kkxI0UuUn7KEf2q/9OmmYEsbSLE
	pktb1FHx9n7uhQysQbSOLiqAzuTgXdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684828442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b27Ref8ImoJXjyPyFCsfRMw/pwLg1dpXQ6Knv5YaWzU=;
	b=kz87lPoH4W2qwxgW5jaiQZ2noEOiUjbPXXNkot90FuBslb4W5kc6Q44UUk9yUm7j40oHE0
	HcOTRm88wckEGRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E34413588;
	Tue, 23 May 2023 07:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sL4kEhpxbGT4KgAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:02 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/37] ALSA: rawmidi: Add ioctl callback to
 snd_rawmidi_global_ops
Date: Tue, 23 May 2023 09:53:23 +0200
Message-Id: <20230523075358.9672-3-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NVXBGVI5362BAZE3LWR47KXG2H2NF4E5
X-Message-ID-Hash: NVXBGVI5362BAZE3LWR47KXG2H2NF4E5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NVXBGVI5362BAZE3LWR47KXG2H2NF4E5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A new callback, ioctl, is added to snd_rawmidi_global_ops for allowing
the driver to deal with the own ioctls.  This is another preparation
patch for the upcoming UMP support.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h | 2 ++
 sound/core/rawmidi.c    | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 52b1cbfb2526..84413cfcdcb5 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -47,6 +47,8 @@ struct snd_rawmidi_global_ops {
 	int (*dev_unregister) (struct snd_rawmidi * rmidi);
 	void (*get_port_info)(struct snd_rawmidi *rmidi, int number,
 			      struct snd_seq_port_info *info);
+	long (*ioctl)(struct snd_rawmidi *rmidi, unsigned int cmd,
+		      void __user *argp);
 };
 
 struct snd_rawmidi_runtime {
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 589b75087d27..ab28cfc1fac8 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -893,6 +893,7 @@ static int snd_rawmidi_ioctl_status64(struct snd_rawmidi_file *rfile,
 static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_rawmidi_file *rfile;
+	struct snd_rawmidi *rmidi;
 	void __user *argp = (void __user *)arg;
 
 	rfile = file->private_data;
@@ -984,8 +985,10 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 		}
 	}
 	default:
-		rmidi_dbg(rfile->rmidi,
-			  "rawmidi: unknown command = 0x%x\n", cmd);
+		rmidi = rfile->rmidi;
+		if (rmidi->ops && rmidi->ops->ioctl)
+			return rmidi->ops->ioctl(rmidi, cmd, argp);
+		rmidi_dbg(rmidi, "rawmidi: unknown command = 0x%x\n", cmd);
 	}
 	return -ENOTTY;
 }
-- 
2.35.3

