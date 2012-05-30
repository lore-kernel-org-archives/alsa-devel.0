From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Internal Mics and Speakers not visible in
	PulseAudio
Date: Wed, 30 May 2012 21:04:53 +0800
Message-ID: <CAN8cciYgk5L5PWQkzcd3XF_7eZvzTpzC_eUifCG=hOFymJsx7Q@mail.gmail.com>
References: <4FC616B8.3090608@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id AFC6D24793
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 15:04:53 +0200 (CEST)
Received: by wibhn14 with SMTP id hn14so3386270wib.2
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2012 06:04:53 -0700 (PDT)
In-Reply-To: <4FC616B8.3090608@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

2012/5/30 David Henningsson <david.henningsson@canonical.com>:
> Posted to both alsa-devel and pulseaudio-discuss lists, as this is a cross
> issue.
>
> PulseAudio tries to figure out what equipment is present on the machine
> using the mixer. If it finds e g "Headphone Playback Volume", "Headphone
> Playback Switch", or "Headphone Jack", it assumes that a headphone is
> present and creates a headphone port. If it finds no ports, it creates a
> fallback "Analog Output" port.
>
> Now assume that we have a laptop with speakers and a headphone jack, but
> with only a "Master Playback Volume", and a "Headphone Jack" for the jack
> detection.
> PulseAudio will take the "Headphone Jack", and create a headphone port. Now,
> if this port is currently unconnected/unavailable, it will not show up at
> all [1]. As a result, the internal speakers - for which no port was created
> - will be essentially unusable.
>
> Now, I thought this was a problem with a pair of machines only, that we
> could easily quirk on the PulseAudio side. But after looking through Ubuntu
> bugs and posting a blog post [2] about the issue, I have now collected 21
> different machines affected, mostly on the input side. Several Realtek chips
> are affected on the dmic side, and some older STAC92xx chips have problems
> in both directions.
> So it becomes evident to me, that this is something that needs to be fixed
> pretty fast.
>
> So, to move forward, we need to expose these speakers and internal mics to
> userspace. A very simple (untested) patch is attached. This would make
> "Internal Mic Jack" and "Speaker Jack" show up. Note that the actual status
> can be overridden/ignored on the PulseAudio side - the importance here is
> the sign that there are internal mics and speakers, so that the PulseAudio
> ports get created.
>
> I could develop it a little to make sure we don't actually do any jack
> detection for these pins but always return them as being true/present.
> That is, if you approve the idea? I admit that the "Internal Mic Jack" is
> somewhat misleading/hacky as the internal mic is not connected to any
> physical jack, but it seems like the simplest way of resolving the problem
> currently.
>
>
>
I am afraid this does not work with desktop computer which has front
mic , internal mic, Line in ,CD (or stereo mix with those via hda
codecs)

With ubuntu 12.04 and unity ,  if I enable hda jack detect with my
ad198x on my desktop, sound  preference does not allow me to select
front mic since I am still using ac97 front panel (with no jack detect
circuit)

Although the rear mic and line in jacks are detectable, when I unplug
the rear mic, the sound preference automatically switch to the "web
cam mic" since the desktop does not has any internal mic

The concept of using jack detection to select recording source is not
suitable when there is more than two undetectable sources or two
detectable jacks

Some user may connect the output of TV card to the blue jack of ad198x
which is loop back to green jack. The presence of jack in "Line in"
does not implies that the user is intend to select Line in as input
source since the user is just using the analog mixing of ad198x codec

The correct way  is to use the items in "Input Source" or "Capture Source"


Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Line'
