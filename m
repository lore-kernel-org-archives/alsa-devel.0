From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa timing question
Date: Fri, 26 Aug 2011 10:02:35 +0200
Message-ID: <4E57531B.3070107@ladisch.de>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>	<4E55F6A2.3040307@ladisch.de>
	<CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 905AD24690
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 10:02:35 +0200 (CEST)
In-Reply-To: <CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> On Thu, Aug 25, 2011 at 12:15 AM, Clemens Ladisch <clemens@ladisch.de>wrote:
> > Raymond Toy wrote:
> > > I'm working on an application where I'd like to have relatively fixed timing
> > > between calls to snd_pcm_writei.
> >
> > Why?
> 
> It's a bit complicated.  A different process generates the audio and places
> the data in a shared memory area.  My process sends signals the other
> process to generate more data, I read the shared memory area (for the
> previously generated data).  Sometime later, the other process fills the
> shared area with new samples.  Thus, if the timing between calls is not
> fairly regular, I'll either reread the same data or miss the new data.

The obvious way to resolve this problem would be to add a signal from
the other process to your process.  Even a serial number in the shared
memory area would help detecting problems.

> (I'm not in control of how this works.  I just have to deal with what
> I'm given.)

"It is a vessel of fertilizer, and none may abide its strength."

> > > [...] I see is that most calls to snd_pcm_writei are spaced about 50 ms
> > > apart.  This makes some sense, but I was expecting the calls to be about
> > > 42.67 ms apart.  However, about every 6th call, the time is just 200 us
> > > or so.  Why is that?
> >
> > In theory, when the device is configured for a specific period size, its
> > interrupts (and therefore the application wakeups) will arrive spaced at
> > this interval (modulo any scheduling delays).
> >
> > However, if you're using the dmix plugin,

Your other mail shows you're using the PulseAudio plugin.

> > the period size of your application's device will not necessarily be
> > identical with the period size of the hardware device.

PulseAudio doesn't use period interrupts, it uses its own timer that,
apparently, runs at 50 ms.

In theory, you should use a period size that is an exact multiple of
50 ms, but in practice, this is not possible because the device's sample
clock is not synchronized with the computer's timer.

You could try to use, e.g.,  500 ms periods so that the inaccuracies of
PA's timer result in smaller relative jitter in your own timing, but
this will increase latency.

Try asking on the PA list how to get accurate period timing.


Regards,
Clemens
