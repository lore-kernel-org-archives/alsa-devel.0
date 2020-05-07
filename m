Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC19C38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:32:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A40A2083B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JdXEGskt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXTwoTpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A40A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 647F3180E;
	Thu,  7 May 2020 16:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 647F3180E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588861948;
	bh=HzhEusDHCLT13Z0JzCC9vjJXTgBi2bVzaanSrgUFSOg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JdXEGsktVvPnOFVkT6NhWr+xP1/s+pCqKsvyYJjEvAqr9jCZ6OXx9euBQ9ZUgM0mh
	 tDFhd8XZSWHSo12uLslQuWgemlaQqz1rzNfoENLWQEx5jAQACO3Zy1NhayspvtiHaM
	 SCiiaeoJf3FfhgcCcPSqwuWP+Z3tNmz6fPkYpcMU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61EC0F802C3;
	Thu,  7 May 2020 16:29:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E8E8F802C4; Thu,  7 May 2020 16:29:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5CAFF802C2
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 16:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5CAFF802C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hXTwoTpv"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60AC52083B;
 Thu,  7 May 2020 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588861750;
 bh=HzhEusDHCLT13Z0JzCC9vjJXTgBi2bVzaanSrgUFSOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hXTwoTpvE3qqrC6+jlCq8rKtnk72MT8vlal71+7iGfAiV/QXb0N5sN3sFqnHi2xdP
 3SxJOYBw5o5B0egJOn3O05jBsXKyTzZVCEuwTfAFf48aorJKoo7U38MwO0SlB0pmXn
 OooKboLvdLKYNGkgxFCVL+AZVzrYKQEi8Udk7h9A=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 31/35] ALSA: opti9xx: shut up gcc-10 range warning
Date: Thu,  7 May 2020 10:28:25 -0400
Message-Id: <20200507142830.26239-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 5ce00760a84848d008554c693ceb6286f4d9c509 ]

gcc-10 points out a few instances of suspicious integer arithmetic
leading to value truncation:

sound/isa/opti9xx/opti92x-ad1848.c: In function 'snd_opti9xx_configure':
sound/isa/opti9xx/opti92x-ad1848.c:322:43: error: overflow in conversion from 'int' to 'unsigned char' changes value from '(int)snd_opti9xx_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
  322 |   (snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
      |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/opti92x-ad1848.c:351:3: note: in expansion of macro 'snd_opti9xx_write_mask'
  351 |   snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
      |   ^~~~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/miro.c: In function 'snd_miro_configure':
sound/isa/opti9xx/miro.c:873:40: error: overflow in conversion from 'int' to 'unsigned char' changes value from '(int)snd_miro_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
  873 |   (snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
      |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/miro.c:1010:3: note: in expansion of macro 'snd_miro_write_mask'
 1010 |   snd_miro_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
      |   ^~~~~~~~~~~~~~~~~~~

These are all harmless here as only the low 8 bit are passed down
anyway. Change the macros to inline functions to make the code
more readable and also avoid the warning.

Strictly speaking those functions also need locking to make the
read/write pair atomic, but it seems unlikely that anyone would
still run into that issue.

Fixes: 1841f613fd2e ("[ALSA] Add snd-miro driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200429190216.85919-1-arnd@arndb.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/opti9xx/miro.c           | 9 ++++++---
 sound/isa/opti9xx/opti92x-ad1848.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 0458934de1c75..9ca5c83de8a7f 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -867,10 +867,13 @@ static void snd_miro_write(struct snd_miro *chip, unsigned char reg,
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
+static inline void snd_miro_write_mask(struct snd_miro *chip,
+		unsigned char reg, unsigned char value, unsigned char mask)
+{
+	unsigned char oldval = snd_miro_read(chip, reg);
 
-#define snd_miro_write_mask(chip, reg, value, mask)	\
-	snd_miro_write(chip, reg,			\
-		(snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
+	snd_miro_write(chip, reg, (oldval & ~mask) | (value & mask));
+}
 
 /*
  *  Proc Interface
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index fb36bb5d55df8..fb87eedc81210 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -317,10 +317,13 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 }
 
 
-#define snd_opti9xx_write_mask(chip, reg, value, mask)	\
-	snd_opti9xx_write(chip, reg,			\
-		(snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
+static inline void snd_opti9xx_write_mask(struct snd_opti9xx *chip,
+		unsigned char reg, unsigned char value, unsigned char mask)
+{
+	unsigned char oldval = snd_opti9xx_read(chip, reg);
 
+	snd_opti9xx_write(chip, reg, (oldval & ~mask) | (value & mask));
+}
 
 static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 					   long port,
-- 
2.20.1

