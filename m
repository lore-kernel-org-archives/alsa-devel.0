From: Florian Schmidt <mista.tapas-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [LAD] How to get correct midi timings from ALSA using the library
	only
Date: Wed, 25 Jul 2007 11:25:29 +0200
Message-ID: <200707251125.29740.mista.tapas@gmx.net>
References: <46A5BFDF.4040906@gmail.com>
	<200707241206.09991.mista.tapas@gmx.net>
	<46A6B2DC.3030906@gmail.com>
Reply-To: The Linux Audio Developers' Mailing List <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <46A6B2DC.3030906-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo.cgi/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo.cgi/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Carlo Florendo <subscribermail-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 25 July 2007, Carlo Florendo wrote:

> > Try running your process with SCHED_FIFO scheduling and a high prio of
> > e.g. 99.
>
> I've tried that in kernel 2.4 and I get the same latency results.  Let me
> try tweaking that though by running the system with high priority.  The
> reason why I'd like to make it work in 2.4 kernels is so that existing
> systems with 2.4 kernels could run the app without need for a kernel patc=
h.

2.4.x kernels are terribly unsuited to do any serious sort of realtime work=
,=20
be it audio or midi.=20

=46rom my experience this is a classification with increasing suitedness fo=
r=20
realtime work:

1] vanilla 2.4.x
2] patched 2.4.x [lowlatency patches]
3] vanilla 2.6.x
4] patched 2.6.x [ingo molnar's realtime preemption patches]

There really should be like 100 bogus places between 2] and 3] and another =
100=20
between unpatched and patched 2.6.x because 2.6.x really is vastly better=20
than 2.4.x and -rt patched 2.6.x actually is a realtime system which can be=
=20
made to work up to microsecond resolution [not millisecond ;)].

>
> Your ideas have been most helpful :)

No problem. BTW: even when you use ALSA queues, the kernel still plays a bi=
g=20
role. Then it's simply ALSA's responsibility to provide good timing and it=
=20
basically uses the same mechanisms as a userspace program would.

So thrash 2.4.x for all realtime purposes..=20

=46lo


=2D-=20
Palimm Palimm!
http://tapas.affenbande.org
