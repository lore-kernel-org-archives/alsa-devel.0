Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9623C00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 16:58:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA7ED84B;
	Mon,  1 Aug 2022 18:57:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA7ED84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659373117;
	bh=Pj4jAb7sL0SqF6uyJQgVC/vuxgkcpTxLNPFNd7687wk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mDe9seW/zF1UUrg5tJn56EwuN24yBPA3Nx26ATMC6uhFrtXdxmWLuwTqrLbjCLcM7
	 61cwDpJAeUSUVcC/JU5Z9GsfHXjrukRLMGOPuMuROvugDOELKXQP/+oKl8p3vzkTmY
	 im2Q87g/o0ugksxw1h+hLwoOj/q2Cnk8Dmb9K2A8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD716F80558;
	Mon,  1 Aug 2022 18:57:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEDBCF80552; Mon,  1 Aug 2022 18:56:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1903F8023B
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 18:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1903F8023B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="JBJOtxep"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="GdBUxXTC"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F25C4D854;
 Mon,  1 Aug 2022 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659373003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ww5jnaPCduGtXwHHgUSwExhF9QL4PYRD+iwmJrblojM=;
 b=JBJOtxepuX7NKXu7mJURUUq8hB+BuIC4+y2K9duvTa5LxlWsvpPZmo7DrtAU3ds7hHfAH8
 MHpuFCdeEHGFv2V0NWOTaaCa884mgDPkoFSBqw+QdCYhVima5yCqaQo0edJGi9XJOa/Y5C
 NJ5hjG0jQQFkVrLuSZhtqkIF8P/lJh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659373003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ww5jnaPCduGtXwHHgUSwExhF9QL4PYRD+iwmJrblojM=;
 b=GdBUxXTCPaTmE3xioirIy3yhxEeTHb9SU6PI2m4G1dL88tiGfEx0Yqs/lLurKVXAZAoxIn
 q0OsGqkkTgnGGHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 436AB13ADF;
 Mon,  1 Aug 2022 16:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qK+TD8sF6GLXGgAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 01 Aug 2022 16:56:43 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ALSA: pcm: Replace sprintf() with sysfs_emit()
Date: Mon,  1 Aug 2022 18:56:37 +0200
Message-Id: <20220801165639.26030-6-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801165639.26030-1-tiwai@suse.de>
References: <20220801165639.26030-1-tiwai@suse.de>
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

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co.  This patch replaces such a
sprintf() call straightforwardly with the new helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 2ac742035310..82925709fa12 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1031,7 +1031,7 @@ static ssize_t pcm_class_show(struct device *dev,
 		str = "none";
 	else
 		str = strs[pcm->dev_class];
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static DEVICE_ATTR_RO(pcm_class);
-- 
2.35.3

