From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Thu, 25 Jun 2009 16:26:39 +0100
Message-ID: <ad2655cb0906250826w4745bf3ao3989e5768a28ee08@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
	<9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
	<20090623095444.GC5422@sirena.org.uk>
	<9e4733910906240710y2e5bdb21qfbd03af256094c3f@mail.gmail.com>
	<s5hvdml8zmw.wl%tiwai@suse.de>
	<9e4733910906240814j3dc920dfy6b9c795e7f2339e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id C503D24C81
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 17:26:40 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1747939fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 08:26:39 -0700 (PDT)
In-Reply-To: <9e4733910906240814j3dc920dfy6b9c795e7f2339e9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2009/6/24 Jon Smirl <jonsmirl@gmail.com>:
> If it is so that it can write into the buffer with minimal latency
> there are other ways to accomplish that. The simplest is to just add
> an entry into ALSA core that says, play this buffer with minimal
> latency. That would let the transfer be pushed down into the specific
> driver and that driver could handle it in an optimal way.
>
"minimal latency" is not the only requirement.
Another is "play this sample at a predictable time." in order to
ensure it plays in sync with video for example.
The real problem is ensuring that the application reacts in time to
fill up the buffer before it empties. So, the ideal would be a way to
ensure that "process X gets woken just before the buffer empties". One
way to trigger this is via the sound card hardware interrupt, another
is by using the global timer to wake one up at a particular time.
Using the timer is probably better because the wake up is then more
granular, but one then needs a way to sync the timer with the hardware
clock on the sound card.
I would like a kernel scheduling api that could reliably do "wake me
up at nanosecond X" but none exists. I can do "nanosleep(X)" which
will maybe wake me up in X nanoseconds, but it is not very reliable.
Another useful scheduling api would be "make sure process X is woken
up after me".
