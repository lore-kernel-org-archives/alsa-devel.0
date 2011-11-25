From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/8] ASoC: Convert omap directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 15:03:51 +0200
Message-ID: <3097033.vXu4zUru3i@barack>
References: <1322186745.8878.1.camel@phoenix> <1322187136.8878.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 429F2103EE0
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 14:04:01 +0100 (CET)
In-Reply-To: <1322187136.8878.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jorge Candelaria <jorge.candelaria@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Axel Lin <axel.lin@gmail.com>, Misael@alsa-project.org, Lopez Cruz <misael.lopez@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Friday 25 November 2011 10:12:16 Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/omap/omap-hdmi.c       |   12 +-----------
>  sound/soc/omap/omap-mcbsp.c      |   12 +-----------
>  sound/soc/omap/omap-mcpdm.c      |   12 +-----------
>  sound/soc/omap/omap-pcm.c        |   12 +-----------
>  sound/soc/omap/omap4-hdmi-card.c |   12 +-----------
>  5 files changed, 5 insertions(+), 55 deletions(-)

I was just about to send the patch for this ;)
Thanks,

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
