From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix Atmel soc audio boards Kconfig
	dependency
Date: Thu, 11 Nov 2010 14:57:11 +0000
Message-ID: <20101111145710.GF6052@rakim.wolfsonmicro.main>
References: <4CDAFA56.2050504@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7063C10381A
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 15:57:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CDAFA56.2050504@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, gwossum@acm.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2010 at 09:02:30AM +1300, Ryan Mallon wrote:
> Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
> audio SAM9G20-EK and PlayPaq boards. Fixes link errors on missing
> clk_set_parent and clk_set_rate when building without
> AT91_PROGRAMMABLE_CLOCKS.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Applied, thanks.
