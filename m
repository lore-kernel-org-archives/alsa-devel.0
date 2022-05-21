Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8B1C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 21 May 2022 11:12:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8F3916F2;
	Sat, 21 May 2022 13:12:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8F3916F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653131572;
	bh=11BiF6EYX5nzO1yMu02l5yDY4w/nY+Cl+vjZ9UJPR+8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pOHGX3XbXbWtuqAdCdofkOc+DkcKgJRXn3/s6V/cm3kS+8A0YcIUA6bIyENJb18iv
	 FdepNAaES4aJDYMrkDy+lwZz3uLs6dxG6VS9saPLh/DAlCYejhdhfqn+g6Z+v+a9Ut
	 DKwMbjMZrCfyntTnKGlnCa2uwLkU3JSEd9iyJGIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79D16F8015B;
	Sat, 21 May 2022 13:12:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E445F8015B; Sat, 21 May 2022 13:12:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BBEFF800D2
 for <alsa-devel@alsa-project.org>; Sat, 21 May 2022 13:11:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BBEFF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr
 header.b="bd/cjqYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9rNZC50FyEC3dXd4iqi0InhhNWKvB2/su8ouG+co16E=;
 b=bd/cjqYiC7Bpgo62xWS12uKdKNP05etKAoBX4HEHrh6AbJxy6pt3L14+
 700iUlRgpcJiaXNjeM7VkG1xdAD1n5NpD8enQH1dFJ+YKiCW/TG24im4B
 wHzJdtqGZ3nJ+JcjrM+dU3IzEPeBlqGEIRTSWWBRz5OhDMttAdNPNDjT/ c=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; d="scan'208";a="14727885"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:52 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaya Kumar <jayakumar.alsa@gmail.com>
Subject: [PATCH] ALSA: cs5535audio: fix typo in comment
Date: Sat, 21 May 2022 13:10:11 +0200
Message-Id: <20220521111145.81697-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/cs5535audio/cs5535audio_pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 5ff10fec7b90..0db24cc4d916 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -129,7 +129,7 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 		return 0;
 
 	/* the u32 cast is okay because in snd*create we successfully told
-   	   pci alloc that we're only 32 bit capable so the uppper will be 0 */
+	   pci alloc that we're only 32 bit capable so the upper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
 	desc_addr = (u32) dma->desc_buf.addr;
 	for (i = 0; i < periods; i++) {

