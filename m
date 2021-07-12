Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB22C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 09:37:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9B06102A
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 09:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9B06102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EC781680;
	Mon, 12 Jul 2021 11:36:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EC781680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626082663;
	bh=k5Sf7ZRdGrhKOqzaE3b4UKQ0uNbCuAfWmy7Y4N3PxI4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EhyVqNwRCQGnFY8b2aM7DTgnUP6HwRi2T34QKXQydExK5Av5Gm8qhhLbTv2rR+PME
	 7lSH1u+FtEjbOZb4CUyKR1TUIlwLRwUNDPwnNhQShcCPCWl7TVnSCCk62OvMYjfS4j
	 uOXpCb2P2rP7gHx/PCpsVH1HjgxVagTvUdTq1OQE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE53CF80254;
	Mon, 12 Jul 2021 11:36:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DF3CF8026D; Mon, 12 Jul 2021 11:36:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0CD8F8020C
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 11:36:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0CD8F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="tFR1IaHy"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="OPMD1Lce"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 178531FD5C
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626082603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CeUHwtALwJN3hMRr1XBfr584By95mbr7OePlsPWA6r0=;
 b=tFR1IaHyp7zuN87PNG5mCKR9Gl+1T0+B9ZoRCuBj0PsgRA/6DljexSYLQV1I6xz8opD+Eh
 ENVSlXpX3kixALhmO7QpSTzBFDte0+13kd3BE3Psq9QMA976u7j1iuLwCUD1EEmp/8iwTT
 j6wUZ9tHRjMfzCfPbxpeDkQ5k4eiDbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626082603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CeUHwtALwJN3hMRr1XBfr584By95mbr7OePlsPWA6r0=;
 b=OPMD1LcedSyxNlQcG5wapLs5MvavwEtczRPyLKTadkCGL0GOKRZtmI9B3+NGP7Cx623E6u
 OFncu1LwSloYboAg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 079E5A3B8A;
 Mon, 12 Jul 2021 09:36:43 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: intel8x0: Skip ac97 clock measurement on VM
Date: Mon, 12 Jul 2021 11:36:41 +0200
Message-Id: <20210712093641.29079-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

The intel8x0 driver tries to measure the AC97 bus clock at the probe
time because there have been machines that are driven in different
rate (44.1kHz vs 48kHz).  This was the past and currently most of
usages of this driver are on VM, and those are certainly fixed with
48k clock, hence it's useless and waste of time to measure.

This patch is an optimization, setting the fixed 48k rate if it's
detected to be running on a VM.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index df3ba5c70de9..6a436a2ce26a 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2656,6 +2656,8 @@ static void intel8x0_measure_ac97_clock(struct intel8x0 *chip)
 
 	if (chip->ac97_bus->clock != 48000)
 		return; /* specified in module option */
+	if (chip->inside_vm && !ac97_clock)
+		return; /* no measurement on VM */
 
       __again:
 	subs = chip->pcm[0]->streams[0].substream;
-- 
2.26.2

