From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Mon, 7 Sep 2009 20:06:37 +0100
Message-ID: <a080dbc80909071206m3c07e024n9448b0fe0a2b995d@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de>
	<a080dbc80909070802u544c185erc1efb3f87a95a190@mail.gmail.com>
	<a080dbc80909071004h13a17f2bg3dd06ffd90cd72f4@mail.gmail.com>
	<s5hhbver7h5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC19244B6
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 21:06:37 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2232970fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 12:06:37 -0700 (PDT)
In-Reply-To: <s5hhbver7h5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/7/09, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 7 Sep 2009 18:04:12 +0100,
> Sophie Hamilton wrote:
>  >
>  > On 9/7/09, Sophie Hamilton <sophie-alsa@theblob.org> wrote:
>  > >  I decided to go investigating myself and discovered that the cs46xx
>  > >  driver has a silly minimum period size declared of 1. Increasing this
>  > >  to 256 fixes the problem, though I haven't yet tested to see if lower
>  > >  values will work too. (I'll do this and regenerate the patch later.)
>  >
>  > Turns out that a value of 64 is the optimum value.
>
> How did you determine it ? :)

Well, I have the actual hardware - at least, one of the chips it
supports - which is how I got involved in this bug in the first place.
(The Turtle Beach Santa Cruz uses a CS4630.) A value of 32 didn't work
when the default period side from ALSA is used; the next highest power
of two, 64, does.  As all the values I've seen in the kernel for the
minimum period size are powers of two, I'm assuming that this is the
lowest it can be. (I don't know much about ALSA, bear in mind; this is
my first venture into ALSA programming *and* kernel patches.)

>  Well, I find also 64 is a sane value, but it's not always logical.
>  In most cases, 32 is used as the minimum value due to PCI h/w
>  limitation.  But 32 is very hard to achieve, so it doesn't matter
>  so much.

Like I said, I have the hardware, and I can tell you that on my
hardware, 32 doesn't work properly, while 64 does. :)

>  > This should be the final patch. How should I go about submitting this?
>
> Please give a proper patch summary, too.
>  Also, it'd be more helpful if you give an example what actually
>  your patch fixes (e.g. audacious, etc).

I'm not sure what you mean by a "proper patch summary". Is there
anywhere I should read that specifies the format of a proper patch
summary?

As for what it fixes, it fixes a problem in the case where neither a
period size nor a buffer size is passed to ALSA, instead using the
defaults provided. This is the recommended course of action according
to a guide to safe ALSA usage by Lennart Poettering - see
http://0pointer.de/blog/projects/guide-to-sound-apis.html . Among
other things, the guide says that in order for an app to remain safe
and playable on all backends that ALSA supports, it should "not touch
buffering/period metrics unless you have specific latency needs".

This guide is already being followed by various apps and audio
interfaces - Audacious is one of them, and OpenAL (a popular audio
interface used by many games including Second Life and Unreal
Tournament) is another. As such, there are quite a few examples where
the current buggy behaviour can be observed on a card that the cs46xx
driver serves. (I don't know of a full list; as I said above, I'm new
to ALSA programming.)

Does this help?

 - Sophie.
