Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE266C33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:11:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3744520866
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IwrWxwEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3744520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AB7A17F3;
	Sun,  5 Jan 2020 16:10:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AB7A17F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578237077;
	bh=6YU8EZyUKbwOTTiZW0C4PhvW6Y4uj9hpPr/BqEROwGs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IwrWxwEIBOmW4ohxpltA7vJwbdJRJOUxLzwyfD+eljS/pEL81ueAKy64hj9CEBOlv
	 wreVJUPRegqNyEjZHt/wT2JVJIWoUScRgwwnaV3TdIaoP9hMuQgZJaLMMHzRi5nbhw
	 37eEzCAUIGeBZZbGYsEOQrK+gOc/KeLGbcXOKAe8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BE4EF8042B;
	Sun,  5 Jan 2020 15:50:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C941EF8036F; Sun,  5 Jan 2020 15:49:23 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7260F8029A
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7260F8029A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 467F4B29F
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:33 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:48 +0100
Message-Id: <20200105144823.29547-34-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 33/68] ALSA: atiixp: More constifications
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

Apply const prefix to the static register tables.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/atiixp.c       | 2 +-
 sound/pci/atiixp_modem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 4a840734e7a7..85d3b4e95489 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1407,7 +1407,7 @@ static int snd_atiixp_mixer_new(struct atiixp *chip, int clock,
 		.write = snd_atiixp_ac97_write,
 		.read = snd_atiixp_ac97_read,
 	};
-	static unsigned int codec_skip[NUM_ATI_CODECS] = {
+	static const unsigned int codec_skip[NUM_ATI_CODECS] = {
 		ATI_REG_ISR_CODEC0_NOT_READY,
 		ATI_REG_ISR_CODEC1_NOT_READY,
 		ATI_REG_ISR_CODEC2_NOT_READY,
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 3ec34e78ffef..ae88217d685a 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1050,7 +1050,7 @@ static int snd_atiixp_mixer_new(struct atiixp_modem *chip, int clock)
 		.write = snd_atiixp_ac97_write,
 		.read = snd_atiixp_ac97_read,
 	};
-	static unsigned int codec_skip[NUM_ATI_CODECS] = {
+	static const unsigned int codec_skip[NUM_ATI_CODECS] = {
 		ATI_REG_ISR_CODEC0_NOT_READY,
 		ATI_REG_ISR_CODEC1_NOT_READY,
 		ATI_REG_ISR_CODEC2_NOT_READY,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
