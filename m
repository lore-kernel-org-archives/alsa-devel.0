From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: soc-cache: Introduce raw
	bulk	write support
Date: Wed, 11 May 2011 10:20:29 +0100
Message-ID: <20110511092029.GA13823@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1300790223-13308-7-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110510211317.GB17589@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43CCB103919
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 11:20:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110510211317.GB17589@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2011 at 10:13:18PM +0100, Mark Brown wrote:
> On Tue, Mar 22, 2011 at 10:37:03AM +0000, Dimitris Papastamos wrote:
> 
> > +	switch (codec->control_type) {
> > +	case SND_SOC_I2C:
> > +		ret = i2c_master_send(codec->control_data, data, len);
> > +		break;
> > +	case SND_SOC_SPI:
> > +		ret = do_spi_write(codec->control_data, data, len);
> > +		break;
> 
> Hrm, I now realise that this doesn't actually do what I'd expect - it
> only writes out the provided data, there's no inclusion of the register
> address.  I'd been mislead by the fact that it is taking in the register
> address as an argument and an overly hasty review it seems.  That's a
> little too raw for me, we should be prefixing the data with the base
> register address.

Yes, I was going to send a patch for this because I need it for syncing the
block based rbtree cache.
