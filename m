From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 2/6] OMAP4: Add device for HDMI OMAP4 audio
 for ASoC machine driver
Date: Thu, 05 May 2011 14:26:31 -0500
Message-ID: <1304623591.1900.34.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-3-git-send-email-ricardo.neri@ti.com>
	<20110505081839.GE11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id EC7A3243B7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 21:26:25 +0200 (CEST)
In-Reply-To: <20110505081839.GE11744@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, den 05.05.2011, 03:18 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:21:49AM -0500, Ricardo Neri wrote:
> 
> > +#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> > +	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> 
> Similar comment here...
I wanted to build the omap4-hdmi-audio device only if the HDMI audio
option is selected in menuconfig.
