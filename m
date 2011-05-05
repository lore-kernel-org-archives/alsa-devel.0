From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Thu, 05 May 2011 14:35:05 -0500
Message-ID: <1304624105.1900.41.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 06216243E0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 21:35:01 +0200 (CEST)
In-Reply-To: <20110505082253.GF11744@opensource.wolfsonmicro.com>
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

Hi Mark,

Am Donnerstag, den 05.05.2011, 03:22 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:21:51AM -0500, Ricardo Neri wrote:
> 
> > +static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
> > +				  struct snd_soc_dai *dai)
> > +{
> 
> > +	if (ovl->manager->device->state != OMAP_DSS_DISPLAY_ACTIVE) {
> > +		pr_err("HDMI display is not active!\n");
> > +		return -EIO;
> > +	}
> 
> dev_er().  Also, why are you checking this, and are you checking it too
> early?

I will replace with dev_err(). I need to check if HDMI display is active
because the HDMI DSS driver is in charge of powering on/off the HDMI IP.
Audio can play only if the HDMI IP is on. I don't have a .trigger
function in my DAI so I thought it was OK to perform the check
at .startup. Do you think I should create a .trigger function and
perform the check from there?
> 
> > +MODULE_AUTHOR("Jorge Candelaria <jorge.candelaria@gmail.com>");
> > +MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
> > +MODULE_DESCRIPTION("OMAP HDMI SoC Interface");
> > +MODULE_LICENSE("GPL");
> 
> MODULE_ALIAS().
I will add.
