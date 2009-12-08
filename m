From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA full-duplex questions
Date: Tue, 8 Dec 2009 11:46:49 +0800
Message-ID: <4f3252890912071946h1786fdd9t5bc92c7784481167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id D966E2432C
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 04:46:50 +0100 (CET)
Received: by pwi11 with SMTP id 11so1333929pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2009 19:46:49 -0800 (PST)
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

2009/11/05 pl bossart <bossart.nospam@gmail.com>

>
> Hi,
> I have a very low-*latency* full-duplex application where I would like
> up- and downlink to be synchronous, i.e. period events happen at the
> same time for capture and playback. This would minimize the number of
> wake-ups and enable the platform to go to low power.
>
>
What kind of full-duplex application and how low latency your application
need ?


> I thought snd_pcm_link() would enable this coupling between capture
> and playback, but it looks like it only buids a list of linked devices
> and uses this information for state transitions. Said transitions
> don't look quite atomic by looking at the code. The
> alsa-lib/test/*latency*.c code even tries to measure the difference
> between the number of samples read/written.
> In short the question is whether I can force a synchronous behavior
> from my application, or if I need to roll up my sleeves and fix the
> drivers to see this behavior?
>
>
http://thread.gmane.org/gmane.linux.alsa.devel/37367/focus=37388

To get low latency , your application have to use small period size (i.e.
your system is unlikely go to low power mode )

BTW. do you know how PA calculate "Final latency" ?

D: memblockq.c: memblockq requested: maxlength=4194304, tlength=44100,
base=4, prebuf=44100, minreq=3528 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=44100,
base=4, prebuf=44100, minreq=3528 maxrewind=0
I: protocol-native.c: Final latency 460.00 ms = 210.00 ms + 2*20.00 ms +
210.00 ms
D: module-alsa-sink.c: latency set to 46.44ms
D: module-alsa-sink.c: hwbuf_unused_frames=1
D: module-alsa-sink.c: setting avail_min=4662
D: module-alsa-sink.c: Requesting rewind due to latency change.


> Another solution I thought of would be to disable the period events on
> one of the devices, and handle both devices at once when one period
> event fires. But I am not sure you can disable all events for an audio
> device (was on the wish list of Lennart, not sure if it became
> reality?)
> Thanks for your feedback.
> - Pierre
>
>
