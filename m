From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_device_name_hint problems
Date: Sat, 12 Sep 2009 12:09:42 +0800
Message-ID: <4f3252890909112109g69b7fdadi1f8da1a9500a4365@mail.gmail.com>
References: <4AAA1C4B.5000806@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f187.google.com (mail-pz0-f187.google.com
	[209.85.222.187])
	by alsa0.perex.cz (Postfix) with ESMTP id BCB842456A
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 06:09:43 +0200 (CEST)
Received: by pzk17 with SMTP id 17so801024pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2009 21:09:42 -0700 (PDT)
In-Reply-To: <4AAA1C4B.5000806@epost.diwic.se>
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

It seem to me that name hint is not suitable for displaying recording
devices

It's other rare for an user to recording from the same source by more than
one applications.

You can get low latency by using hw device since PA use maximum buffer in
order to save power comsumption for those notebook / netbook.

If your application require high quality (bypass any SRC) , you may need to
capture using hardware rate and format instead of using plughw


For the surround51 in the movie , the LFE is generated in the studio instead
of recording in real life

In the past , AC97 codec has only one ADC , you can select one capture
source only.
so most of the sound card using AC97 codec can capture stereo only

The other high end sound card (e.g. ice1712) can only capture in 12 channels

For HDA , it support multiple streamming. some  HDA codecs (e.g. alc88x and
ad198x) have 3 ADC ( which you can capture three stereo streams concurrently
from internal mic, external mic and line in )


The main problem of the recording audio application is unable to select the
correct mixer control of the three capture sources



2009/9/11 David Henningsson <launchpad.web@epost.diwic.se>

> Hello,
>
> First; I'm not completely sure how much of this is your issue, and how
> much is my distribution's fault (Ubuntu). If you believe my problems is
> due to bugs in the distribution, please say so.
>
> I'm working with a small recording application and I want to enumerate
> possible recording sources/devices, just to put in a combobox. In my
> computer I have two soundcards, one on the motherboard and one PCI
> soundcard (ESI Juli@). I also have Pulseaudio installed, so the devices
> I want to show up are those three - and possibly alternatives under
> these, such as analog/digital inputs.
>
> According to Lennart's guide to sound API's, snd_device_name_hint is the
> way to go, as both snd_card_xxx and snd_config_xxx are deprecated.
> (Speak up if you don't agree.)
>
> So assuming I do about the same as "arecord -L" does, I get the
> following output (descriptions omitted) :
>
> front:CARD=Juli,DEV=0
> surround40:CARD=Juli,DEV=0
> surround41:CARD=Juli,DEV=0
> surround50:CARD=Juli,DEV=0
> surround51:CARD=Juli,DEV=0
> surround71:CARD=Juli,DEV=0
> iec958:CARD=Juli,DEV=0
> null
> front:CARD=CK804,DEV=0
> surround40:CARD=CK804,DEV=0
> surround41:CARD=CK804,DEV=0
> surround50:CARD=CK804,DEV=0
> surround51:CARD=CK804,DEV=0
> surround71:CARD=CK804,DEV=0
>
> I have two problems with this: first thing is that the "pulse" device is
> not listed. I think that could be solved either by setting
> "defaults.namehint.showall" to on, or by setting the name hint of the
> pulse device to be included in the "basic" devices. Would you recommend
> doing either one of those, and if so, which one?
>
> Second problem is that I don't have surround input on either of my
> soundcards, so most of the device options above do not make any sense.
> Even if I try, I have a hard time recording from them (arecord fails to
> record it with various errors, such as "Sample format non available").
> If I instead use "plughw:CARD=name", recording works.
>
> To sum it up, the output I would like to have, is at least these three:
>
> plughw:CARD=Juli
> plughw:CARD=CK804
> pulse
>
> How do I/we get there?
>
> // David
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
