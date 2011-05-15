From: Daniel Mack <zonque@gmail.com>
Subject: Re: GR-55 Driver
Date: Sun, 15 May 2011 13:36:35 +0200
Message-ID: <BANLkTik-m+BmV0+vQyVfPPDSmCgXspCuAg@mail.gmail.com>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
	<1305441562.2850.7.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id E2DFC103842
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 13:36:39 +0200 (CEST)
Received: by pxi19 with SMTP id 19so2700970pxi.29
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 04:36:37 -0700 (PDT)
In-Reply-To: <1305441562.2850.7.camel@TrinaryDragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 15, 2011 at 8:39 AM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> I have read this article over a few times, trying to remove the kernel
> and Reiser4 instructions; and I got a little confused; although I did
> get it to compile and now it see's the GR-55 as a sound device; I tried
> to jack it to the output but got no audio; what should I do to test it?

I would just use aplay with a plain wav file and see what it does. And
then try arecord to see whether you can capture any input signal.

> Do these instructions look correct?

[...]

> sudo dpkg -i linux-*.deb
> uname -r # 2.6.39-rc3-gr55+

Very good, this is the desired result.

> One thing strange was that it locked up on reboot, showing rc3, but a
> reset with previous kernel, I saw the gr55 version so I picked it; it
> worked as stated above; just don't know why it didn't set this version
> as default, maybe a step I missed.

No, it's all good. The reason why it locked up might be that you are
now using a premature kernel which has not been officially released.
At the moment, as Linus' mainline tree is in a rather stable phase
(due to a new release coming up the next days or so), what you could
also do is

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git checkout -b alsa
git pull git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
master

As of today, that should give you give a 2.6.39-rc7+ version. But for
testing whether the patch works, the approach you took is totally fine
I think.

Daniel
