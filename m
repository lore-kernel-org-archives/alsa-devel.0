Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFABC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:28:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EACC206CB
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GWVNNLZ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="dXT/Ivmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EACC206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E88168C;
	Wed,  1 Jul 2020 14:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E88168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593606507;
	bh=FC99/WFD8ZUmXhJeyNoFxnVBVzyoKbVLMTirzteEXiE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GWVNNLZ9PJ9RNqxJg0U4u3n6WX3dtIi+3BG8oYu2qlWigbCw2dZnR7GBPULLEEZqj
	 HBd+knbA0NqPQwCbhmLxtoIdwkUtirFuENgxBsCNHcTQY+RC7+Bdbu/mJ1zuM6ZOAX
	 8EMlZIY7rOoSnw3MSTW0Yln3siXpVquhVY6BRu3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FBA7F802A8;
	Wed,  1 Jul 2020 14:27:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3DA5F8025F; Wed,  1 Jul 2020 14:27:27 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0A80F8020C
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 14:27:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0A80F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="dXT/Ivmg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sPd/5mS+9ReK0t094NvzAo3atIxzy2bNU5BMQ3kT/pU=; b=dXT/IvmgGy/Pg665QUMSqwB5ex
 UOc0yz6IuvedYxv/YzgLEaxviupplPL/PJgbwdLZLP1dGo42tqqQE9yuk4ZiSvsobjXXXSSo6GvXs
 SEAk6dC/IZXj0224q7u8BZ/r4BjugMgyFXyMieqGtRHhYNHxdKYVPHX6Cn4yHQ+IXJl3yZyWTd+ck
 7ODQrR0nKpc4yjpDrhtHmMBjgUZd5m9KEGDefO5vCKebNfYCpczZpL+7usOYdUJCRoWXKxJYMcdJT
 d1Yc9OI6LW0PKCaGrtQLyqU7J3VTdznquSQxqSHE//9fCJYzZavipxAkyhNGaYh2TaH6v14gjlkV1
 qJsLf4/w==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jqbpj-0009kP-O7; Wed, 01 Jul 2020 13:27:23 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jqbpj-0004e7-GR; Wed, 01 Jul 2020 13:27:23 +0100
From: Mark Hills <mark@xwax.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] echoaudio: Prevent some noise on unloading the module
Date: Wed,  1 Jul 2020 13:27:22 +0100
Message-Id: <20200701122723.17814-3-mark@xwax.org>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <2007011319580.23012@tamla.localdomain>
References: <2007011319580.23012@tamla.localdomain>
Cc: alsa-devel@alsa-project.org
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

These are valid conditions in normal circumstances, so do not "warn" but
make them for debugging.

Signed-off-by: Mark Hills <mark@xwax.org>
---
 sound/pci/echoaudio/echoaudio_dsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index f02f5b1568de..d10d0e460f0b 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -898,7 +898,7 @@ static int pause_transport(struct echoaudio *chip, u32 channel_mask)
 		return 0;
 	}
 
-	dev_warn(chip->card->dev, "pause_transport: No pipes to stop!\n");
+	dev_dbg(chip->card->dev, "pause_transport: No pipes to stop!\n");
 	return 0;
 }
 
@@ -924,7 +924,7 @@ static int stop_transport(struct echoaudio *chip, u32 channel_mask)
 		return 0;
 	}
 
-	dev_warn(chip->card->dev, "stop_transport: No pipes to stop!\n");
+	dev_dbg(chip->card->dev, "stop_transport: No pipes to stop!\n");
 	return 0;
 }
 
-- 
2.17.5

