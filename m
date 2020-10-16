Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70F8C433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F11722201
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AbQpCNwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F11722201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DFE01827;
	Sat, 17 Oct 2020 00:49:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DFE01827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602888617;
	bh=n2hH1dbSWLZ53WML8MizqGSk6xp92MprNloLrboWdxY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AbQpCNwp9hY2rCyt2YysZSLkgW6jeXvzXDtm7fmyn3ExvDpgpqElGafy+IgN/FgBg
	 OFdENxgXwj0lj9tNXgKHduzd3ooXzWGAm+Gf8qW/DaGkKU3so7mKHbWgWU3srCsvox
	 yrxnZyxRF9FOjm4c/5F3zSZuQuEMD84TgGcFiVws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72B3BF80115;
	Sat, 17 Oct 2020 00:49:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9682EF8020D; Sat, 17 Oct 2020 00:49:23 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5396DF800B8
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2020 00:49:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5396DF800B8
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1kTYXB-0001gz-A3; Fri, 16 Oct 2020 22:49:13 +0000
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/ca0132: make some const arrays static,
 makes object smaller
Date: Fri, 16 Oct 2020 23:49:13 +0100
Message-Id: <20201016224913.687724-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrays on the stack but instead make them
static. Makes the object code smaller by 57 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
 173256	  38016	    192	 211464	  33a08	sound/pci/hda/patch_ca0132.o

After:
   text	   data	    bss	    dec	    hex	filename
 172879	  38336	    192	 211407	  339cf	sound/pci/hda/patch_ca0132.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2b38b2a716a1..e0c38f2735c6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7910,8 +7910,12 @@ static void ae7_post_dsp_asi_stream_setup(struct hda_codec *codec)
 
 static void ae7_post_dsp_pll_setup(struct hda_codec *codec)
 {
-	const unsigned int addr[] = { 0x41, 0x45, 0x40, 0x43, 0x51 };
-	const unsigned int data[] = { 0xc8, 0xcc, 0xcb, 0xc7, 0x8d };
+	static const unsigned int addr[] = {
+		0x41, 0x45, 0x40, 0x43, 0x51
+	};
+	static const unsigned int data[] = {
+		0xc8, 0xcc, 0xcb, 0xc7, 0x8d
+	};
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
@@ -7925,10 +7929,12 @@ static void ae7_post_dsp_pll_setup(struct hda_codec *codec)
 static void ae7_post_dsp_asi_setup_ports(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	const unsigned int target[] = { 0x0b, 0x04, 0x06, 0x0a, 0x0c, 0x11,
-					0x12, 0x13, 0x14 };
-	const unsigned int data[]   = { 0x12, 0x00, 0x48, 0x05, 0x5f, 0xff,
-					0xff, 0xff, 0x7f };
+	static const unsigned int target[] = {
+		0x0b, 0x04, 0x06, 0x0a, 0x0c, 0x11, 0x12, 0x13, 0x14
+	};
+	static const unsigned int data[] = {
+		0x12, 0x00, 0x48, 0x05, 0x5f, 0xff, 0xff, 0xff, 0x7f
+	};
 	unsigned int i;
 
 	mutex_lock(&spec->chipio_mutex);
-- 
2.27.0

