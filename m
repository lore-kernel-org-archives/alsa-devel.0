From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 2/2] ARM DaVinci: Add ALSA SoC driver for
 the Lyrtech SFFSDR board
Date: Wed, 19 Nov 2008 09:29:51 -0500
Message-ID: <20081119092951.35b0a38f.hugo@hugovil.com>
References: <1227076652-23370-1-git-send-email-hugo@hugovil.com>
	<1227076652-23370-3-git-send-email-hugo@hugovil.com>
	<20081119111116.GB13250@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 014D7103806
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 15:29:53 +0100 (CET)
In-Reply-To: <20081119111116.GB13250@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Nov 2008 11:11:17 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Wed, Nov 19, 2008 at 01:37:32AM -0500, Hugo Villeneuve wrote:
> > The PCM3008 is used on the Lyrtech SFFSDR board, in conjunction
> > with an FPGA that generates the bit clock and the master clock
> 
> > Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> but I'll...
> 
> > +	printk(KERN_INFO "sffsdr_hw_params: rate = %d Hz\n", fs);
> 
> ...change this to a pr_debug() before pushing it since displaying this
> every time playback or record starts is excessive for normal use.

Ok, no problem, it was only there for initial debugging.

Hugo V.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
