Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE6C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:45:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87C9207A1
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87C9207A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F7EA1796;
	Wed, 23 Dec 2020 18:44:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F7EA1796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608745531;
	bh=o/7uheQuGhaaSLaTdHSo+9doItYSZpTUChEonIH7hwE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4hQdCm1AEFwsoQMzG2LPgtC5/a0+VfLV5kubgnn+G3Q0VZsE/aE9hObloPG0LKya
	 I2eUsjW+DcMGiG0qF6C7gpEzrdqHQYHRgK1C7jHPB90v4lSK3QOv3kU8n4ssnxX+a5
	 4aEV+o4NmrZCsIxru7/6zeNSLDYwmPfA4BsMCHrM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AF24F80116;
	Wed, 23 Dec 2020 18:44:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D89AF804BD; Wed, 23 Dec 2020 18:44:38 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 478BCF8013F
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:44:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 478BCF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="WF/tlCt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nuZGiQsRLmDtTB9P6tmGfaasfGNWaXjiS5u0zUzEVM0=; b=WF/tlCt/+V6tstz9mt5APMqyBx
 +MtjY3MXVunhxIBFF9eRz1uZy3o2/lBDv6QBloTIn511mDzPPng0xjgHYPK6u9DCM/yNnCRCHZLNe
 tgvwQd3QhOwLV5fYygiHsfGyXSFOQM4AzvofjVWS0TUqRHG5K35njZuIfekB0mipyjfpzsybDVDFl
 ceWZZqBDhp/F2nOZM4E9mGmeC6GSvrC0l7OAs/FDY0Lf+M3Vl5gQGBZu9shtZQ+KtISIllpROOgt6
 E1zHMI/nNyxpJOMEfh23obNpJm17anQzw1hqyz9AzNH3REfkvirwt2KMWdFkTmWREOEwn5s3Mg9f6
 409D55rw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1ks8Ba-0001OP-4T; Wed, 23 Dec 2020 18:44:30 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
 by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000Crk-RX; Wed, 23 Dec 2020 18:23:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 16/18] ALSA: ens1370: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
Date: Wed, 23 Dec 2020 18:22:27 +0100
Message-Id: <20201223172229.781-16-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201223172229.781-1-lars@metafoo.de>
References: <20201223172229.781-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26026/Wed Dec 23 13:53:03 2020)
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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

Use DIV_ROUND_CLOSEST() instead of open-coding it. This documents intent
and makes it more clear what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@r1@
expression x;
constant C1;
constant C2;
@@
 ((x) + C1) / C2

@script:python@
C1 << r1.C1;
C2 << r1.C2;
@@
try:
	if int(C1) * 2 != int(C2):
		cocci.include_match(False)
except:
	cocci.include_match(False)

@@
expression r1.x;
constant r1.C1;
constant r1.C2;
@@
-(((x) + C1) / C2)
+DIV_ROUND_CLOSEST(x, C2)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/ens1370.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index d9acef0826a9..93c4fd313311 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -752,7 +752,7 @@ static void snd_es1371_dac1_rate(struct ensoniq * ensoniq, unsigned int rate)
 	unsigned int freq, r;
 
 	mutex_lock(&ensoniq->src_mutex);
-	freq = ((rate << 15) + 1500) / 3000;
+	freq = DIV_ROUND_CLOSEST(rate << 15, 3000);
 	r = (snd_es1371_wait_src_ready(ensoniq) & (ES_1371_SRC_DISABLE |
 						   ES_1371_DIS_P2 | ES_1371_DIS_R1)) |
 		ES_1371_DIS_P1;
@@ -773,7 +773,7 @@ static void snd_es1371_dac2_rate(struct ensoniq * ensoniq, unsigned int rate)
 	unsigned int freq, r;
 
 	mutex_lock(&ensoniq->src_mutex);
-	freq = ((rate << 15) + 1500) / 3000;
+	freq = DIV_ROUND_CLOSEST(rate << 15, 3000);
 	r = (snd_es1371_wait_src_ready(ensoniq) & (ES_1371_SRC_DISABLE |
 						   ES_1371_DIS_P1 | ES_1371_DIS_R1)) |
 		ES_1371_DIS_P2;
-- 
2.20.1

