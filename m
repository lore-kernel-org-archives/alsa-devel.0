From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Fix Atmel soc audio boards Kconfig
 dependency
Date: Wed, 10 Nov 2010 21:04:59 +0000
Message-ID: <1289423099.3284.52.camel@odin>
References: <4CDAFA56.2050504@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DBEAD24429
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 22:05:03 +0100 (CET)
Received: by eyg24 with SMTP id 24so660526eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 13:05:03 -0800 (PST)
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
Cc: gwossum@acm.org, Gaouaou <sedji.gaouaou@atmel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sedji@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-11 at 09:02 +1300, Ryan Mallon wrote:
> Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
> audio SAM9G20-EK and PlayPaq boards. Fixes link errors on missing
> clk_set_parent and clk_set_rate when building without
> AT91_PROGRAMMABLE_CLOCKS.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
