From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Mon, 11 Jan 2010 11:27:25 +0800
Message-ID: <4f3252891001101927l1003b100i8eb439b0d0fb7c73@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
	<4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
	<1262192170.11628.13.camel@localhost.localdomain>
	<4f3252890912302020k35efb96eu686fb16d47783ec5@mail.gmail.com>
	<1262273262.11628.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 5556D1037F5
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 04:27:30 +0100 (CET)
Received: by pxi3 with SMTP id 3so14698677pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 19:27:26 -0800 (PST)
In-Reply-To: <1262273262.11628.24.camel@localhost.localdomain>
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

2009/12/31 Chris <cpollock@embarqmail.com>

> On Thu, 2009-12-31 at 12:20 +0800, Raymond Yau wrote:
> > 2009/12/31 Chris <cpollock@embarqmail.com>
> >
> > > On Wed, 2009-12-30 at 15:07 +0800, Raymond Yau wrote:
> > > > Please post the output of alsa-info.sh
> > > Raymond, I can't seem to locate that script.
> > >
> >
> >
> http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=utils/alsa-info.sh
> >
> Thank you, see attached script output.
> >
> > > > Do your VIA 8237/ens1371 has any digital output/input ?
> > > That I can't answer
> > >
> >
> > Do your motherboard/sound card  has optical/coaxial spdif ?
>
> Not that I can see.
>
>
>
>
With four subdevices in playback device  0 , you should able to run two or
instance of aplay hw:0,0 concurrently  as described in

http://pulseaudio.org/ticket/743#comment:2


 1) Terminal 1: pasuspender cat

 2) Terminal 2: aplay -D hw:0,0

 3) Terminal 3: aplay -D hw:0,0 (again!)



APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
