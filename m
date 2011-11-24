From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v7 0/3] ARM: mxs: add recording support for
	saif
Date: Thu, 24 Nov 2011 15:36:05 +0800
Message-ID: <20111124073605.GI17979@S2100-06.ap.freescale.net>
References: <a>
 <1321977265-14959-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D607103ABA
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:24:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321977265-14959-1-git-send-email-b29396@freescale.com>
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

On Tue, Nov 22, 2011 at 11:54:22PM +0800, Dong Aisheng wrote:
[...]
> Dong Aisheng (3):
>   ARM: mxs: add saif clkmux functions
>   ARM: mx28evk: add platform data for saif
>   ARM: mx28evk: set a initial clock rate for saif
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |   38 +++++++++++++++++++++++
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 ++-
>  arch/arm/mach-mxs/include/mach/common.h         |    1 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++-
>  arch/arm/mach-mxs/include/mach/digctl.h         |   21 ++++++++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   18 +++++++++-
>  7 files changed, 84 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
> 
Applied, thanks.

During the testing, the saif driver's dependency on
REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
in sound/soc/mxs/Kconfig rather than leaving it to users.

-- 
Regards,
Shawn
