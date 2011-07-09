From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP4: HDMI: Make stricter
	dependency on OMAP2_DSS
Date: Sat, 9 Jul 2011 10:11:23 +0900
Message-ID: <20110709011122.GD18860@opensource.wolfsonmicro.com>
References: <1310071134-11625-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2560B24548
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 11:45:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310071134-11625-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, tomi.valkeinen@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 07, 2011 at 03:38:54PM -0500, Ricardo Neri wrote:
> When building DSS HDMI driver with audio support, there is dependency
> on SND_SOC to register the ASoC audio codec. Also, SND_OMAP_SOC_OMAP4_HDMI
> has dependency on OMAP2_DSS. Then, to avoid build breakages,
> SND_OMAP_SOC_OMAP4_HDMI, is restricted to be available only when
> OMAP2_DSS AND SND_SOC have the same build type.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
