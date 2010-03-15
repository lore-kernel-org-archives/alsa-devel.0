From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for a codec with built-in DSP for MP3
 playback
Date: Mon, 15 Mar 2010 16:15:07 +0000
Message-ID: <20100315161507.GA15568@rakim.wolfsonmicro.main>
References: <b77ca4471003150702q69a99932m36d2e667663749aa@mail.gmail.com>
	<20100315141404.GA13878@sirena.org.uk>
	<b77ca4471003150901x5957d10bl97cc29ede2d072b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0858B244E8
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 17:15:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b77ca4471003150901x5957d10bl97cc29ede2d072b0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dajun Chen <dajun.chen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 15, 2010 at 04:01:34PM +0000, Dajun Chen wrote:

Please don't top post, lack of context makes it difficult to follow the
thread of discussion.

> I mean example code of a driver which works either on PCM and MP3 (or other
> compressed) audio stream.

ALSA only handles PCM streams itself, compressed audio needs to be
handled separately.  The TI DSP stuff is one example of handling
compressed audio, or the Intel Moorestown drivers, but since there's no
standard for that stuff at the kernel level there's not much to look at.
