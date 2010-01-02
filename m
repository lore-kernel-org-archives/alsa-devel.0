From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Sat, 2 Jan 2010 10:05:56 +0800
Message-ID: <4f3252891001011805n71380ca7g355339538ed5864c@mail.gmail.com>
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
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id C8BF224749
	for <alsa-devel@alsa-project.org>; Sat,  2 Jan 2010 03:05:57 +0100 (CET)
Received: by pwi18 with SMTP id 18so34515306pwi.32
	for <alsa-devel@alsa-project.org>; Fri, 01 Jan 2010 18:05:56 -0800 (PST)
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
D: alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open hw:0
D: alsa-util.c: Maximum hw buffer size is 682 ms
D: alsa-util.c: Set buffer size first, period size second.
I: alsa-util.c: Device hw:0 doesn't support 44100 Hz, changed to 48000 Hz.

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=Documentation/sound/alsa/ALSA-Configuration.txt

  Module snd-via82xx
  ------------------

 Note: VIA8233/5/7 (not VIA8233A) can support DXS (direct sound)
	  channels as the first PCM.  On these channels, up to 4
	  streams can be played at the same time, and the controller
	  can perform sample rate conversion with separate rates for
	  each channel.
	  As default (dxs_support = 0), 48k fixed rate is chosen
	  except for the known devices since the output is often
	  noisy except for 48k on some mother boards due to the
	  bug of BIOS.
	  Please try once dxs_support=5 and if it works on other
	  sample rates (e.g. 44.1kHz of mp3 playback), please let us
	  know the PCI subsystem vendor/device id's (output of
	  "lspci -nv").
	  If dxs_support=5 does not work, try dxs_support=4; if it
	  doesn't work too, try dxs_support=1.  (dxs_support=1 is
	  usually for old motherboards.  The correct implemented
	  board should work with 4 or 5.)  If it still doesn't
	  work and the default setting is ok, dxs_support=3 is the
	  right choice.  If the default setting doesn't work at all,
	  try dxs_support=2 to disable the DXS channels.
	  In any cases, please let us know the result and the
	  subsystem vendor/device ids.  See "Links and Addresses"
	  below.




APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
card 0: V8237 [VIA 8237], device 1: VIA 8237 [VIA 8237]
  Subdevices: 1/1
