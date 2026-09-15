Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CB6C88E53
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:48:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7287C6017E;
	Tue, 15 Sep 2026 09:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7287C6017E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789458519;
	bh=zLBE4wx3A+1Qv6Ed851Is4Nd1jEIBZZ9/sUykJbX56Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cJTTqus7PgDbGdj2pnHzQLFfYuFdeyyE6vVjM+XK/TizD18ibGv8L/ht/MLbMqPvX
	 4/PHltk8qAhl9doWUBw95TYNlPcwBO5VSbwOFNDrW7WxM6LDoqBgoZ+H4pW/P+ryMP
	 fWhMUDU8XWHKH/XYnB6B5ZVzyIRKf3x6Z//32s6s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 533B6F80600; Tue, 15 Sep 2026 09:48:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CC2DF80602;
	Tue, 15 Sep 2026 09:48:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0682F80588; Tue, 15 Sep 2026 09:47:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789458472;
	b=VCuK18DYhLl9x9PBngwcwx6mh/Ky1G5CpU0EfPZhsWTo7Ya97u1KhLM2nwhks5AbcV5Y
	 Ik9TiVitGlUxf4rnQcLWKyT755Ew8dCoq3msYAk+HSPGr6jn2HcxpN0+jWldQgZlg4gyu
	 TcywMsVd9UgKoelU2QF+vIX+llYmgZ2Dyc3Go7Ejlx3wNorblsuSuiLEMdswM6yKZm+Zw
	 enyb/YEG3YVCCGiZCIziTsXBZKZBM3RI7VP65GzQZ9iJjRcIQ1CzSAjTNyWh0m8b/oyl7
	 mwP5Qa1OqAoDz2nuFWNclaXjwq83jmkV51wu3U4CTXto64iT8WaE7YZXCcU7wfQGtAQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789458472;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=zLBE4wx3A+1Qv6Ed851Is4Nd1jEIBZZ9/sUykJbX56Q=;
	b=q1GnTboK5l5lgNtFZqeMdRsPtiJbbfXN7oCV1ybRgGFeCwkEKcj5NqSrnZc4hQSS3cth
	 Y3H7x20ErzrTitl+UeknxE40tKQgb/zGfNL4U0LI9PJ8hY1AF0tEmAf7AY1m8Z9UIbWDe
	 tgr+wouHit5H1JQmqFjQSisx1GVDC5BGoEJITi6M/yNIqnzPq61ilCq5AIsih/+gwLxOP
	 ase2zsBCUp6e0NzmGf0fV1iDKVp7+4ckNPwcHatmPmXLJoGKqibfECZO0nGj64hrPnYgy
	 ZogGJoirdllPNKmiR08h5pIBxGZUe86skcHIdHuYVD0VP6qIegOiqJxaAvAbbt7sUcQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EF70BF80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 09:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF70BF80217
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d56eff61b30000-webhooks-bot@alsa-project.org>
In-Reply-To: <18d56eff6187a500-webhooks-bot@alsa-project.org>
References: <18d56eff6187a500-webhooks-bot@alsa-project.org>
Subject: Digital microphone array (DMIC) not working on Huawei MateBook D14
 2022 (Intel Alder Lake / Conexant SN6140)
Date: Tue, 15 Sep 2026 09:47:56 +0200 (CEST)
Message-ID-Hash: HHBSNSSDCJF2BJBTHS7I6RKMED5KGWCU
X-Message-ID-Hash: HHBSNSSDCJF2BJBTHS7I6RKMED5KGWCU
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HHBSNSSDCJF2BJBTHS7I6RKMED5KGWCU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #857 was opened from lemonchik11:

Hello,

The built-in digital microphone array (DMIC) is completely silent and not capturing any audio on Huawei MateBook D14 2022 (Intel Alder Lake CPU). 

Hardware Details:
- Laptop: Huawei MateBook D14 2022
- Audio Codec: Conexant SN6140 (reported as SN6140 Analog under legacy HDA, subsystem ID 0x19e5:0x327e)
- OS: Arch Linux (Omarchy)
- Kernel: 7.2.3-arch1-3
- Sound Server: PipeWire / WirePlumber

What was tested:
1. Standard fallback 'snd-hda-intel' initializes the card in legacy analog mode. It creates a phantom "Internal Microphone" jack port but it stays completely dead (silence).
2. Forcing 'options snd-intel-dspcfg dsp_driver=3' to engage Sound Open Firmware (SOF) breaks the PCH bus entirely: the audio card completely disappears from the system, and the I2C-connected touchpad lock up (stops moving, only clicks respond). 
3. Manual pin retasking via 'hdajackretask' on Pin 0x19 (setting it to Internal Mic / Other Digital In) does not route the DMIC stream correctly.
4. The wired headset mic via 3.5mm jack works perfectly under standard legacy mode (dsp_driver=1), but the internal digital mic array remains completely inaccessible.

Here is my ALSA information link:
https://alsa-project.org/db/?f=2cc12e607be21d152c7f6e955013eff00dbbd432

Could you please assist in creating a correct UCM profile or kernel patch/quirk to map the digital microphone array for this Conexant SN6140 revision on Intel Alder Lake platforms? 

Thank you!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/857
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
