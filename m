Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60776C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:29:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D3381891;
	Tue, 12 Apr 2022 12:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D3381891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759341;
	bh=rc4VmqojTlJmhR89oDeZeHx8yoQIetzkdvs00qlQP5o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=objl21BH+gdDFT8RVDvvZxU/aIMxepktObA9Q8QuKlPJz5oPEBX9nLbWevYttkwTg
	 rmcEfVB4+fclPsDUqsEN1vKg88J82QUTVF6sM+pk5FrQWDr6ZJlAC26GbjFKWNRD+J
	 wxjZu1TlJpQJmL0Vj91h4cMwa5VlvlZ1usph02lQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C6D4F80559;
	Tue, 12 Apr 2022 12:27:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6C87F804F3; Tue, 12 Apr 2022 12:26:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 917D2F804F3
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 917D2F804F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="JgdyXBxB"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Llz3GR59"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 442EF21608
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAvtL9CBQW3+bQ9fjuR2abgmkho6eVZM7HE0qmDRjgY=;
 b=JgdyXBxBwtLv4yT420UuS5Xr9wEwMJbdxzsqXQih7jkGHRV44EjPmeDHK2/o5IlTiHc1hQ
 9IKXkzhrSWVO6b0CMo6gIQNExFMopHWA5a3gcHKZQstXvSj4r5O24EtRuGMOhk2u2vgpgE
 jADHTDJnt8lfXge544qBToqR4FKgB18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAvtL9CBQW3+bQ9fjuR2abgmkho6eVZM7HE0qmDRjgY=;
 b=Llz3GR596qm3jje4DAVFIFn2QVi74+MPzU0wmqUwyWqi97aSGJAU5trUtPCiy8keEcAqA5
 gv8tKxuq90mX1vAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 3F5BEA3B87;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/39] ALSA: sc6000: Fix the missing snd_card_free() call at
 probe error
Date: Tue, 12 Apr 2022 12:25:59 +0200
Message-Id: <20220412102636.16000-3-tiwai@suse.de>
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

This patch fixes it by calling snd_card_free() on the error from the
probe callback using a new helper function.

Fixes: 111601ff76e9 ("ALSA: sc6000: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sc6000.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 26ab7ff80768..60398fced046 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -537,7 +537,7 @@ static void snd_sc6000_free(struct snd_card *card)
 		sc6000_setup_board(vport, 0);
 }
 
-static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
+static int __snd_sc6000_probe(struct device *devptr, unsigned int dev)
 {
 	static const int possible_irqs[] = { 5, 7, 9, 10, 11, -1 };
 	static const int possible_dmas[] = { 1, 3, 0, -1 };
@@ -662,6 +662,11 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	return 0;
 }
 
+static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
+{
+	return snd_card_free_on_error(devptr, __snd_sc6000_probe(devptr, dev));
+}
+
 static struct isa_driver snd_sc6000_driver = {
 	.match		= snd_sc6000_match,
 	.probe		= snd_sc6000_probe,
-- 
2.31.1

