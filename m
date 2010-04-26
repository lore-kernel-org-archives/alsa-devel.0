From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Mon, 26 Apr 2010 09:46:02 +0800
Message-ID: <u2r4f3252891004251846t4606dbf1pd83fd9df9cf916f1@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>
	<4BD3025D.1060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 49AA624456
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 03:46:04 +0200 (CEST)
Received: by pvg3 with SMTP id 3so269360pvg.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Apr 2010 18:46:03 -0700 (PDT)
In-Reply-To: <4BD3025D.1060207@gmail.com>
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

2010/4/24 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Raymond Yau wrote:
> >>
> >>
> > Is it possible to post the output of your program when using your sound
> card
> > "hw" since your program failed with XRUN (broken pipe) on my two sound
> cards
> > ?
>
>
> Sure, no problem.
>
> However, I had to change 2 settings to get it working on my soundcard:
>
> * change period size from 160 to 320, as my soundcard does not support a
> period size of 160 frames
>
> * change buffer size from 2 periods (1280 bytes) to 1 period (640
> bytes), as my soundcard only supports a buffersize being equal to one
> period
>
>
> After that the program works fine and runs forever (see below).
>
> I'm looking forward to test it on my embedded target as well (with the
> original settings).
> If required I can post the output of that as well.
>
> cheers,
> stefan
>

Are you sure that you really need pulseaudio since your request latency is
quite low ?

You have to ask PA developer whether PA support such low latecny ?

PA (tsched=0 ) configure your sound card 1792 frames per period but your
application request for 160 frames per period

You will need the PA expert to answer how PA server capture 1792 frames from
sound card and send it to your application

: module-alsa-source.c: Using 2 fragments of size 7168 bytes, buffer
time is 81.27ms

D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 1792
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 8070450532247928832
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 8070450532247928832



>
>
>
>
>
