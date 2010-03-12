From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: PCM_RATE: Check for KNOT and
	CONTINUOUS flags
Date: Fri, 12 Mar 2010 11:16:14 +0000
Message-ID: <20100312111613.GA21260@rakim.wolfsonmicro.main>
References: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D189E103892
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 12:16:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 12, 2010 at 01:38:52PM +0900, Jassi Brar wrote:
> For ASoC, if either CPU or CODEC driver has set the flag, the MACHINE driver
> should be given a chance to figure out if the dai, that set the flag, can
> accomodate a rate that it does not explicitly specify but is specified
> by the dai at the other end of the link.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.

We'll have to work out how to manage the sharing of responsibility for
the clock configuration between the component drivers and the machine
drivers.  My first thought is to have the component drivers provide
functions machine drivers can use if they want to.  It might also be
desirable to allow machine drivers to suppress these flags if they just
want to use standard rates, though IIRC the core does the right thing
anyway.
