Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02312C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808862076D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m+wMQpxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808862076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wizard.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC663823;
	Tue, 14 Apr 2020 17:37:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC663823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586878682;
	bh=TopLtIuPTaHDGTvwaQM7ety90vS4Hxi+hihQLX6wfGg=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m+wMQpxYL9t0ywV3AI/szIKJoRgc+xbM2WAXShalhnp0pFh3uSGl8Ti/myIO0M0H8
	 Ss+BGOKs7Rf2ucaMvvf2sQq0FhQrLfHkDy8u/nVmpLTeHyWIHorMFm50PGe31DEja2
	 Vyj8BKR04eHyu9rAwVq+tIv/MEkbgh/vJUy1Q6wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A5F4F80115;
	Tue, 14 Apr 2020 17:37:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1067EF8013D; Tue, 14 Apr 2020 16:17:15 +0200 (CEST)
Received: from mail-ob1.cityemail.com (mail-ob1.cityemail.com [104.128.152.18])
 by alsa1.perex.cz (Postfix) with ESMTP id 4F442F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:17:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F442F800B9
Received: (qmail 3418 invoked from network); 14 Apr 2020 14:16:59 -0000
Received: from riddle.wizard.ca (HELO [192.168.1.55])
 (michael@wizard.ca@104.128.144.8)
 by fe1.cityemail.com with (AES128-SHA encrypted) SMTP
 (9aaf64c8-7e5a-11ea-af0b-9b6207e2f18b); Tue, 14 Apr 2020 07:16:59 -0700
To: alsa-devel@alsa-project.org
From: Michael <michael@wizard.ca>
Subject: [FRUSTRATED] Missing Sound Codecs for Lenovo ThinkCentre M710e
Message-ID: <7046b5fa-af79-5221-f54f-3d4be22e879e@wizard.ca>
Date: Tue, 14 Apr 2020 07:16:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MagicMail-OS: Linux 2.2.x-3.x
X-MagicMail-UUID: 9aaf64c8-7e5a-11ea-af0b-9b6207e2f18b
X-MagicMail-Authenticated: michael@wizard.ca
X-MagicMail-SourceIP: 104.128.144.8
X-MagicMail-RegexMatch: 0
X-MagicMail-EnvelopeFrom: <michael@wizard.ca>
X-Archive: Yes
X-Mailman-Approved-At: Tue, 14 Apr 2020 17:37:00 +0200
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

Hi All,

Technically this probably should go to a support channnel, and not a 
development list, but at my wits end.

Kernel:  4.15.0-91-generic #92~16.04.1-Ubuntu SMP

dmesg | grep snd
[   12.656843] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 
i915_audio_component_bind_ops [i915])
[   12.807521] snd_hda_intel 0000:00:1f.3: CORB reset timeout#1, CORBRP = 0
[   12.810429] snd_hda_intel 0000:00:1f.3: no codecs found!

I have been playing with settings in the modprobe directory for Also 
with no effect.. current settings are..

options snd-hda-intel single_cmd=1
options snd-hda-intel probe_mask=1
options snd-hda-intel model=thinkpad
options snd-hda-intel position_fix=3

Have tried model=generic, and various other suggestions from online, but 
at a loss.  Don't see anything in:

https://github.com/torvalds/linux/blob/master/Documentation/sound/hd-audio/models.rst

Your ALSA information is located at 
http://alsa-project.org/db/?f=7898b30139e9a91fecec22f3ee46049f33248b85

Can anyone point me to how to debug this further, or any way to force 
detection of a proper codec for this model?

00:1f.3 Audio device [0403]: Intel Corporation 200 Series PCH HD Audio 
[8086:a2f0]
	Subsystem: Lenovo Device [17aa:313c]
	Kernel driver in use: snd_hda_intel


        description: Motherboard
        product: 313C
        vendor: LENOVO
        physical id: 0
        version: SDK0J40697 WIN 3305181519567
        slot: Default string

Booting in legacy OS mode, not EUFI..



-- 
"Catch the Magic of Linux..."
------------------------------------------------------------------------
Michael Peddemors, President/CEO LinuxMagic Inc.
Visit us at http://www.linuxmagic.com @linuxmagic
A Wizard IT Company - For More Info http://www.wizard.ca
"MagicSpam" is a Registered TradeMark of Wizard Tower TechnoServices Ltd.
------------------------------------------------------------------------
604-682-0300 Beautiful British Columbia, Canada

This email and any electronic data contained are confidential and intended
solely for the use of the individual or entity to which they are addressed.
Please note that any views or opinions presented in this email are solely
those of the author and are not intended to represent those of the company.
