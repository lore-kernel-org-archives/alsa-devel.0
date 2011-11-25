From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 5/8] ASoC: Convert omap directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:18:34 +0200
Message-ID: <4ECF4F5A.9000408@bitmer.com>
References: <1322186745.8878.1.camel@phoenix> <1322187136.8878.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id E165B243E4
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 09:18:48 +0100 (CET)
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
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jorge Candelaria <jorge.candelaria@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/25/2011 04:12 AM, Axel Lin wrote:
> Factor out some boilerplate code.
>
> Signed-off-by: Axel Lin<axel.lin@gmail.com>
> ---
>   sound/soc/omap/omap-hdmi.c       |   12 +-----------
>   sound/soc/omap/omap-mcbsp.c      |   12 +-----------
>   sound/soc/omap/omap-mcpdm.c      |   12 +-----------
>   sound/soc/omap/omap-pcm.c        |   12 +-----------
>   sound/soc/omap/omap4-hdmi-card.c |   12 +-----------
>   5 files changed, 5 insertions(+), 55 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
