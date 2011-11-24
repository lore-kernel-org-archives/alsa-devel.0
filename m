From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v7 0/3] ARM: mxs: add recording support for
	saif
Date: Thu, 24 Nov 2011 15:46:20 +0800
Message-ID: <20111124074619.GJ17979@S2100-06.ap.freescale.net>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
	<20111124073605.GI17979@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 2662B103B2B
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:34:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111124073605.GI17979@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, marek.vasut@gmail.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 03:36:05PM +0800, Shawn Guo wrote:
> During the testing, the saif driver's dependency on
> REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
> in sound/soc/mxs/Kconfig rather than leaving it to users.
> 
Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.

-- 
Regards,
Shawn
