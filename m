From: Raymond Toy <rtoy@google.com>
Subject: Re: Alsa timing question
Date: Mon, 29 Aug 2011 11:41:41 -0700
Message-ID: <CAE3TgXFmAddrqz-R7rZ5kn5dw0_KH7q=WFZv9cF9_AbP=b-caw@mail.gmail.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
	<4E575980.12671.44D900@olivier.myriad-online.com>
	<CAE3TgXFEsyehvsSy6XMY=rnu9BxCw+eEgX-+BH74iSn2Pdjo2w@mail.gmail.com>
	<4E58A600.877.18C109@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 01545244C0
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 20:41:47 +0200 (CEST)
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com
	[172.24.198.88]) by smtp-out.google.com with ESMTP id p7TIflsP012742
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 11:41:47 -0700
Received: from fxg7 (fxg7.prod.google.com [10.184.7.7])
	by wpaz24.hot.corp.google.com with ESMTP id p7TIfg7c004680
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 11:41:45 -0700
Received: by fxg7 with SMTP id 7so7001709fxg.35
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 11:41:42 -0700 (PDT)
In-Reply-To: <4E58A600.877.18C109@olivier.myriad-online.com>
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

On Sat, Aug 27, 2011 at 1:08 AM, Olivier Guillion - Myriad <
olivier@myriad-online.com> wrote:

> Hi,
>
> Raymond Toy <rtoy@google.com> wrote :
> > > IMO, it's not a good idea to try to synchronize perfectly two processes
> by way
> > > of an interrupt. If the generating process has to remain untouched, you
> should
> > > probably bufferize its data in your own process before sending it to
> writei.
> > > It would add some latency, but make the data flow safer. Here is how it
> could
> > > work: 1- Your process writes a "magic" pattern at the end of the shared
> area
> > > 2- It sends a signal to the other process to make it generate data 3-
> It
> > > checks whether the magic pattern is still here 4- When changed, it
> means the
> > > data have been calculated. It saves them to an internal circular buffer
> > >
> >
> > A nice idea, but I'm not sure it will work in my scenario.  The "magic"
> > pattern could potentially be real data (the buffer contains audio
> samples), so
> > that would cause funny, hard-to-reproduce glitches.
>
> You are theorically right, even if I doubt that much genuine audio buffer
> could
> end with, let's say : 0x8000 0x7FFF followed by "This is magic!!!" string
> :)
>

Agreed.


>
> >  Plus, I think that when I
> > request new data, something is always written.
>
> I thought it was asynchronous, and you just send a signal to your
> generating
> process to ask it generate data.
>

I'm not 100% sure, but the signal is really request to generate the next set
of data and the "current" set is returned.  If we call faster than
necessary, we always get some data, plus calls to generate new data to be
read next time.  I suspect the new data is just written into a buffer,
overwriting whatever was there.  Hence, the problem I have if the callback
requests are not regularly spaced according to the period size.

>
> > Clemens idea of a counter at the beginning of the buffer would work
> nicely, but
> > requires changes in the generating process.
>
> Right. But if you can modify  the generating process and recompile it,
> there is
> no more problem. Can you?
>

Sure, but once I have to modify both, there's not point in a "magic" string.
 I can do what Clemens suggested.

Ray
