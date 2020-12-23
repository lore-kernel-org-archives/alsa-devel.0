Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:48:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FD8207D2
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FD8207D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3992D17E7;
	Wed, 23 Dec 2020 18:47:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3992D17E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608745691;
	bh=ILYQBT2VBsJ1aXZek4CMzDy95Z2JOOWDkqg3+MXeMTc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ap5n5mbV6cUU/oXgkwdHGXTKpMHlQ6pNJby9RrThOY3Ugn192V+FnblbesTVzQ3Ph
	 PVf1aqU4ruG19GFGz5RgNRnixw1GEizXKYBLwIXnzI1VVU6+IpS3iVWM7PT84Rt6fs
	 EysItW0iuc1wNrOJVdh9+sMkSq/TNfDKn8MqSSe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F026EF804ED;
	Wed, 23 Dec 2020 18:44:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13189F804E0; Wed, 23 Dec 2020 18:44:45 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56C4AF801EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:44:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56C4AF801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="BQBbZpFV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jas3II4B6NhABFSwerDEfkIJ+sDOaowYWFKzYUUXVK0=; b=BQBbZpFV7130fkbvf4Uj+qdZqs
 O/RVsMUxQpIAAkV5DIDt0TUKwNZVsBZ55V/Srr7YcjX1gGp6S/DMEENUoPvaP0BlvVAT5i+MzDiE/
 ouaKRUwoToRQADdta4Sk30HaXqX9GZ8gcu/TA5sjotjyKkmy1DQilkolOvPERy/ZX/ZIM3c8wRcHW
 peI+jMmBVDONSB6M+wfxpVdMV5p4E7z/eItac+XYn6RpkFdF4ygUf8Zjfm4G26llErHrBTmpMP1vh
 iNxYHTsDEL58WKSFrSj3UgAT5kZ0Wu22Yf7Waj064K70obDTvRswc23EbPYEQH6H5/kiUSE9XuWYb
 jI0tItBw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1ks8BZ-0001O8-Rd; Wed, 23 Dec 2020 18:44:29 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
 by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000Crk-Pp; Wed, 23 Dec 2020 18:23:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 15/18] ALSA: trident: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
Date: Wed, 23 Dec 2020 18:22:26 +0100
Message-Id: <20201223172229.781-15-lars@metafoo.de>
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
@@
expression x, y;
@@
-((x) + ((y) / 2)) / (y)
+DIV_ROUND_CLOSEST(x, y)

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
 sound/pci/trident/trident_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 6e50376163a2..8d0d0d8335ec 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -678,7 +678,7 @@ static unsigned int snd_trident_convert_rate(unsigned int rate)
 	else if (rate == 48000)
 		delta = 0x1000;
 	else
-		delta = (((rate << 12) + 24000) / 48000) & 0x0000ffff;
+		delta = DIV_ROUND_CLOSEST(rate << 12, 48000) & 0x0000ffff;
 	return delta;
 }
 
@@ -1034,7 +1034,7 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 	ESO_bytes++;
 
 	// Set channel sample rate, 4.12 format
-	val = (((unsigned int) 48000L << 12) + (runtime->rate/2)) / runtime->rate;
+	val = DIV_ROUND_CLOSEST(48000U << 12, runtime->rate);
 	outw(val, TRID_REG(trident, T4D_SBDELTA_DELTA_R));
 
 	// Set channel interrupt blk length
-- 
2.20.1

