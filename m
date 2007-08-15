From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: Writing a new sound driver
Date: Wed, 15 Aug 2007 16:30:15 -0600
Message-ID: <8e4fc8270708151530g14682db6la5c23069e9041902@mail.gmail.com>
References: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
	<200708121502.09106.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C7882446C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 00:30:17 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so52482fka
	for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2007 15:30:16 -0700 (PDT)
In-Reply-To: <200708121502.09106.linux@audioscience.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/11/07, Eliot Blennerhassett <linux@audioscience.com> wrote:
> Hi Mike,
>
> On Sunday 12 August 2007 10:46:07 Michael Bourgeous wrote:
> > doesn't seem to support DMA for sound.  Is it possible to write a
> > sound driver for ALSA that uses a polling mechanism?
>
> Does it support interrupts?
> If so see
> http://www-old.alsa-project.org/~iwai/writing-an-alsa-driver/x773.htm

Yes, it supports interrupts.  However, there is one caveat, which I'll
describe below.  I believe the Windows driver tells the card to
trigger an interrupt when playback reaches the start of or middle of
the audio buffer.

> > Also, how would
> > I integrate this driver with my core driver for accessing the TL880?
> > The chip's features span four separate kernel subsystems: v4l, dvb,
> > sound, and fb.
>
> What are dependencies if any between these functions on the chip?

The caveat I mentioned above is that all interrupts from the card are
stored in a single register.  If this register is read, its contents
are cleared.  So, only one kernel module can be allowed to handle
interrupts.  Additionally, the card has a very large register space,
and I'd prefer to have a single interface that helps to abstract that
register space.  My eventual goal (which may be a very long time away)
is to have a core module that just handles PCI interaction,
interrupts, register reads/writes, etc., with another module for each
of video capture, MPEG capture and playback, framebuffer, and audio.


Thanks for the info,
Mike Bourgeous
