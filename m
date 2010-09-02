From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: defaults.pcm.minperiodtime 5000
Date: Thu, 2 Sep 2010 16:09:20 +0800
Message-ID: <AANLkTiktDiPvVcOLZK_wQzOL1Z55jAkQxaDw=DDUCrCP@mail.gmail.com>
References: <AANLkTinW0tbBLOczuTY=2p2+EZQrqBAFdEHdLeOFX8y5@mail.gmail.com>
	<alpine.LNX.2.00.1008120822420.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D989F103816
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 10:09:20 +0200 (CEST)
Received: by ewy21 with SMTP id 21so60933ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2010 01:09:20 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008120822420.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/12 Jaroslav Kysela <perex@perex.cz>

> On Thu, 12 Aug 2010, Raymond Yau wrote:
>
>>
>> BTW , it seem this patch change the behaviour of alsa-lib too.
>>
>> all sound cards will now have a minperiodtime 5000
>>
>
> Nope. If application settles the period time/size, the behaviour is
> unchanged (see the min/max condition). We just want to limit the period
> sizes for applications which do not know what they are doing and allow any
> period time/sizes. It's better to limit the minimal period size to avoid
> generation of many interrupts per second in this case.
>
>
This mean that if application did not set sample rate by using
snd_pcm_hw_params_set_rate_near() , alsa-lib will select default rate
(minimum rate of 1 Hz for alsa-pulse plugin )

    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
                          1, PA_RATE_MAX);


This kind of application cause PA server aborted immediately in Fedora 10
and Fedora 13
