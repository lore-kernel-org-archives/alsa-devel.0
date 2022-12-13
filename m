Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E368CC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Dec 2022 06:15:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6C7F1895;
	Tue, 13 Dec 2022 07:14:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6C7F1895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670912136;
	bh=xwbIFBYNiz3NoyEolEoXbgUGYgC/+/WZpVvbjgaZ+gU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=uj/oUxRlnGEjocSKWtk0tlVkhk25dld8S6S/RWBZEmauxIGH9xMfoa3jdCqVYfm8r
	 4ATQCxCLmTQov4fi3Aay1/+K7ToetRYNqvdEsWU54u/hqycxLHnD6/OucD57ilLAyW
	 GF7U/qz4aX65ZtWW8mJaOrz0zRrCYSfkNl+OqEy8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79D03F8047D;
	Tue, 13 Dec 2022 07:14:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06510F804D6; Tue, 13 Dec 2022 07:14:44 +0100 (CET)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87ED6F80141
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2022 07:14:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87ED6F80141
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=jiapeng.chong@linux.alibaba.com; NM=0; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VXCbbTo_1670912063; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VXCbbTo_1670912063) by smtp.aliyun-inc.com;
 Tue, 13 Dec 2022 14:14:36 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: perex@perex.cz
Subject: [PATCH] ALSA: azt3328: Remove the unused function
 snd_azf3328_codec_outl()
Date: Tue, 13 Dec 2022 14:13:55 +0800
Message-Id: <20221213061355.62856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, Abaci Robot <abaci@linux.alibaba.com>,
 tiwai@suse.com, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The function snd_azf3328_codec_outl is defined in the azt3328.c file, but
not called elsewhere, so remove this unused function.

sound/pci/azt3328.c:367:1: warning: unused function 'snd_azf3328_codec_outl'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3432
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/pci/azt3328.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 7f329dfc5404..0c6754bf9455 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -363,15 +363,6 @@ snd_azf3328_codec_inw(const struct snd_azf3328_codec_data *codec, unsigned reg)
 	return inw(codec->io_base + reg);
 }
 
-static inline void
-snd_azf3328_codec_outl(const struct snd_azf3328_codec_data *codec,
-		       unsigned reg,
-		       u32 value
-)
-{
-	outl(value, codec->io_base + reg);
-}
-
 static inline void
 snd_azf3328_codec_outl_multi(const struct snd_azf3328_codec_data *codec,
 			     unsigned reg, const void *buffer, int count
-- 
2.20.1.7.g153144c

