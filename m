From: Raymond Toy <rtoy@google.com>
Subject: Re: Alsa timing question
Date: Thu, 25 Aug 2011 08:52:30 -0700
Message-ID: <CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
	<4E55F6A2.3040307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FEDD24572
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 17:52:40 +0200 (CEST)
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
	[172.24.198.85]) by smtp-out.google.com with ESMTP id p7PFqZ53001173
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 08:52:35 -0700
Received: from fxg11 (fxg11.prod.google.com [10.184.7.11])
	by wpaz21.hot.corp.google.com with ESMTP id p7PFqUf3021308
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 08:52:34 -0700
Received: by fxg11 with SMTP id 11so1978480fxg.6
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 08:52:30 -0700 (PDT)
In-Reply-To: <4E55F6A2.3040307@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 25, 2011 at 12:15 AM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Raymond Toy wrote:
> > I'm working on an application where I'd like to have relatively fixed
> timing
> > between calls to snd_pcm_writei.
>
> Why?
>

It's a bit complicated.  A different process generates the audio and places
the data in a shared memory area.  My process sends signals the other
process to generate more data, I read the shared memory area (for the
previously generated data).  Sometime later, the other process fills the
shared area with new samples.  Thus, if the timing between calls is not
fairly regular, I'll either reread the same data or miss the new data.  (I'm
not in control of how this works.  I just have to deal with what I'm
given.)

>
> > [...] I see is that most calls to snd_pcm_writei are spaced about 50 ms
> > apart.  This makes some sense, but I was expecting the calls to be about
> > 42.67 ms apart.  However, about every 6th call, the time is just 200 us
> > or so.  Why is that?
>
> In theory, when the device is configured for a specific period size, its
> interrupts (and therefore the application wakeups) will arrive spaced at
> this interval (modulo any scheduling delays).
>
> However, if you're using the dmix plugin, the period size of your
> application's device will not necessarily be identical with the period
> size of the hardware device.  To see the actual period size, look into
> /proc/asound/card?/pcm0p/sub0/hw_params.
>
>
It says:

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 44096
buffer_size: 88192

Ray
