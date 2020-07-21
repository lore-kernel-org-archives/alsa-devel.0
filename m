Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9979EC433E5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A4E2080D
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ePCaBRcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A4E2080D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEAA6851;
	Tue, 21 Jul 2020 05:28:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEAA6851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595302167;
	bh=M68k7+Y6CDLSOctWh9eljFPAQkdM/TNzPSmO8HoXcis=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ePCaBRcTE7RG/MPy8jkezCCTnaE8EPWJCWvxLYTldg+AV4dluiX2kXmw2255IOmrn
	 vU9KtME9VZjsyyzp7T+4Wgz2y61xQLSTxzvrt6Nn7ik8t9ccDhRMpxrTk4S0aXVNOq
	 SwNDm4Nk4XYvZ0GKnBrij65xO8EME4+NkRNxVB+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B935F80087;
	Tue, 21 Jul 2020 05:28:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3014AF8024A; Tue, 21 Jul 2020 05:28:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 59CC0F80087
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 05:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59CC0F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1595302098158725977-webhooks-bot@alsa-project.org>
References: <1595302098158725977-webhooks-bot@alsa-project.org>
Subject: Realtek ALC3254 is not recongised
Message-Id: <20200721032825.3014AF8024A@alsa1.perex.cz>
Date: Tue, 21 Jul 2020 05:28:25 +0200 (CEST)
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

alsa-project/alsa-lib issue #72 was opened from daleclack:

I upgraded the newest alsa,but I found my sound card can't found,and sound output is unable to use.
My Device:DELL G3 3500
Sound Card:Realtek ALC3254
Terminal Output:
[dale-g33500 dale]#  lspci | grep -i audio
00:1f.3 Multimedia audio controller: Intel Corporation Device 06c8
01:00.1 Audio device: NVIDIA Corporation Device 10fa (rev a1)
[dale-g33500 dale]# cat /proc/asound/cards
 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0x83000000 irq 17
[dale-g33500 dale]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k5.7.9-1-MANJARO.
[dale-g33500 dale]# head -5  /proc/asound/card0/codec#0 
Codec: Nvidia GPU 94 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0094
Subsystem Id: 0x102809e1
[dale-g33500 dale]# pacman -Q alsa-lib
alsa-lib 1.2.3.2-1
The Realtek Sound Card is disappeared!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/72
Repository URL: https://github.com/alsa-project/alsa-lib
