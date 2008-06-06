From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ac97: add support for wm9711 master left
	inv switch
Date: Fri, 6 Jun 2008 16:09:42 +0100
Message-ID: <20080606150941.GF24872@sirena.org.uk>
References: <Pine.LNX.4.64.0806061659550.3338@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 78FE0243FC
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 17:09:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806061659550.3338@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 06, 2008 at 05:02:57PM +0200, Guennadi Liakhovetski wrote:
> From: Juergen Beisert <j.beisert@pengutronix.de>
> 
> This patch adds support for Master Left Inv Switch on wm9711.
> At least required to drive the mono speaker on the PXA270 platfrom
> 
> Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Note that ALSA patches should really be CCed to the alsa-devel mailing
list (CC added).

>  sound/pci/ac97/ac97_patch.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/sound/pci/ac97/ac97_patch.c
> ===================================================================
> --- linux-2.6.orig/sound/pci/ac97/ac97_patch.c	2008-05-26 12:19:23.000000000 +0200
> +++ linux-2.6/sound/pci/ac97/ac97_patch.c	2008-05-27 13:23:11.000000000 +0200
> @@ -669,6 +669,7 @@
>  AC97_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
>  AC97_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
>  
> +AC97_SINGLE("Master Left Inv Switch", AC97_MASTER, 6, 1, 0),
>  AC97_SINGLE("Master ZC Switch", AC97_MASTER, 7, 1, 0),
>  AC97_SINGLE("Headphone ZC Switch", AC97_HEADPHONE, 7, 1, 0),
>  AC97_SINGLE("Mono ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
