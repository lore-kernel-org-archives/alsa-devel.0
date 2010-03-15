From: Dajun Chen <dajun.chen@gmail.com>
Subject: Re: Driver for a codec with built-in DSP for MP3
	playback
Date: Mon, 15 Mar 2010 16:41:44 +0000
Message-ID: <b77ca4471003150941v3238542bn8a944818aeb8519b@mail.gmail.com>
References: <b77ca4471003150702q69a99932m36d2e667663749aa@mail.gmail.com>
	<20100315141404.GA13878@sirena.org.uk>
	<b77ca4471003150901x5957d10bl97cc29ede2d072b0@mail.gmail.com>
	<20100315161507.GA15568@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F3624517
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 17:41:45 +0100 (CET)
Received: by fxm20 with SMTP id 20so6215112fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 09:41:45 -0700 (PDT)
In-Reply-To: <20100315161507.GA15568@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks.

Please would you point me the place to see the TI and Intel drivers?

Regards

David

On Mon, Mar 15, 2010 at 4:15 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Mar 15, 2010 at 04:01:34PM +0000, Dajun Chen wrote:
>
> Please don't top post, lack of context makes it difficult to follow the
> thread of discussion.
>
> > I mean example code of a driver which works either on PCM and MP3 (or
> other
> > compressed) audio stream.
>
> ALSA only handles PCM streams itself, compressed audio needs to be
> handled separately.  The TI DSP stuff is one example of handling
> compressed audio, or the Intel Moorestown drivers, but since there's no
> standard for that stuff at the kernel level there's not much to look at.
>
