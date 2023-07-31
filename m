Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA99C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 15:53:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F876FA;
	Mon, 31 Jul 2023 17:52:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F876FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690818820;
	bh=IU8CIZE5pRxmeDAsOAdbbXQvv61SEAHPubErmSDmsdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ABX76NqdW/E1SbYojv/yutg5i+aSOY8R18g4CrG0g8EKqG485i9RzZOsphHPy3PxK
	 EeIaWL3hbhhxbcG6NRhFLmG80yCd6XZEQNpLMuLGGdUOpqZ1P23zB8MYLL8FQLSQae
	 pAlAklZDJstnAhWpLzghs9gV83yCLI43ZPw1TnCs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 616DFF80637; Mon, 31 Jul 2023 17:48:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42E5EF80632;
	Mon, 31 Jul 2023 17:48:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3393F80619; Mon, 31 Jul 2023 17:48:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B1DBF801D5
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 17:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B1DBF801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=tmh1WpfP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qZNmjWmy
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEDEC1F74B;
	Mon, 31 Jul 2023 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1690818445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEU3jI2NBCX7jg1BGjyuJWHqJBgiYZncjTN0mq4N6ig=;
	b=tmh1WpfPg2MAKaGkCtpH1pZEt4meJGdJYAFangG6YefhEw9XP3YlhsfGG/RYqPFMsuM3Xi
	rUc69Adp7jZrg5Vn971PL4RdmGhY45zZ8UA0VLWIn/1XzNl+hSoFWEiALlbA90zj2OCVGe
	vQkSDglI8kMliYJQERvIP1xnjP7orP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690818445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEU3jI2NBCX7jg1BGjyuJWHqJBgiYZncjTN0mq4N6ig=;
	b=qZNmjWmyOmtvetPuZD0e2JuEw5z8mf2mZk/Df+IIH18Cd2NhCf7jG07Y+RrEcXXmCbc7cR
	x2M8BIDrsM5oO9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E151322C;
	Mon, 31 Jul 2023 15:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wBmwKo3Xx2Q3fwAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 31 Jul 2023 15:47:25 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/24] ALSA: pcmtest: Update comment about PCM copy ops
Date: Mon, 31 Jul 2023 17:47:09 +0200
Message-Id: <20230731154718.31048-16-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230731154718.31048-1-tiwai@suse.de>
References: <20230731154718.31048-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XTAYGY4ZWRUNTBOOVFHG4YILXZWFVW62
X-Message-ID-Hash: XTAYGY4ZWRUNTBOOVFHG4YILXZWFVW62
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XTAYGY4ZWRUNTBOOVFHG4YILXZWFVW62/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Just an update of a comment mentioning the old PCM callbacks to
correct to the new PCM copy ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/pcmtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 08e14b5eb772..e4dd65e5cd86 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -230,7 +230,7 @@ static void check_buf_block(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runti
 
 /*
  * Fill buffer in the non-interleaved mode. The order of samples is C0, ..., C0, C1, ..., C1, C2...
- * The channel buffers lay in the DMA buffer continuously (see default copy_user and copy_kernel
+ * The channel buffers lay in the DMA buffer continuously (see default copy
  * handlers in the pcm_lib.c file).
  *
  * Here we increment the DMA buffer position every time we write a byte to any channel 'buffer'.
-- 
2.35.3

