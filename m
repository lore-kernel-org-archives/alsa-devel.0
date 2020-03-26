Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB86C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:00:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3994720722
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Tv+vMJeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3994720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A9EE1666;
	Thu, 26 Mar 2020 18:59:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A9EE1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585245614;
	bh=Sq2vbaci0N4cu05EWBrONKVA4Hmp00WWda0Sv5G30C0=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tv+vMJeW5pR7CArTUrmXJ564mGIwf4kN4Bw06L+L1iMXQIxSP4MXhKWBDJ+YAvD9K
	 XF2h6DMWGbsQAsq/3mBnhJjt/pIIJEw0SakphYkcJenhm6Y9MgSnz9umAQltEnnLBA
	 ZtQeqn1olqMk7enpgfOXVdRUnlZg6YmityRFYPgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8572F801F9;
	Thu, 26 Mar 2020 18:59:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E679F80227; Thu, 26 Mar 2020 18:59:21 +0100 (CET)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 009C4F80095
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 18:59:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 009C4F80095
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 92E52A1EE2D17;
 Thu, 26 Mar 2020 18:59:17 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 38YvGKYBcbBF; Thu, 26 Mar 2020 18:59:12 +0100 (CET)
Received: from [192.168.105.191] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id D1497A1ED7777;
 Thu, 26 Mar 2020 18:59:11 +0100 (CET)
Subject: Re: Functionality of pcm_notify in snd-aloop?
To: Jaroslav Kysela <perex@perex.cz>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <b4af9071-f8d7-5b47-4d7a-c5743bd67394@ivitera.com>
 <61d837f1-de1a-7aa6-ca8f-d0cfaa36ea69@perex.cz>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <28a05a44-55bf-1831-aa3c-875e0499caea@ivitera.com>
Date: Thu, 26 Mar 2020 18:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <61d837f1-de1a-7aa6-ca8f-d0cfaa36ea69@perex.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dne 26. 03. 20 v 18:44 Jaroslav Kysela napsal(a):
> Dne 26. 03. 20 v 18:19 Pavel Hofman napsal(a):
>> Hi,
>>
>> Please how is the module params pcm_notify supposed to be used, to do
>> what the documentation says: Break capture when PCM format/rate/channels
>> changes?
>>
>> Breaking capture side operation when the playback side changes the
>> params is very useful, but I cannot find a way to use this param
>> properly. When the capture side is open, the playback side cannot use a
>> different parameter than the one currently used by the capture side (the
>> configuration space is limited)
> 
> Really? Then it's a bug introduced by the last changes.
> 
> If you look to sources:
> 
>       if (get_notify(dpcm))
>                 runtime->hw = loopback_pcm_hardware;
>         else
>                 runtime->hw = cable->hw;
> 
> And:
> 
>       if (!(cable->valid & ~(1 << substream->stream)) ||
>             (get_setup(dpcm)->notify &&
>              substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
>                 params_change(substream);
> 
> So the functionality should be there.

I am using older kernels (4.15 and 3.16), but this is an old functionality.

modprobe snd-aloop pcm_substreams=1 pcm_notify=1,1


Playback with no capture

aplay -v --dump-hw-params -D hw:0,0 -r 48000 -c 2 -f S32_LE /dev/zero
Přehrávám syrová data '/dev/zero' : Signed 32 bit Little Endian,
Frekvence 48000 Hz, Stereo
HW Params of device "hw:0,0":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S16_BE S32_LE S32_BE FLOAT_LE FLOAT_BE
SUBFORMAT:  STD
SAMPLE_BITS: [16 32]
FRAME_BITS: [16 1024]
CHANNELS: [1 32]
RATE: [8000 19200000]
PERIOD_TIME: (0 65536000]
PERIOD_SIZE: [1 524288]
PERIOD_BYTES: [64 1048576]
PERIODS: [1 1024]
BUFFER_TIME: (0 524288000]
BUFFER_SIZE: [1 4194304]
BUFFER_BYTES: [64 8388608]


Playback with capture running (arecord at 48000):

aplay -v --dump-hw-params -D hw:0,0 -r 96000 -c 2 -f S32_LE /dev/zero
Playing raw data '/dev/zero' : Signed 32 bit Little Endian, Rate 96000
Hz, Stereo
HW Params of device "hw:0,0":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: 32
FRAME_BITS: 64
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (166 2730667)
PERIOD_SIZE: [8 131072]
PERIOD_BYTES: [64 1048576]
PERIODS: [1 1024]
BUFFER_TIME: (166 21845334)
BUFFER_SIZE: [8 1048576]
BUFFER_BYTES: [64 8388608]
TICK_TIME: ALL
--------------------
Warning: rate is not accurate (requested = 96000Hz, got = 48000Hz)
         please, try the plug plugin


Thanks a lot.

Pavel.
