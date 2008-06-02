From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Make Freescale MPC8610 drivers
	more dynamic
Date: Mon, 2 Jun 2008 12:01:01 +0100
Message-ID: <20080602110101.GE9031@rakim.wolfsonmicro.main>
References: <1212187311-22901-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57B32245A7
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 13:01:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212187311-22901-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 30, 2008 at 05:41:51PM -0500, Timur Tabi wrote:
> More miscellaneous changes to the Freescale MPC8610 driver set, with the goal
> of supporting multiple SSIs.

> Minor documentation improvements.  Allow teh CS4270 registers to be read
> via sysfs.  Create the device names from the device tree, to allow multiple
> devices.  Remove separate Kconfig option for the MPC8610 SOC.  Various
> minor code optimizations.  Improve programming of the global utilties
> registers.

Applied, thanks.  However...

> -config SND_SOC_MPC8610
> -	bool "ALSA SoC support for the MPC8610 SOC"
> -	depends on SND_SOC && MPC8610_HPCD
> -	default y if MPC8610
> -	help
> -	  Say Y if you want to add support for codecs attached to the SSI
> -          device on an MPC8610.
> -
> -config SND_SOC_MPC8610_HPCD
> -	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
> -	depends on SND_SOC_MPC8610
> -	select SND_SOC_CS4270
> -	select SND_SOC_CS4270_VD33_ERRATA
> -	default y if MPC8610_HPCD
> -	help
> -	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.
> -
> -endmenu
> +config SND_SOC_MPC8610_HPCD
> +	tristate "Freescale MPC8610 HPCD support"
> +	depends on SND_SOC && MPC8610_HPCD
> +	select SND_SOC_CS4270
> +	select SND_SOC_CS4270_VD33_ERRATA
> +	default y if SND_SOC && MPC8610_HPCD
> +	help
> +	  Say Y or M if you want to enable audio on the Freescale MPC8610 HPCD.

This change means that if someone builds another board with the same CPU
on it then they'll have to add all the objects for the core CPU support
to the Makefile entry for their board.  There should at least be a
separate Kconfig thing, even if it's not user visible.  I've committed a
patch backing this bit out for now.

>   * express or implied.
>   */
>  
> +#define DEBUG
> +

This probably shouldn't be on by default?

In general, it'd be a bit easier to review the changes you're making if
you were able to submit individual changes in separate patches, though I
appreciate that at the minute you're making a lot of changes that go
over large portions of the code and can't be easily separated out so I
wouldn't worry about it too much.
