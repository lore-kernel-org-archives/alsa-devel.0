Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3AC433E5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:31:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914EB2074A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RERHn+ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914EB2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F84E167B;
	Tue, 14 Jul 2020 19:30:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F84E167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594747863;
	bh=D0REilJIvYkv8uMwpViLKngqbCsMDGY10ukiMq+BdGE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RERHn+adUPJfhI8nTQCjMv2qXcngpnyUKRINDxdsoEQiEYIgtKBO6aE7DfLgC1gNW
	 TuxmT+/BjX82Y7XlRcxKmsuyNvQV1wO+3m2KGLJoBTT/HyPFtIfOJi8taBWG/+xSZM
	 bCSjKGxR/0vm1QckiyVUvdbFf1D8s02vFap1J/lM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72522F802EA;
	Tue, 14 Jul 2020 19:27:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C2D2F802E1; Tue, 14 Jul 2020 19:26:54 +0200 (CEST)
Received: from mx2.suse.de (unknown [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 172C1F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 19:26:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 172C1F800E5
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 59FF0AD73
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:26:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/10] ALSA: intel8x0: Replace the words white/blacklist
Date: Tue, 14 Jul 2020 19:26:28 +0200
Message-Id: <20200714172631.25371-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200714172631.25371-1-tiwai@suse.de>
References: <20200714172631.25371-1-tiwai@suse.de>
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

Follow the recent inclusive terminology guidelines and replace the
words "whitelist" and "blacklist" appropriately.

Correcting only comments, or error/module messages, no functional
changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 675bb0da00a0..3349e455a871 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(index, "Index value for Intel i8x0 soundcard.");
 module_param(id, charp, 0444);
 MODULE_PARM_DESC(id, "ID string for Intel i8x0 soundcard.");
 module_param(ac97_clock, int, 0444);
-MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (0 = whitelist + auto-detect, 1 = force autodetect).");
+MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (0 = allowlist + auto-detect, 1 = force autodetect).");
 module_param(ac97_quirk, charp, 0444);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 module_param(buggy_semaphore, bool, 0444);
@@ -2792,7 +2792,7 @@ static int intel8x0_in_clock_list(struct intel8x0 *chip)
 	wl = snd_pci_quirk_lookup(pci, intel8x0_clock_list);
 	if (!wl)
 		return 0;
-	dev_info(chip->card->dev, "white list rate for %04x:%04x is %i\n",
+	dev_info(chip->card->dev, "allow list rate for %04x:%04x is %i\n",
 	       pci->subsystem_vendor, pci->subsystem_device, wl->value);
 	chip->ac97_bus->clock = wl->value;
 	return 1;
@@ -3138,7 +3138,7 @@ static const struct snd_pci_quirk spdif_aclink_defaults[] = {
 	{ } /* end */
 };
 
-/* look up white/black list for SPDIF over ac-link */
+/* look up allow/deny list for SPDIF over ac-link */
 static int check_default_spdif_aclink(struct pci_dev *pci)
 {
 	const struct snd_pci_quirk *w;
-- 
2.16.4

