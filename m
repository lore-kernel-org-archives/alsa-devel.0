From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 4/7] S3C64XX PCM: Added PCLK clock source
 for the PCM controllers
Date: Tue, 17 Nov 2009 13:23:42 +0000
Message-ID: <20091117132342.GG823@rakim.wolfsonmicro.main>
References: <1258444424-24087-1-git-send-email-jassi.brar@samsung.com>
	<20091117115546.GB823@rakim.wolfsonmicro.main>
	<1b68c6790911170433x38ceefe7he33ee949f212eb98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C35E11037F1
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 14:23:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911170433x38ceefe7he33ee949f212eb98@mail.gmail.com>
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

On Tue, Nov 17, 2009 at 09:33:41PM +0900, jassi brar wrote:

> Since this was a part of PCM support i thought I shud submit
> everything in the series.
> Perhaps things don't work that way?

If you just send a patch to one tree with no commment about other trees
or other reference to the fact that you're not actually submitting the
patch people are going to assume that you're trying to submit it.

In general you should only submit the patch via a single path.  If you
feel you need send a second copy for reference then you need to indicate
that this is what you're doing, for example with a comment in the patch
after the --- (where the diffstat is) so that people know what your
intention is.
