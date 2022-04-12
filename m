Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2FCC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:33:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA3631922;
	Tue, 12 Apr 2022 12:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA3631922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759636;
	bh=Qa/stgT6Rvqzn/qLGGOJQloHlOSYARVkd3WdYsdlREM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UE5XnmHlLhJOY54WGjpkGq3UEYVQMUx7HvPeJan71z4Oecz6WnExuFyZhVXJbVzu8
	 WKbwtjCLReq8ijlpzcyoXZx/ZEvOPK86+jN55FO8FaMl/w1WmppypQMXIQQxG4xTGl
	 hD5Du1j+W2QbrnU731xar2qkS8fnqqe8Oid8Lwz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4962EF805DA;
	Tue, 12 Apr 2022 12:27:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9598F805C0; Tue, 12 Apr 2022 12:27:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 035A0F8052F
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 035A0F8052F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="hgYYT0rz"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="JJEXpc0C"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DC8912160E
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eMCnfUdgueNSa57I2JE7RHOdfmQkgMpe7AWbASFrbA=;
 b=hgYYT0rzUjWCvh9bG6IKkZwf24SL2XUwOSoaYTrGLWJx7rlB7Hup2U0U18kIiCOy855X8A
 9kZRJxLC4XY7W3nf7AbbkKLb15XWvNdyH4QOEMD2b0ZPkhIp1pxaQFk8acmxEWykq5lXNP
 EibV9ZyeuvA4RZI8eRTMA/BzwqdhIFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eMCnfUdgueNSa57I2JE7RHOdfmQkgMpe7AWbASFrbA=;
 b=JJEXpc0CTYS4doah+JN1jHhZoqKVebWTfnBV37T1LBIXrrkCk6q57+UavAv0XgR4vHkVIH
 S9/xGu3XTZF2YiCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id CC3CCA3B83;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 32/39] ALSA: cmipci: Fix the missing snd_card_free() call at
 probe error
Date: Tue, 12 Apr 2022 12:26:29 +0200
Message-Id: <20220412102636.16000-33-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412102636.16000-1-tiwai@suse.de>
References: <20220412102636.16000-1-tiwai@suse.de>
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

The previous cleanup with devres may lead to the incorrect release
orders at the probe error handling due to the devres's nature.  Until
we register the card, snd_card_free() has to be called at first for
releasing the stuff properly when the driver tries to manage and
release the stuff via card->private_free().

This patch fixes it by calling snd_card_free() manually on the error
from the probe callback.

Fixes: 87e082ad84a7 ("ALSA: cmipci: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cmipci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index dab801d9d3b4..727db6d43391 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3247,15 +3247,19 @@ static int snd_cmipci_probe(struct pci_dev *pci,
 
 	err = snd_cmipci_create(card, pci, dev);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_card_register(card);
 	if (err < 0)
-		return err;
+		goto error;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+ error:
+	snd_card_free(card);
+	return err;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.31.1

