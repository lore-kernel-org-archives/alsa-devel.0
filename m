From: Sergey Lapin <slapin@ossfans.org>
Subject: Re: [PATCH] AFEB9260 ASoC driver
Date: Fri, 8 May 2009 18:39:15 +0400
Message-ID: <20090508143915.GA21623@build.ossfans.org>
References: <1241702685-18877-1-git-send-email-slapin@ossfans.org>
	<20090507154611.GK27897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (build.ossfans.org [67.223.233.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C67F1038F6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 16:39:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090507154611.GK27897@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 04:46:11PM +0100, Mark Brown wrote:
> On Thu, May 07, 2009 at 05:24:45PM +0400, Sergey Lapin wrote:
> > ASoC driver for AT91SAM9260-based AFEB9260 board
> 
> This looks good - there's some issues below but they're all pretty
> nitpicky.
> 
> >  static struct i2c_board_info __initdata afeb9260_i2c_devices[] = {
> >  	{
> > +		I2C_BOARD_INFO("tlv320aic23", 0x1a),
> > +	}, {
> 
> Push this separately via arch/arm - there's no build time dependency
> here and it'll avoid any merge issues.
Ok, will submit this separately.

> > +static void __exit afeb9260_soc_exit(void)
> > +{
> > +	platform_device_unregister(afeb9260_snd_device);
> > +}
> 
> Do you want to reverse your requst of the SSC port here?
What would you suggest alternatively?

All the best,
S.
