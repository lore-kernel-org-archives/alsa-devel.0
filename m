From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Enable audio-bus clock
Date: Fri, 6 Nov 2009 15:09:34 +0000
Message-ID: <20091106150934.GC27699@rakim.wolfsonmicro.main>
References: <1257498024-29163-1-git-send-email-jassi.brar@samsung.com>
	<20091106131330.GB10371@rakim.wolfsonmicro.main>
	<1b68c6790911060648w8a3bca6te94ae2fcd221f1ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA26A24757
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 16:09:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911060648w8a3bca6te94ae2fcd221f1ae@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2009 at 11:48:30PM +0900, jassi brar wrote:
> On Fri, Nov 6, 2009 at 10:13 PM, Mark Brown

> > I'll apply this but I beleive the driver ought to be smarter with the
> > clocks - AFAICT from the documentation the audio bus clock is not
> > guaranteed to be needed.

> this patch only adds the missing code, its no modification.

I'm not sure what you mean by that?  Presumably any system that's
managing to use the driver as-is is doing so by clocking the block from
something other than the audio clock so from their point of view it
isn't needed.

> s3c64xx-i2s driver sure needs to be upgraded, which i plan to do soon if
> nobody else does.

Any news on IISv4 port support?  It'd be good to get the SMDKs to the
point where they can actually play audio.  I had been expecting some
followups from your previous patches.
