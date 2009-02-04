From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
 controller
Date: Wed, 4 Feb 2009 13:15:05 +0100
Message-ID: <20090204131505.380492af@hcegtvedt>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<20090204120045.GB29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D7C1F24385
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:15:06 +0100 (CET)
In-Reply-To: <20090204120045.GB29849@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Feb 2009 12:00:52 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Wed, Feb 04, 2009 at 12:48:34PM +0100, Hans-Christian Egtvedt
> wrote:
> > This patch adds ALSA support for the AC97 controller found on Atmel
> > AVR32 devices.
> 
> > Tested on ATSTK1006 + ATSTK1000 with a development board with a AC97
> > codec.
> 
> > Signed-off-by: Hans-Christian Egtvedt
> > <hans-christian.egtvedt@atmel.com>
> 
> Just glancing over the code here this looks very like the code for the
> AT91 AC97 controller which Sedji (CCed) has posted in the past.  Is it
> possible to share the same driver for both chips, like we're doing
> with the ASoC drivers for the two architectures?  It'd make life
> easier if that were possible and I know there's a lot of people
> interested in the AT91 support for mainline.

Yes, it should be possible to share the AC97C driver between AT91 and
AVR32. Although this AC97C driver uses the DesignWare DMAC controller
(drivers/dma/dw_dmac.c).

I do not remember which DMA interface AT91 devices uses.

Should the driver go into sound/drivers then? And renamed to
atmel-ac97c.{c,h} for example.

-- 
Best regards,
Hans-Christian Egtvedt
