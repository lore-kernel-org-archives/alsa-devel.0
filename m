From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_device_name_hint problems
Date: Sun, 20 Sep 2009 17:31:11 +0800
Message-ID: <4f3252890909200231v2959d261ie24e01ea70a41ec9@mail.gmail.com>
References: <4AAA1C4B.5000806@epost.diwic.se>
	<4f3252890909112109g69b7fdadi1f8da1a9500a4365@mail.gmail.com>
	<4AAB4C70.5040805@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F9D24861
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 11:31:12 +0200 (CEST)
Received: by pxi40 with SMTP id 40so1755676pxi.5
	for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2009 02:31:11 -0700 (PDT)
In-Reply-To: <4AAB4C70.5040805@epost.diwic.se>
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

The name hint does not define any device for recording

if you run alsa-lib/test/namehint.c , you should notice that front device is
used for "Front Speakers".

Most likely you cannot use this "front" device for recording

The "pulse" device is in the list since I am using Fedora 10


 ./namehint
NAMEfront:CARD=au8830,DEV=0|DESCAureal Vortex au8830, adb
Front speakers
NAMEsurround40:CARD=au8830,DEV=0|DESCAureal Vortex au8830, adb
4.0 Surround output to Front and Rear speakers
NAMEiec958:CARD=au8830,DEV=0|DESCAureal Vortex au8830, spdif
IEC958 (S/PDIF) Digital Audio Output|IOIDOutput
NAMEnull|DESCDiscard all samples (playback) or generate zero samples
(capture)
NAMEpulse|DESCPulseAudio Sound Server
NAMEdefault|DESCDefault
NAMEfront:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
Front speakers
NAMEsurround40:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
4.0 Surround output to Front and Rear speakers
NAMEsurround41:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
4.1 Surround output to Front, Rear and Subwoofer speakers
NAMEsurround50:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
5.0 Surround output to Front, Center and Rear speakers
NAMEsurround51:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
5.1 Surround output to Front, Center, Rear and Subwoofer speakers
NAMEsurround71:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Analog
7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
NAMEiec958:CARD=Intel,DEV=0|DESCHDA Intel, AD198x Digital
IEC958 (S/PDIF) Digital Audio Output



arecord --list-device
**** List of CAPTURE Hardware Devices ****

card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
card 1: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


2009/9/12 David Henningsson <launchpad.web@epost.diwic.se>

> Raymond Yau skrev:
> > It seem to me that name hint is not suitable for displaying recording
> > devices
>
> But what should I then use? snd_card_xxx will not show the pulse device,
> snd_names_list is deprecated, and snd_config_xxx is not recommended either.
>
> > You can get low latency by using hw device since PA use maximum buffer in
> > order to save power comsumption for those notebook / netbook.
> >
> > If your application require high quality (bypass any SRC) , you may need
> to
> > capture using hardware rate and format instead of using plughw
>
> I will not need low latency for this application, but avoiding SRC would
> probably be a good thing. But I assume the plug handling does not do any
> SRC if it can avoid it by adjusting the hardware?
>
> > For HDA , it support multiple streamming. some  HDA codecs (e.g. alc88x
> and
> > ad198x) have 3 ADC ( which you can capture three stereo streams
> concurrently
> > from internal mic, external mic and line in )
> >
> > The main problem of the recording audio application is unable to select
> the
> > correct mixer control of the three capture sources
>
> What I would like would my enumeration function to return in this case
> would be four entries, one for each ADC and one for them all combined (6
> channels, multi-channel recording).
>
> // David
>
>
