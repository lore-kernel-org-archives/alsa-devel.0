From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to
	debugfs
Date: Fri, 22 Nov 2013 17:42:04 +0100
Message-ID: <20131122164204.GB5893@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
 <20131121142208.GU2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B45A22616AC
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 17:42:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131121142208.GU2674@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Nov 21, 2013 at 02:22:08PM +0000, Mark Brown wrote:
> On Wed, Nov 20, 2013 at 10:04:16AM +0100, Markus Pargmann wrote:
> 
> > This patch moves the statistics to debugfs and disables interrupts
> > completely if the kernel is build without DEBUG_FS enabled.
> 
> We can still see the error counts through /proc/interrupts even without
> the debugfs file.

The interrupts are visible without the debugfs file when enabled through
SIER register. But it does not show the specific reason for the interrupts.

I am not sure what you suggest. To remove the stats file completely and
always disable interrupts?

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
