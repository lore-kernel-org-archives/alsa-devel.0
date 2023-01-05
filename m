Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24871C3DA7D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 09:37:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED3AB410C;
	Thu,  5 Jan 2023 10:36:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED3AB410C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672911428;
	bh=3D7PKz0MARf/4bDFVUPn7yBdyUwtQ36LLztJN9pHhkk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=GFm+0oyw3FD2ETsDScF50DPOGqVwsXg0gAMKIeBTZFoK0LG6nIJvlG788gIQEOTr1
	 cj/qEXevni81d+T0EMXeRilMtBHllRump3pK5cW6sUq0rAari72niCzk1B6B5DgbdJ
	 6kyAQH4aKaxSEzyXbH1mJmeVYwo+WV0ae8rdO7KQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44D1EF804CB;
	Thu,  5 Jan 2023 10:35:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 815BCF804DB; Thu,  5 Jan 2023 10:35:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 349C4F8047B
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 10:35:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 349C4F8047B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Guytbdp+; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tUbo0qzt
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B81023896C;
 Thu,  5 Jan 2023 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1672911342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0mHr23OAKvdSSaIIy14El30UGauDN1gPPSUx4n79qng=;
 b=Guytbdp+EPA9dg3XzQUvxHSlvzwrmjYsJqVpvvXVwoXZxdtKwdBZscmCzCYGKQEKgKMw0k
 lFbnWMMXkZT/7SuyUO+WWGAdmLMfZebRMzTT8TAwUj0Va8tv5E3wJPtDOnwBTIksxop3+4
 OzqCrXfyelYavMVGZ2/8gNkxvOYadHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1672911342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0mHr23OAKvdSSaIIy14El30UGauDN1gPPSUx4n79qng=;
 b=tUbo0qztEPZMInKZYmgjdBK3cTFQphYHdnlWKoiRrTqvvYPW63DDbQ5deV+fj8gxzp8dDq
 HeGdJHOX0O4ussDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 962B613338;
 Thu,  5 Jan 2023 09:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uZzfI+6ZtmP1PAAAMHmgww
 (envelope-from <tiwai@suse.de>); Thu, 05 Jan 2023 09:35:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: hda: cs35l41: Don't return -EINVAL from system
 suspend/resume
Date: Thu,  5 Jan 2023 10:35:30 +0100
Message-Id: <20230105093531.16960-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The recent commit to support the system suspend for CS35L41 caused a
regression on the models with CS35L41_EXT_BOOST_NO_VSPK_SWITC boost
type, as the suspend/resume callbacks just return -EINVAL.  This is
eventually handled as a fatal error and blocks the whole system
suspend/resume.

For avoiding the problem, this patch corrects the return code from
cs35l41_system_suspend() and _resume() to 0, and replace dev_err()
with dev_err_once() for stop spamming too much.

Fixes: 88672826e2a4 ("ALSA: hda: cs35l41: Support System Suspend")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/4262e3c4-6169-bbd2-e918-16b06f6994bc@protonmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/cs35l41_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 91842c0c8c74..0a5cee730268 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -598,8 +598,8 @@ static int cs35l41_system_suspend(struct device *dev)
 	dev_dbg(cs35l41->dev, "System Suspend\n");
 
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
-		dev_err(cs35l41->dev, "System Suspend not supported\n");
-		return -EINVAL;
+		dev_err_once(cs35l41->dev, "System Suspend not supported\n");
+		return 0; /* don't block the whole system suspend */
 	}
 
 	ret = pm_runtime_force_suspend(dev);
@@ -624,8 +624,8 @@ static int cs35l41_system_resume(struct device *dev)
 	dev_dbg(cs35l41->dev, "System Resume\n");
 
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
-		dev_err(cs35l41->dev, "System Resume not supported\n");
-		return -EINVAL;
+		dev_err_once(cs35l41->dev, "System Resume not supported\n");
+		return 0; /* don't block the whole system resume */
 	}
 
 	if (cs35l41->reset_gpio) {
-- 
2.35.3

