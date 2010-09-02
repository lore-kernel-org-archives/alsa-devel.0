From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: defaults.pcm.minperiodtime 5000
Date: Thu, 2 Sep 2010 10:21:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009021019370.10278@eeebox2.perex-int.cz>
References: <AANLkTinW0tbBLOczuTY=2p2+EZQrqBAFdEHdLeOFX8y5@mail.gmail.com>
	<alpine.LNX.2.00.1008120822420.10278@eeebox2.perex-int.cz>
	<AANLkTiktDiPvVcOLZK_wQzOL1Z55jAkQxaDw=DDUCrCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DC1A110381E
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 10:21:25 +0200 (CEST)
In-Reply-To: <AANLkTiktDiPvVcOLZK_wQzOL1Z55jAkQxaDw=DDUCrCP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Sep 2010, Raymond Yau wrote:

> 2010/8/12 Jaroslav Kysela <perex@perex.cz>
>
>> On Thu, 12 Aug 2010, Raymond Yau wrote:
>>
>>>
>>> BTW , it seem this patch change the behaviour of alsa-lib too.
>>>
>>> all sound cards will now have a minperiodtime 5000
>>>
>>
>> Nope. If application settles the period time/size, the behaviour is
>> unchanged (see the min/max condition). We just want to limit the period
>> sizes for applications which do not know what they are doing and allow any
>> period time/sizes. It's better to limit the minimal period size to avoid
>> generation of many interrupts per second in this case.
>>
>>
> This mean that if application did not set sample rate by using
> snd_pcm_hw_params_set_rate_near() , alsa-lib will select default rate
> (minimum rate of 1 Hz for alsa-pulse plugin )
>
>    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
>                          1, PA_RATE_MAX);
>
>
> This kind of application cause PA server aborted immediately in Fedora 10
> and Fedora 13

The alsa-pulse plugin should provide valid accepted rate range. It's not 
issue in alsa-lib. I would set the low limit to something like 5000Hz.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
