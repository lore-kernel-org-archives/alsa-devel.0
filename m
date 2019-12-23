Return-Path: <SRS0=adxF=2N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430AC2D0C8
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 02:42:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D3A20708
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 02:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C4AfRgZz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="3H17n1fN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXv9VkhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D3A20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F35BF1685;
	Mon, 23 Dec 2019 03:41:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F35BF1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577068927;
	bh=bEdqqgG3/SkhT9nUxxAihDv7FqRZAKNHeM6VQ/N7F3k=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C4AfRgZzbzIVsAHr4BRxsDT1MHpArwuVWJfa8uN5UuimIeP2M2RosTOybI26LNqOz
	 fYMInbAM8DivU/sKwhdwtVdoN8fFz9p3+weXIPgQx+E40Wf1yYPDHumxo8mIsPHxst
	 AZraahrTq+DHiSCzzSzQmuOXy4hf9kvB+mGgGhds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A36FF8026A;
	Mon, 23 Dec 2019 03:39:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 873D9F80247; Mon, 23 Dec 2019 03:39:35 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06A48F80087
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2019 03:39:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06A48F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="3H17n1fN"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PXv9VkhE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id C772E21FF3;
 Sun, 22 Dec 2019 21:39:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 22 Dec 2019 21:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=QN8+ucrARF5U0
 lCvL5I31Z1w3FgIZmIgZx0c7e0f74Q=; b=3H17n1fNSJZAh9L2XnCrauAxW4+Gh
 jBD9pa9q/+G971hp57jX3iddZAZ8jwswJQKpqMtVcYiMN2a+tZ5KwloAA5RHtC6B
 TSUtVKIUmwI5fPl8mUlWVXpUkB9LLBzf5WshPgljYsoDlcBA1/1xRcbuForRhqsq
 cG1Z8tCbyL1r9AUXC7XWDKw9gEe0dRdsFXR3vXcIa+ngzOv7udUqmYmVxhQYJTkM
 fQyPZBrnzuyjaNylS31ioaL+NYJKSkvAdAI0aVvkBrNCvozz1GNmCG0WKnDrs5S/
 jA1x/8lf9soQYkI0urkqYy0nID3/CyQterx2ojRKzGrQarUoXRzKXGOqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=QN8+ucrARF5U0lCvL5I31Z1w3FgIZmIgZx0c7e0f74Q=; b=PXv9VkhE
 YOkwwVpxnFHFh1gF6rTEpnk1KCoMva9OIRCjxAQ9PrEGq6sPo8Zkk4G98aoth4q7
 3w6ldIxOmO1+T1RODnhaxbhvaDRWMxFpzxgFMLAp97p9NIBeqVY3kcPu4wd1oVW7
 kI9n1k41UwD0thZnU5KWkAd6PXSztEpqdhrkbbo0k2vMvgvVxycIw/FLZRaQvnsW
 zeFeutGN4Ui0OY2gwPesTQOPhN5b5GNbd3fA0gmk9vTJE4z8NHM2/ep1tfy4xb1I
 yZ4MUdwv7eujubccYV1TLmsQa4XCevesS3dtW1aLH2lYg4ciZrQss9VlVLEyOe9A
 wKaauzH4VPPM6Q==
X-ME-Sender: <xms:3ygAXmeZvQCyj3XAFaLnInDN4NY8sG1PtPfubX5HiTZPK3rzEtyHvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduledggeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecukfhppedugedrfedrjeehrddukedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghh
 ihdrjhhpnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:3ygAXqopwZiNx3SshxmzS9EDImZfrIw7hb_60SIiT0VMWXRdqaLugQ>
 <xmx:3ygAXn-njovjZBgHUPk8E8xmabK1Gi6byS_QDZy0FLifvnzhloQuqA>
 <xmx:3ygAXmIlllU58gVoIopOoUcqNcZTD5tbt5OF0wVw449qMbKfC3TqNg>
 <xmx:3ygAXl0nKUTa4dPluIdFWucrgnfw8hpJnz0MOwLwweavqK-D-Zr5xw>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id AFE898005B;
 Sun, 22 Dec 2019 21:39:26 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Date: Mon, 23 Dec 2019 11:39:19 +0900
Message-Id: <20191223023921.8151-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191223023921.8151-1-o-takashi@sakamocchi.jp>
References: <20191223023921.8151-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 2/4] ALSA: pci: echoaudio: remove usage
	of dimen menber of elem_value structure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In a couple of years ago, 'echomixer' userspace application was revised
not to use 'dimen' member of 'struct snd_ctl_elem_info'.

This commit removes usage of 'dimen' member from echoaudio PCI driver so
that no implementation uses the member.

Reference: 275353bb684e ("ALSA: echoaudio: purge contradictions between dimension matrix members and total number of members")
Reference: 51db452df07b ("Revert "ALSA: echoaudio: purge contradictions between dimension matrix members and total number of members")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/echoaudio/echoaudio.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index a9ac9fc635aa..abad652a4006 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1237,8 +1237,6 @@ static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
-	uinfo->dimen.d[0] = num_busses_out(chip);
-	uinfo->dimen.d[1] = num_busses_in(chip);
 	return 0;
 }
 
@@ -1309,8 +1307,6 @@ static int snd_echo_vmixer_info(struct snd_kcontrol *kcontrol,
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
-	uinfo->dimen.d[0] = num_busses_out(chip);
-	uinfo->dimen.d[1] = num_pipes_out(chip);
 	return 0;
 }
 
@@ -1693,13 +1689,6 @@ static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 	uinfo->count = 96;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = 0;
-#ifdef ECHOCARD_HAS_VMIXER
-	uinfo->dimen.d[0] = 3;	/* Out, In, Virt */
-#else
-	uinfo->dimen.d[0] = 2;	/* Out, In */
-#endif
-	uinfo->dimen.d[1] = 16;	/* 16 channels */
-	uinfo->dimen.d[2] = 2;	/* 0=level, 1=peak */
 	return 0;
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
