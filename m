From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND][PATCH] ASoC: Update omap/ams-delta for
	TTY API change
Date: Fri, 13 May 2011 09:00:40 +0200
Message-ID: <20110513070040.GA18783@opensource.wolfsonmicro.com>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
	<201105130036.25433.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5EEA1103841
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 09:00:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201105130036.25433.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Felipe Balbi <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2011 at 12:36:07AM +0200, Janusz Krzysztofik wrote:
> Following the receive_buf() change to return the number of bytes 
> received, the cx20442 CODEC driver was updated to report that we 
> accepted all the data that was offered to us. Do the same with the 
> corresponding Amstrad Delta sound card level wrapper function, which is 
> actually registered as the tty line discipline callback instead of the 
> the CODEC function, which it then calls.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but as the TTY API change is in the TTY tree at the minute and not ASoC
you should send this to Greg K-H (ideally also with Liam's ack) unless
it's not been applied by the time the merge window comes round.
