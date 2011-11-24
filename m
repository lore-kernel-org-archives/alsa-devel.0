From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert mips directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 10:24:34 +0000
Message-ID: <20111124102433.GB8470@opensource.wolfsonmicro.com>
References: <1322101370.16201.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 885F5244D8
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:24:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322101370.16201.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 10:22:50AM +0800, Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/mips/hal2.c       |   13 +------------
>  sound/mips/sgio2audio.c |   13 +------------

This isn't actually an ASoC change - it's a generic sound change so
Takashi would normally take it.
