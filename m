Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A2C432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:12:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FEA21783
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UGOHemyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FEA21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sonarnerd.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C44B16A9;
	Tue, 24 Sep 2019 09:12:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C44B16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569309171;
	bh=dvNYEv6hIScOOHIQ+R6RQH2fjnX+6ZTYg3fyl3g4X+Q=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UGOHemyocNK0bpJo+sZQ2bxcExNJ9AYnjBcaQ8S3OqvLlx2Or1SjpO5HyOwmiFZ2/
	 384eqk41jR/9y8rOXpAZ5dArgE/HPjPdD6uvKz89SOLFWbj+Es18hZYwLcAKR6pBWz
	 ES1sRXkCmnNw+A1ypczYFhxny2uVIJn7ur8vHhzs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CAEFF80213;
	Tue, 24 Sep 2019 09:12:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FD8FF8045F; Tue, 24 Sep 2019 09:11:59 +0200 (CEST)
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D62FAF802BD
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 09:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D62FAF802BD
Received: from porkkala.uworld (porkkala.uworld [IPv6:fc00::2])
 by mail.sonarnerd.net (Postfix) with ESMTP id B7D4C2311F0;
 Tue, 24 Sep 2019 10:11:54 +0300 (EEST)
From: Jussi Laako <jussi@sonarnerd.net>
To: alsa-devel@alsa-project.org
Date: Tue, 24 Sep 2019 10:11:43 +0300
Message-Id: <20190924071143.30911-1-jussi@sonarnerd.net>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, Jussi Laako <jussi@sonarnerd.net>
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Add DSD support for EVGA NU
	Audio
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

EVGA NU Audio is actually a USB audio device on a PCIexpress card,
with it's own USB controller. It supports both PCM and DSD.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5fd4ccce452d..fbfde996fee7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1658,6 +1658,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x25ce:  /* Mytek devices */
 	case 0x278b:  /* Rotel? */
 	case 0x2ab6:  /* T+A devices */
+	case 0x3842:  /* EVGA */
 	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
