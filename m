From: Raymond Toy <rtoy@google.com>
Subject: Re: Alsa timing question
Date: Fri, 26 Aug 2011 08:56:57 -0700
Message-ID: <CAE3TgXFEsyehvsSy6XMY=rnu9BxCw+eEgX-+BH74iSn2Pdjo2w@mail.gmail.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
	<4E55F6A2.3040307@ladisch.de>
	<CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
	<4E575980.12671.44D900@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E9BE724704
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 17:57:01 +0200 (CEST)
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com
	[172.25.149.14]) by smtp-out.google.com with ESMTP id p7QFuxCQ015655
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 08:57:00 -0700
Received: from fxg7 (fxg7.prod.google.com [10.184.7.7])
	by hpaq14.eem.corp.google.com with ESMTP id p7QFuwDJ014832
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 08:56:58 -0700
Received: by fxg7 with SMTP id 7so3940423fxg.21
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 08:56:58 -0700 (PDT)
In-Reply-To: <4E575980.12671.44D900@olivier.myriad-online.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olivier Guillion - Myriad <olivier@myriad-online.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2011 at 1:29 AM, Olivier Guillion - Myriad <
olivier@myriad-online.com> wrote:

> Hi,
>
> Raymond Toy wrote:
> > > > I'm working on an application where I'd like to have relatively fixed
> > > timing
> > > > between calls to snd_pcm_writei.
> > >
> > > Why?
> > >
> >
> > It's a bit complicated.  A different process generates the audio and
> places the
> > data in a shared memory area.  My process sends signals the other process
> to
> > generate more data, I read the shared memory area (for the previously
> generated
> > data).  Sometime later, the other process fills the shared area with new
> > samples.  Thus, if the timing between calls is not fairly regular, I'll
> either
> > reread the same data or miss the new data.  (I'm not in control of how
> this
> > works.  I just have to deal with what I'm given.)
>
> IMO, it's not a good idea to try to synchronize perfectly two processes by
> way
> of an interrupt.
> If the generating process has to remain untouched, you should probably
> bufferize its data in your own process before sending it to writei. It
> would
> add some latency, but make the data flow safer.
> Here is how it could work:
> 1- Your process writes a "magic" pattern at the end of the shared area
> 2- It sends a signal to the other process to make it generate data
> 3- It checks whether the magic pattern is still here
> 4- When changed, it means the data have been calculated. It saves them to
> an
> internal circular buffer
>

A nice idea, but I'm not sure it will work in my scenario.  The "magic"
pattern could potentially be real data (the buffer contains audio samples),
so that would cause funny, hard-to-reproduce glitches.  Plus, I think that
when I request new data, something is always written.

Clemens idea of a counter at the beginning of the buffer would work nicely,
but requires changes in the generating process.

Thanks,

Ray
