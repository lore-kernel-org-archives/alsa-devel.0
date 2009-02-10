From: Sean McNamara <smcnam@gmail.com>
Subject: Re: Software mixer at kernel level
Date: Mon, 9 Feb 2009 21:27:00 -0500
Message-ID: <74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
References: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 5917410383D
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 03:27:01 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so663824ywa.2
	for <alsa-devel@alsa-project.org>; Mon, 09 Feb 2009 18:27:00 -0800 (PST)
In-Reply-To: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Mauricio_Nu=F1ez?= <mauricio_n2000@hotmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Feb 9, 2009 at 9:02 PM, Mauricio Nu=F1ez
<mauricio_n2000@hotmail.com> wrote:
>
> Hi, I was wondering if it could be possible to implement a low-level soft=
ware mixer (like OSS4's vmix) since almost everybody needs it and PulseAudi=
o causes too much overhead on not-so-old systems.

A few points that have been raised in past discussions of kernel-mode
software mixing:

1. You're stuck with integer precision. Floating point arithmetic in
the kernel is a BIG no-no.
2. Kernel core developers (including Linus) have made it clear that
this kind of math operation should be done in user mode. The reasoning
is that any bug in the kernel can bring down the whole system, or at
least, an entire subsystem (audio, graphics, etc). The point here is
that software mixing is aptly named, in that the mixing is done in
/software/, while the kernel's primary function is to interface with
/hardware/. The kernel needs special privileged memory access,
firmware access, etc. to carry out these operations, but you don't
need any special access beyond what the ALSA pcm interface already
provides, to effectively do software mixing in userspace. From a
perspective of security alone, we would want to follow the policy of
minimal privilege level wherever possible: software should not run
with more privileges than it needs to carry out its function. You
can't effectively limit permissions in kernel mode due to the hardware
design.

I would also add to the discussion that, unlike you insinuated, doing
software mixing in the kernel would not reduce its overhead
significantly. The CPU resources needed by PulseAudio are mainly due
to functions such as resampling, which, if implemented, the ALSA
kernel modules would have to do under software mixing. These
algorithms are quite optimal already given current computer science
theory, and the code is operating without much runtime overhead (it's
written in C).

However, the point about "everybody needs it" is a valid one. If I had
my druthers, it would be impossible for anyone in usermode to
initialize an ALSA pcm in a mode which does not provide software
mixing. We can still provide the software mixing in usermode, but my
reasoning is that

(a) Not using software mixing (i.e., hogging the sound card) makes
your app a poor desktop citizen, because it effectively causes other
programs to appear to malfunction from the user's point of view.
(b) There is very little justification for using the functions that
are part of the "unsafe" ALSA subset. By contrast, if everyone only
used the "safe" ALSA subset, then requiring software mixing (such as
dmix) would be fine. It's only when people want features such as
mmap() that we run into problems with software mixing.
(c) By requiring software mixing at the ALSA-lib user-mode layer, we
can prevent those poor citizens from affecting other desktop apps; we
can guarantee user experience; and we can help establish a broader
consensus as to the sound APIs that should be used on the free
desktop.

Of course, PulseAudio can be said to require software mixing: you
can't be a PulseAudio client without your data stream being subject to
its mixing routines. So they've already done what I just proposed. The
only difference is that, since it's built on top of ALSA, the same
issues are still present within ALSA as have always been there. It's
just that, for backwards compatibility's sake, we can't rightly change
our mind on these things now, unless we can live without things such
as JACK, Ardour, Audacity, Teamspeak, and a host of others.

At some basic level, software mixing requires proper tuning of the
kernel; a fairly recent system; and a "sane" compromise between
desired computational complexity and actually available computing
resources. For instance, trying to use the highest quality floating
point resampling in the libspeex library on a first-generation Pentium
4 might cause some sound quality problems when the system is under
load. That's because you're asking a lot of the CPU to make all those
floating point calculations. The mixing can be done more cheaply, but
you have to pay, to some extent, with quality: either integer samples,
or faster and less accurate algorithms.

If the existing software mixing solutions in usermode are not
performing to your liking, then you may consider upgrading your system
so that these solutions perform adequately for you; or, live with less
expensive resampling algorithms (if you're using PulseAudio). OTOH, if
you are simply dreaming of a day when software mixing is taken for
granted... I think the only way to get there is to keep educating
developers that they need to write their software with a "soft" PCM in
mind, rather than assuming they are talking directly to hardware.

But I can not see how kernel mode mixing will get us there any faster
or easier; on the contrary, it is likely to introduce instability and
become a maintenance nightmare.

HTH,

Sean

P.S. - Not a knock on OSS4 at all, but I have had my system kernel
panic with OSS4 under many different kernels and hardwares over the
years. I sort of liked it for a while when it worked well, but ALSA is
leaps and bounds more stable. This could be a sort of case study, if
you're interested, as evidence supporting the theory that kernel mode
mixing is a bad idea.

>
> _________________________________________________________________
> Explore the seven wonders of the world
> http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=
=3DQBRE
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
