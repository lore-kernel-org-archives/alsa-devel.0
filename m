From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Thu, 25 Feb 2010 11:34:28 +0800
Message-ID: <4f3252891002241934q488797c8t40a16daa9bcea6a@mail.gmail.com>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<alpine.LNX.2.00.1002200937560.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D141103926
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 04:34:29 +0100 (CET)
Received: by pwi9 with SMTP id 9so4755570pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 19:34:28 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002200937560.28127@eeebox2.perex-int.cz>
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

2010/2/20 Jaroslav Kysela <perex@perex.cz>

> On Fri, 19 Feb 2010, Raymond Yau wrote:
>
>
>>>
>>>  PA assume every sound card can only record from one capture source at
>> the
>> same time (like those AC97 card )
>>
>> However HDA support multi streaming capture , the capture device 0 may
>> have
>> more than one subdevice "Capture sources"  depend on the codec and  device
>> 2  has 2 subdevice for capturing "Input sources" on some codec
>>
>> Is HDA_SUBDEV_NID_FLAG or any API for the application to find the correct
>> mixer control for these kind of capturing subdevices  ? ( simple mixer api
>> is not able to know the subdevice number )
>>
>
> This API is not implemented at the time.
>
>                                        Jaroslav
>


How did the current implementation of VIA Smart 5.1 and Independent HP mode
affect alsa application such as pulseaudio ?

There are two playback subdevices and driver is supposed to support 5.1
smartly when the speaker jack is plugged


But PA developer seem expect an "2 4 6 channels switch" in all HDA codec

**** List of PLAYBACK Hardware Devices ****

card 0: NVidia [HDA NVidia], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

http://pulseaudio.org/ticket/743

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4895

seem bug in alsa driver for rear channels ?
