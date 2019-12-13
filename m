Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA8C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:54:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFB4206C3
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LQOytVC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFB4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 345A61766;
	Fri, 13 Dec 2019 09:53:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 345A61766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576227279;
	bh=U0I5YSuHf8j8hY1QP4Fk5iyloTmYCPwalBkXVSOYIe0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQOytVC0Dz48pdLsUmwF+R9dB/E7omDmQcwmsu2R4DMVmFpRxWNWPJkA5LPk76Xxu
	 MJ9UXo1qHkhXhAtGY16faxf1eN4DvkaB8Ro/UQCZT35yjPebiwbn2+ITIuO0Fp0T7i
	 sM1xy3695XZOfhmoYYfP1bR6od3NKit0t4tg3t4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAE76F80268;
	Fri, 13 Dec 2019 09:51:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEE85F80258; Fri, 13 Dec 2019 09:51:21 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA063F8021D
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 09:51:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA063F8021D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 55D3EAE99
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 08:51:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 13 Dec 2019 09:51:10 +0100
Message-Id: <20191213085111.22855-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213085111.22855-1-tiwai@suse.de>
References: <20191213085111.22855-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/3] ALSA: hda/ca0132 - Avoid endless loop
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

Introduce a timeout to dspio_clear_response_queue() so that it won't
be caught in an endless loop even if the hardware doesn't respond
properly.

Fixes: a73d511c4867 ("ALSA: hda/ca0132: Add unsol handler for DSP and jack detection")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c3d34ff3d9ec..8d0209fff8f5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1809,13 +1809,14 @@ struct scp_msg {
 
 static void dspio_clear_response_queue(struct hda_codec *codec)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned int dummy = 0;
-	int status = -1;
+	int status;
 
 	/* clear all from the response queue */
 	do {
 		status = dspio_read(codec, &dummy);
-	} while (status == 0);
+	} while (status == 0 && time_before(jiffies, timeout));
 }
 
 static int dspio_get_response_data(struct hda_codec *codec)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
