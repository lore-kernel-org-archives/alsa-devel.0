Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241E1061B39
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:01:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04AB9601F3;
	Tue, 31 Mar 2026 14:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04AB9601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774958463;
	bh=YhkviEvpahXA7HNVJLTAHTmUd2hIxcNri6UZpjZI50k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SlCs5yDHGZcD1sPqykd5J+VbgC+eRcjZaHmmusMoEuM3B0NhL9EJN7CswWmdFjHAy
	 6U1EtwWxcFgfNyLIJ3wIp8nCG+DCeGXRVFcUsrt0g/H8Dbf0SuCMpW705clPb41w5q
	 C7+JNvsvsfuxC61LrSeWbCAcibpT/kKab0id4Qt4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30D47F805E1; Tue, 31 Mar 2026 14:00:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 499F9F805E1;
	Tue, 31 Mar 2026 14:00:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08E8DF80549; Tue, 31 Mar 2026 14:00:18 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47D3AF80087
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 14:00:15 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8A3783A216;
	Tue, 31 Mar 2026 14:00:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8A3783A216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1774958414; bh=giY6AUzp+vmExW807WX53n8W0Nu0pfpOfEiELlaVfAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pUD0THL7Sru72mJue4o1VOB82pZ3met0xvybEuZebBNqEeq8J2R4aXqyR9iCDHZzk
	 1k78g1YCgIoo2wRk7kA4937pGpf43ZtAbcvXWF1neFayJH2XAn0SRIGbmNTyTsueOT
	 WzTLIvZ2DkKutpq0UiPr5hH0TwHiG4gTKGN9thik=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue, 31 Mar 2026 14:00:04 +0200 (CEST)
Message-ID: <a1b6b2ed-2e26-48ff-afab-60f90ecc4360@perex.cz>
Date: Tue, 31 Mar 2026 14:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <87se9htms4.wl-tiwai@suse.de>
 <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
 <87ikadtgpe.wl-tiwai@suse.de>
 <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
 <878qb8tsib.wl-tiwai@suse.de> <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
 <cfb84df3-c2bf-4173-bc45-7df29b6a94a3@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <cfb84df3-c2bf-4173-bc45-7df29b6a94a3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AFP2HSTYFDM6XMTR55DY2BVQM3HRUEDG
X-Message-ID-Hash: AFP2HSTYFDM6XMTR55DY2BVQM3HRUEDG
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AFP2HSTYFDM6XMTR55DY2BVQM3HRUEDG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 3/31/26 12:56, Péter Ujfalusi wrote:

> Pipewire uses the minimum period size internally for headroom calculation:
> https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/9c42c06af00818038be494fd41632cb2d50a0df5
> 
> This works more or less, but things started to get out of control soon.

It's conditional, so it's not a general rule. Pipewire just tries to push the 
drivers to limits with hard-coded assumptions.

> To get the most power saving benefit, you would want quite big
> DeepBuffer, let's say 100ms but for video/voice calls you don't want
> this big buffer, around 40ms should be OK, some other use case might
> need something in between.
> If you run tinyplay on the DeepBuffer PCM w/o  specifying period size,
> it will fail to find the minimum and outright fails unless we lower the
> DB to around 20ms.
> With 20ms you don't have much power savings in case of audio playback.
> So, you spam out several PCM devices with different DeepBuffer to
> accommodate use cases, this is really not something that makes sense.
> 
> This is the reason why I have reversed the rules and adjusted the
> DeepBuffer size based on the period size.
> In this case we still need to limit how large the DB can be, so it is
> not true that the DeepBuffer equals to the period size, it is caped.

It seems that the discussion somewhere else:

1) applications don't know what they are want, thus driver will enforce a 
configuration (e.g. a forced deep buffer)

2) ALSA PCM period mapping to the hardware which allows "deep buffering"

At the moment, nothing prevents ALSA applications to use the bigger period 
sizes when there are known beforehand like "play background music". In other 
words - power efficiency can be controlled from the app. The applications can 
also update PCM buffer at any time, so new data (we are speaking about 
playback) can be feed at any time to make the time window for the underrun 
occurrence shorter when the driver transfers data to the hardware.

We may have those configurations (* = future when driver tells the initial 
count of queued periods):

  period | period count | init_periods  | minimal data latency |
--------+--------------+---------------+----------------------+---------
  4ms    | 4            | unsettled (1) | 4ms                  | realtime
*4ms    | 200          | 25            | 100ms                | semi-realtime
  1000ms | 2            | 1             | 1000ms               | pwr efficient

> Strictly locking the DeepBuffer with period size creates another
> obstacle for audio applications, audio servers like PW don't care about
> periods, they work on the buffer with timer based updates and rewriting
> samples in buffer ahead of the hw_ptr.

IMHO, the period size describes the expected minimal latency and applications 
can put more samples to the PCM buffer. So the whole question is to give 
suggestions which data threshold is safe for the standard operation.

The timer based queuing should just help to feed data more frequently, but it 
does not mean that applications should not set the period size based on the 
requirements. Ideally, everything should be coordinated - period sizes with 
proper sample feed timing from the application side.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
