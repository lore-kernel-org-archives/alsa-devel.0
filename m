From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
	TTY API change
Date: Mon, 6 Jun 2011 12:46:50 +0200
Message-ID: <201106061246.51362.jkrzyszt@tis.icnet.pl>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<201105130036.25433.jkrzyszt@tis.icnet.pl>
	<20110606103135.GA12783@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 24257103A04
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:47:27 +0200 (CEST)
In-Reply-To: <20110606103135.GA12783@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Felipe Balbi <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon 06 Jun 2011 at 12:31:40 Mark Brown wrote:
> On Fri, May 13, 2011 at 12:36:07AM +0200, Janusz Krzysztofik wrote:
> > Following the receive_buf() change to return the number of bytes
> > received, the cx20442 CODEC driver was updated to report that we
> > accepted all the data that was offered to us. Do the same with the
> > corresponding Amstrad Delta sound card level wrapper function,
> > which is actually registered as the tty line discipline callback
> > instead of the the CODEC function, which it then calls.
> > 
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Applied, thanks.

Hi Mark,
I've just found the underlying TTY API changes, including cx20442, have 
been reverted, so please drop this patch if you still can, or revert it.
Sorry for inconvenience.

Thanks,
Janusz
