From: "Benjamin Otte" <otte-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
Subject: Re: Can't use Mozilla plugin or play video with 0.8.2 /
	0.9.2
Date: Sun, 7 Dec 2008 12:50:53 +0100
Message-ID: <a4ed255b0812070350l4f4ca8bbi1f13b1cdf7018afa@mail.gmail.com>
References: <683785120812021636w6c093898rd2ec9a259b5a02b2@mail.gmail.com>
	<a4ed255b0812041446n12648d19p1797cd6c95056d97@mail.gmail.com>
	<683785120812051224k11f68211t3c2d1d7615b502ed@mail.gmail.com>
	<4939ABE6.90702@gmail.com>
	<683785120812061746g1002e7b9p82d8d9d88950d6ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <swfdec-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <683785120812061746g1002e7b9p82d8d9d88950d6ef-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/swfdec>,
	<mailto:swfdec-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/swfdec>
List-Post: <mailto:swfdec-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:swfdec-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/swfdec>,
	<mailto:swfdec-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Sender: swfdec-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Errors-To: swfdec-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: swfdec-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Carl Worth <cworth-4HiWtcSh4w0dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

I think I know what this is. But I spent the best part of my breakfast
wondering about it. I think using Pulse Audio might work around this
problem, but I think it's a driver, configuration issue on the ALSA
side or a misunderstanding of the API on my part, which is why I'm
sending this to the ALSA list.

So here's the problem:
Swfdec uses ALSA in non-blocking mode and polls its file
descriptor(s). Whenever the audio queue becomes empty enough that it's
useful to render more audio, the file descriptor wakes up from the
poll.

This setting is apparently configurable using various hw params,
however, Swfdec does not configure it and has been relying on the fact
that the sound device picks proper defaults, thinking that a sound
card with a small buffer will likely want to wake up more often than
something like Pulse Audio's new design, which keeps a  2+ second
buffer for the audio.

It seems though that your sound card wakes up roughly whenever a new
sample can be rendered, which is 44100 times per second (or more, as
from your profile it looks like ALSA resamples the audio). This causes
the whole rendering code inside Swfdec to run for every sample, which
is so much overhead that it kills all your performance.

My question to you ALSA people now is: Who's responsible for ensuring
that the number of wakeups is sane?
Should I do some configuring of the audio device and if so, what kind
of configuration, or should ALSA be able to pick reasonable defaults
for me?

Cheers,
Benjamin


On Sun, Dec 7, 2008 at 2:46 AM, Jesse Zbikowski
<embeddedlinuxguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Riccardo,
>
> On Fri, Dec 5, 2008 at 2:32 PM, Riccardo Magliocchetti
> <riccardo.magliocchetti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Give it a run with oprofile, this is my opreport
>
> Thanks for this data.  It looks like I may have an audio bottleneck.
> opreport -t3 shows
>
> 31.5811 no-vmlinux
> 14.4701 libswfdec-0.9.so.3.0.0
> 8.3210 libasound_module_rate_speexrate.so
> 6.0088 libc-2.8.90.so
> 4.7060 libpixman-1.so.0.12.0
> 3.6615 python2.5
> 3.2831 libcairo.so.2.10800.0
>
> If I just look at the libraries I see the top libswfdec routines are
> all audio related:
>
> 14.1497 libswfdec-0.9.so.3.0.0   swfdec_sound_buffer_get_n_samples
>  2.1666  libswfdec-0.9.so.3.0.0   swfdec_audio_format_get_channels
>  1.9369  libswfdec-0.9.so.3.0.0   swfdec_audio_format_new
>  1.7904  libswfdec-0.9.so.3.0.0   swfdec_audio_flv_render
>  1.3205  libswfdec-0.9.so.3.0.0   __i686.get_pc_thunk.bx
>  1.2073  libswfdec-0.9.so.3.0.0   swfdec_audio_format_get_granularity
>
> I could try using the PulseAudio backend instead of ALSA.
>
>> You can try to improve your performance by using latest stable version of
>> cairo and pixman
>
> OK, I am currently using the latest Ubuntu versions which are a bit
> behind latest stable.  I will see if this makes a difference.
>
> Package         Ibex    Latest
> xorg-xserver    1.5.2   1.5.3
> cairo           1.8.0   1.8.4
> pixman          0.12    0.13.2
>
>> play a bit with your X video driver config ie. exa vs xaa.
>
> I did not see libexa.so in my oprofile output although it is
> installed, so I will make sure this is enabled.
>
> Thanks again,
> Jesse Z.
> _______________________________________________
> Swfdec mailing list
> Swfdec-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> http://lists.freedesktop.org/mailman/listinfo/swfdec
>
