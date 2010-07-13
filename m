From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Tue, 13 Jul 2010 08:57:10 +0200
Message-ID: <4C3C0E46.70500@epost.diwic.se>
References: <4C22670D.8010104@epost.diwic.se>
	<s5h6319dj90.wl%tiwai@suse.de>	<4C2487EA.3090605@epost.diwic.se>
	<s5hzky6bgy2.wl%tiwai@suse.de>	<s5heifcsvom.wl%tiwai@suse.de>	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>	<s5hiq4or5cz.wl%tiwai@suse.de>
	<4C376182.5050807@epost.diwic.se>	<AANLkTinIl5AyMZyJNabLzdfvGRjU8A6wikmoO4edGt9v@mail.gmail.com>	<4C381651.6060603@epost.diwic.se>
	<AANLkTiknkc75yGObTq5DJxsa5Wswpg7tTLDKEsEh76DE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213]) by alsa0.perex.cz (Postfix) with ESMTP id 986512460D
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 08:57:17 +0200 (CEST)
Received: from c83-254-141-16.bredband.comhem.se ([83.254.141.16]:42155
	helo=[192.168.8.103])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1OYZQX-00023z-7Q
	for alsa-devel@alsa-project.org; Tue, 13 Jul 2010 08:57:15 +0200
In-Reply-To: <AANLkTiknkc75yGObTq5DJxsa5Wswpg7tTLDKEsEh76DE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-07-13 07:08, Raymond Yau skrev:
> 2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>
> 
>>> PA developer often complain the driver did not provide accurate playback
>>> position by the pcm_pointer callback
>>>
>>> Did the pulse_pointer callback also provide accurate position of the
>> pulse
>>> device ?
>>
>> Yes, but it provides the pointer to the fake ring buffer (the alsa-lib
>> plugin system expects that all pcm plugins are ring buffers, which seems
>> to me like a design flaw).
>>
> This mean that pulse_pointer jump suddenly when PA wake up from sleep and
> write audio to sound card until the ring buffer is empty, Those "0 bytes in
> queue " message is the result of PA server flush the ring buffer.

> Did alsa-lib regard this condition as underrun, since the application
> pointer and hardware pointer of the pulse device  seem at the same point ?

No, I don't think so. An underrun message is a special message sent from
the PA server and should not be directly related to the fake ring
buffer, and it is that message now being ignored (configurable, thanks
to Takashi).

My first patch
(http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=1675414)
fixes so that if pa_stream_writeable_size returns a value greater than
the ring buffer's size, it only reports size-1 bytes available, which
means that the alsa app won't see it as the application pointer and hw
pointer being the same.

> Is this the reason why alsa-time-test.c fail on the pulse device ?

No idea, haven't looked further into that application.

// David
