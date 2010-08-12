From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Thu, 12 Aug 2010 11:27:34 +0200
Message-ID: <4C63BE86.5070402@gmx.de>
References: <4C595A52.7030401@gmx.de>	<AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>	<4C5AB324.2020006@gmx.de>	<AANLkTimSVVvT2zvhKhcSPyOgf76q2ea61xtjEOd3Kp3t@mail.gmail.com>	<4C5C1D8A.2040906@gmx.de>
	<AANLkTikcC-KvBQPsgBgSJ8VT9EZA7E2wU-aCjmhE3M1M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id A09702443D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 11:26:21 +0200 (CEST)
In-Reply-To: <AANLkTikcC-KvBQPsgBgSJ8VT9EZA7E2wU-aCjmhE3M1M@mail.gmail.com>
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

Am 12.08.2010 03:38, schrieb Raymond Yau:
> 2010/8/6 Sebastian H. <vand2@gmx.de>
> 
>>
>>> EQ Peaks is a  volatile control without write access  (i.e. you cannot
>> use
>>> slider since you cannot modify the value ) which provide the peak of  10
>>> bands (31Hz, 63Hz, 125Hz, 250Hz, 500Hz, 1Kz, 2Kz, 4Kz, 8Kz , 16Kz) stereo
>>> channels of the au8830's hardware equalizer  ,  ( one stereo vu-meters at
>>> each band )
>>>
>>> The values are ordered  by left channel of 10 bands followed by right
>>> channel of 10 bands
>>>
>>>
>>>  control.12 {
>>>         comment.access read
>>>         comment.type INTEGER
>>>         comment.count 20
>>>         comment.range '0 - 32767'
>>>         iface MIXER
>>>         name 'EQ Peaks'
>>>         value.0 1
>>>         value.1 1
>>>         value.2 0
>>>         value.3 0
>>>         value.4 1
>>>         value.5 1
>>>         value.6 1
>>>         value.7 1
>>>         value.8 0
>>>         value.9 0
>>>         value.10 1
>>>         value.11 1
>>>         value.12 0
>>>         value.13 0
>>>         value.14 0
>>>         value.15 0
>>>         value.16 1
>>>         value.17 1
>>>         value.18 0
>>>         value.19 0
>>>     }
>>
>> Where do you get this listing from?
>> I greped through the alsa source but did not find it.
>> Is it an amixer output or so?
>>
> 
> it is the content of file produced by "alsactl store -f  abc.txt"
> 
> alsactl is an alsa-util which store/restore the setting of the sound cards
> when you logout/login or the system is shutdown/boot

Oh, ok. thx

> BTW , it seem that the slider cannot individually control left or right
> channels volume

This should be possible in the channel mixer dialog (button on the
sidebar).
I also plan a right-mouse-button menu for each slider which would allow
to open the channel mixer dialog directly.

> How about selecting other CTL devices such as pulse (alsa-pulse plugin) or
> equal ( alsa-equalizer plugin )

Yes, definitely!
I'll try to implement at least a -D option for the next release.
A ctl selection may be a bit trickier though since some ctl entries may
require arguments.
