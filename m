From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Convert wm8750 to a new-style i2c
 driver (testers wanted)
Date: Tue, 26 Aug 2008 21:24:00 +0200
Message-ID: <20080826212400.10ee4184@hyperion.delvare>
References: <20080826180656.44f43073@hyperion.delvare>
	<20080826190501.GB3461@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C453B2438D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 21:24:06 +0200 (CEST)
In-Reply-To: <20080826190501.GB3461@sirena.org.uk>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Aug 2008 20:05:03 +0100, Mark Brown wrote:
> On Tue, Aug 26, 2008 at 06:06:56PM +0200, Jean Delvare wrote:
> > Convert the wm8750 codec driver to the new (standard) device driver
> > binding model.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> for the wm8750 driver.  I'm pretty confident the spitz change is correct
> too but don't have hardware to actually test.
> 
> >  /* spitz audio private data */
> >  static struct wm8750_setup_data spitz_wm8750_setup = {
> > +	.i2c_bus = 0,
> >  	.i2c_address = 0x1b,
> >  };
> 
> The assignment to 0 is redundant but it's useful for documentation.

I agree. Usually I am the first one to yell at people who explicitly
initialize struct members to 0, but in this specific case I think it is
a good idea to make sure that other developers notice the change.

-- 
Jean Delvare
