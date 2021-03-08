Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D85C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:08:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC4C6522B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC4C6522B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05911897;
	Mon,  8 Mar 2021 17:07:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05911897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219712;
	bh=+ayh8DB6AjaU5LiEjo7XWkGZpwk8lbRyMmXrrzBRRqk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OZ87wMMsJEkmx78KPexDLmCdz1/A2yPhgYbMsYLvoSojhCN7y8nphrwWeDG/RaBaG
	 luyamZGp9s0/K0580TDuLNPKlEczWZyGkP100LoCGz6NWJ20NyLqxfqLeIf9yq19Tz
	 VYaYZxbHLOoZmd3/HnF+hoyaXIeUiNxKCwks89JE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC03F80139;
	Mon,  8 Mar 2021 17:07:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61E90F801D8; Mon,  8 Mar 2021 17:07:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3DD1F80139
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3DD1F80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C9B48AB8C
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 16:07:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Drop the BATCH workaround for AMD controllers
Date: Mon,  8 Mar 2021 17:07:26 +0100
Message-Id: <20210308160726.22930-1-tiwai@suse.de>
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

The commit c02f77d32d2c ("ALSA: hda - Workaround for crackled sound on
AMD controller (1022:1457)") introduced a few workarounds for the
recent AMD HD-audio controller, and one of them is the forced BATCH
PCM mode so that PulseAudio avoids the timer-based scheduling.  This
was thought to cover for some badly working applications, but this
actually worsens for more others.  In total, this wasn't a good idea
to enforce it.

This is a partial revert of the commit above for dropping the PCM
BATCH enforcement part to recover from the regression again.

Fixes: c02f77d32d2c ("ALSA: hda - Workaround for crackled sound on AMD controller (1022:1457)")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195303
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9087981cd1f7..ca2f2ecd1488 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -609,13 +609,6 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 				     20,
 				     178000000);
 
-	/* by some reason, the playback stream stalls on PulseAudio with
-	 * tsched=1 when a capture stream triggers.  Until we figure out the
-	 * real cause, disable tsched mode by telling the PCM info flag.
-	 */
-	if (chip->driver_caps & AZX_DCAPS_AMD_WORKAROUND)
-		runtime->hw.info |= SNDRV_PCM_INFO_BATCH;
-
 	if (chip->align_buffer_size)
 		/* constrain buffer sizes to be multiple of 128
 		   bytes. This is more efficient in terms of memory
-- 
2.26.2

