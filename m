From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Fri, 27 Aug 2010 16:11:48 -0400
Message-ID: <AANLkTimZdZnXRc9hL6zPhhauf7U=ihCGaNOKK+ve3vXw@mail.gmail.com>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
	<20100826124757.GC5721@sirena.org.uk>
	<AANLkTinY5mcCPKEJcm+Yru-+7U+nEWe+VaWL558UhhrB@mail.gmail.com>
	<20100826185226.GC24381@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 88D3910388B
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 22:11:49 +0200 (CEST)
Received: by vws20 with SMTP id 20so3258963vws.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 13:11:48 -0700 (PDT)
In-Reply-To: <20100826185226.GC24381@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

> Please don't top post, and remember to include context in your reply so
> people can understand the context of your message0. =A0This is standard
> for Linux kernel mailing lists.


Thanks, no more top posts for me...


>
>> I have not entered any constraints into the driver because there really
>> should be no need. =A0The driver just copies whatever PCM data that is
>> provided directly to the DMA buffer. =A0It seems that the problem occurs
>> because the location to copy to is based on the pos suggested by the
>> callback function. =A0I am still finding it difficult to tell how ALSA d=
ecides
>> there is an underrun or overrun. =A0I am definitely trying to read or wr=
ite
>> the pcm data fast enough but it seems as though I get these errors anywa=
y.
>
> I've no idea what "the callback function" is?


The callback function is the PCM copy function that I define in struct
snd_pcm_ops


>
>> Questions:
>> 1. =A0How do I implement an ASoC-style driver that supports multiple chi=
ps
>> when they are connected to the same SPORT but use different SPI chip
>> selects?
>
> Look at current ASoC in -next, I've never tried this multi drop DAI
> setup directly myself but it does support multiple CODECs in the system.


I could not find anything in the linux-2.6.x/sound/soc/ directory
called "next" and cannot find any documentation in
linux-2.6.x/Documentation/sound/alsa/soc about "multi drop"


>
>> 2. =A0How do I define the proper buffer/period size constraints or shoul=
d I
>> ignore the suggested position during copy operations and just keep track=
 of
>> the position within the DMA buffer myself?
>
> Your constraints will flow from the requirements of the hardware plus
> any additional requirements that the driver you've written imposes. =A0For
> example, if you always need a period of data ready to start DMA on which
> the application can't touch for coherency reasons then you need to make
> sure that there's at least three periods (running, about to run and
> updatable), or if your hardware DMAs in blocks you need a minimum period
> size for that.


This information was a little cryptic at first.  It turns out it was
the diamond in the rough though.  I set periods_min in struct
snd_pcm_hardware to 3 and it solved quite a few underrun problems.

Question: Is there a way I can force ALSA to always use a period size
that is a multiple of 16?


>
>> 3. =A0Can you suggest a good way to debug underrun/overrun problems?
>
> There's a few settings for XRUN detection diagnostics in the ALSA core
> code which can be useful - see pcm_lib.c and the SND_PCM_XRUN_DEBUG
> config option.
>


Thank you for this tip.  It turns out you need to enable
SND_VERBOSE_PROCFS to see this option in the kernel configuration.  I
am hoping this additional debug information may help me to figure out
why plughw has never been able to properly convert the sample rate for
me.

Thanks and have a great weekend,
Adam
