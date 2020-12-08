Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6507C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 22:15:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B032388C
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 22:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B032388C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA41016CB;
	Tue,  8 Dec 2020 23:14:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA41016CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607465739;
	bh=EwDWy6o8ncBQllOF5X3jnP/ObpE/VeYXCvMUxj0XBbk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oRHoAia7s77CCN2bfi9IcUuEruqahfOoWkahEZW0imOa69KdZ5cHR2kjuhgnz9L9r
	 0T0vabRzGUhz2C4UhJD8Pl2i35pHt838LiU74YiR9borqY5DNy5UU8I9G9XgbmFYyl
	 SJEGECsnS059s6t7rZfGyHVB+0rSpVib9YUkT7g8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 614FDF800E1;
	Tue,  8 Dec 2020 23:14:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79355F80164; Tue,  8 Dec 2020 23:14:47 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00D83F800E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 23:14:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00D83F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de
 header.b="MV/v5/oa"
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 9EA3E2400FB
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 23:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1607465681; bh=EwDWy6o8ncBQllOF5X3jnP/ObpE/VeYXCvMUxj0XBbk=;
 h=Date:From:To:Cc:Subject:From;
 b=MV/v5/oaYb/bzkBgnF+GGZecNVyi8nD+HK7vsQjj8OO/PmX80tn5Qdpm6A37YcOk7
 pKzBRO1VMyZKXsQ2KPVaduV2zMo5NYn56fd3v2WxjkYEpfe8trL2eMaVb0KFoWPvMC
 jqns+gvSXUg3zfDnnPLH45YsIxAuT91fMP8VsDJR/VmwO2xFsNDgBkmyLPUqDLRcDl
 JX/SPJfNcHZQIjg+a31WMycPmWi+e5s9Hw1wBxppH0Nsf4c9ISN8zUc9N7kST1In0G
 ae2pVFTaS+KpD3Go7ljakSS1CcXPUZ7ZEaps10yq9x+zPsCP9RedvdNan4pM+BtMHR
 6Fsmu7E8Rkc9A==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4CrDxY1TgDz6tmY;
 Tue,  8 Dec 2020 23:14:41 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Dec 2020 23:14:41 +0100
From: meschi@posteo.de
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Steinberg UR22 Crackling and Clicks
In-Reply-To: <s5heek0ugtk.wl-tiwai@suse.de>
References: <ce03244f4699ffc9574ecc2dae41a417@posteo.de>
 <s5hft4gy4ar.wl-tiwai@suse.de> <61da73624ff3855867b8e65936fc2e1c@posteo.de>
 <s5hft4gwdji.wl-tiwai@suse.de> <eb1baf202fa4cd74a502661bb0ce5279@posteo.de>
 <s5ho8j4ujwx.wl-tiwai@suse.de> <987d1956f52ba49dc3b587c33e08bfb2@posteo.de>
 <s5heek0ugtk.wl-tiwai@suse.de>
Message-ID: <4188489e2967b44e57653193cab9d1cb@posteo.de>
X-Sender: meschi@posteo.de
User-Agent: Posteo Webmail
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

>> >> >> > It's likely the issues with the implicit feedback.
>> >> >> >
>> >> >> > The latest development tree (either linux-next tree or
>> >> >> > topic/usb-audio-refactoring branch of my sound.git tree) contains the
>> >> >> > improvements of the implicit feedback mode.
>> >> >> >
>> >> >> >
>> >> >> > Takashi
>> >> When I try to play a file now this happens:
>> >> $ aplay -D plughw:CARD=UR22 ./file.wav
>> >> Playing WAVE './file.wav' : Signed 16 bit Little Endian, Rate 44100
>> >> Hz, Stereo
>> >> aplay: set_params:1407: Unable to install hw params:
>> >
>> > It's a known side-effect of the implicit feedback mode, and the latest
>> > patchset I mentioned earlier addresses the issue.
>> >
>> >
>> > Takashi
>> 
>> I'm already running the kernel built from the linux-next tree...
>> I built next-20201208 from
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> Is there another patch set that I'm missing?
> 
> Hm, strange.
> 
> Please check the contents of /proc/asound/card*/stream* file.  With
> the latest patches and the implicit feedback mode, you should see the
> lines like "Sync Endpoint: 0x...." and "Implicit Feedback Mode: yes".
> 
> 
> Takashi

Yes, I see this:

Yamaha Corporation Steinberg UR22 at usb-0000:00:1a.7-3, high speed : 
USB Audio

Playback:
   Status: Stop
   Interface 1
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x07 (7 OUT) (ASYNC)
     Rates: 44100, 48000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR
     Sync Endpoint: 0x81 (1 IN)
     Sync EP Interface: 2
     Sync EP Altset: 1
     Implicit Feedback Mode: Yes
   Interface 1
     Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x07 (7 OUT) (ASYNC)
     Rates: 88200, 96000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR
     Sync Endpoint: 0x81 (1 IN)
     Sync EP Interface: 2
     Sync EP Altset: 1
     Implicit Feedback Mode: Yes
   Interface 1
     Altset 3
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x07 (7 OUT) (ASYNC)
     Rates: 176400, 192000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR
     Sync Endpoint: 0x81 (1 IN)
     Sync EP Interface: 2
     Sync EP Altset: 1
     Implicit Feedback Mode: Yes

Capture:
   Status: Stop
   Interface 2
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x86 (6 IN) (ASYNC)
     Rates: 44100, 48000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR
   Interface 2
     Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x86 (6 IN) (ASYNC)
     Rates: 88200, 96000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR
   Interface 2
     Altset 3
     Format: S24_3LE
     Channels: 2
     Endpoint: 0x86 (6 IN) (ASYNC)
     Rates: 176400, 192000
     Data packet interval: 125 us
     Bits: 24
     Channel map: FL FR

