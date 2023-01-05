Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50AEC3DA7D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 09:36:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E774710313;
	Thu,  5 Jan 2023 10:35:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E774710313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672911399;
	bh=3TbP29SuAkMAilIX5+1ay5ptYeUDXnKCHdBr6ymJRk4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Kqp5pG6b8GrcBSlq0ftibr44vh0XOl0ZaZaglQUs60vmVKjVpNjVXYDUWnxhVPtD9
	 6N6iYSvJldRNiTMLhyjWxTiN24ruzXg5GQjjgwC8zFaL9OU6X/d801YEKeqv1QpOxj
	 EeiO1VYAxOOZsRi8aWFoFLAOouj1ARoLN/x6iXHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A433FF804AA;
	Thu,  5 Jan 2023 10:35:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71092F804AE; Thu,  5 Jan 2023 10:35:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD11EF8022B
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 10:35:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD11EF8022B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=bHM8rGAm; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7oi62YR/
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD1C521978;
 Thu,  5 Jan 2023 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1672911342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zrWPY1q5KSTcaxxDfKjPUlU/W7/R328tSpJ/ayUPag=;
 b=bHM8rGAmu2Z04oVQpfV7eb1meZCBezkS2AB+vACxIKHEzTFTWXo4htCP0CAEm0iEa/cKfC
 Yw0DRrjdqA/158lv+FLNIBToAt5YQjSyJKxKZ4iXeAD3bg7u8IPl/1zizyZ32KY2/NmtU7
 BDPBGIkAYI4Tq5HfgxPgOgLTA22lTBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1672911342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zrWPY1q5KSTcaxxDfKjPUlU/W7/R328tSpJ/ayUPag=;
 b=7oi62YR/2V/6lmSio4YBg0bpiJlYUm/3mXh9lA+Dzhv/9nD/tBuyd9dOT7IC255b9/6Vcc
 gnKzh/MQlw2e4WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB3191348B;
 Thu,  5 Jan 2023 09:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mA8ILe6ZtmP1PAAAMHmgww
 (envelope-from <tiwai@suse.de>); Thu, 05 Jan 2023 09:35:42 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: hda: cs35l41: Check runtime suspend capability at
 runtime_idle
Date: Thu,  5 Jan 2023 10:35:31 +0100
Message-Id: <20230105093531.16960-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230105093531.16960-1-tiwai@suse.de>
References: <20230105093531.16960-1-tiwai@suse.de>
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

The runtime PM core checks with runtime_idle callback whether it can
goes to the runtime suspend or not, and we can put the boost type
check there instead of runtime_suspend and _resume calls.  This will
reduce the unnecessary runtime_suspend() calls.

Fixes: 1873ebd30cc8 ("ALSA: hda: cs35l41: Support Hibernation during Suspend")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/cs35l41_hda.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 0a5cee730268..f7815ee24f83 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -647,6 +647,15 @@ static int cs35l41_system_resume(struct device *dev)
 	return ret;
 }
 
+static int cs35l41_runtime_idle(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
+		return -EBUSY; /* suspend not supported yet on this model */
+	return 0;
+}
+
 static int cs35l41_runtime_suspend(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -1536,7 +1545,8 @@ void cs35l41_hda_remove(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 const struct dev_pm_ops cs35l41_hda_pm_ops = {
-	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume,
+		       cs35l41_runtime_idle)
 	SYSTEM_SLEEP_PM_OPS(cs35l41_system_suspend, cs35l41_system_resume)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
-- 
2.35.3

