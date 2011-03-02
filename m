From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] twl4030_codec cleanup
Date: Wed, 02 Mar 2011 15:28:14 +0200
Message-ID: <4D6E45EE.2000605@nokia.com>
References: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E425E1037EC
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 14:28:39 +0100 (CET)
In-Reply-To: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 03/02/11 15:24, Ilkka Koskinen wrote:
> This series of patches removes duplicate audio_mclk fields from
> twl4030_codec driver.
> 
> The patches have been compiled on sound-2.6/for-2.6.39 branch.
> I haven't tested them on any target board though.
> 
> Ilkka Koskinen (2):
>   omap: Remove unnecessary twl4030_codec_audio settings from board
>     files
>   mfd: twl4030_codec: Remove unused and duplicate audio_mclk fields
> 
>  arch/arm/mach-omap2/board-3430sdp.c          |    4 +---
>  arch/arm/mach-omap2/board-devkit8000.c       |    4 +---
>  arch/arm/mach-omap2/board-igep0020.c         |    4 +---
>  arch/arm/mach-omap2/board-omap3beagle.c      |    4 +---
>  arch/arm/mach-omap2/board-omap3evm.c         |    4 +---
>  arch/arm/mach-omap2/board-omap3pandora.c     |    4 +---
>  arch/arm/mach-omap2/board-omap3stalker.c     |    4 +---
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    4 +---
>  arch/arm/mach-omap2/board-overo.c            |    4 +---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +---
>  include/linux/i2c/twl.h                      |    2 --
>  11 files changed, 10 insertions(+), 32 deletions(-)
> 

Thanks Ilkka!
This was in my to do list, now I can remove this item.

All:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
