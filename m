From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/19] ASoC: wm8510: Convert to
 module_i2c/spi_driver()
Date: Thu, 17 Nov 2016 09:33:33 +0000
Message-ID: <20161117093333.GZ1575@localhost.localdomain>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87twb98h2o.wl%kuninori.morimoto.gx@renesas.com>
 <20161116094454.GV1575@localhost.localdomain>
 <87h9776jxx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id ECECE266801
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 10:33:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87h9776jxx.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 17, 2016 at 12:16:06AM +0000, Kuninori Morimoto wrote:
> 
> Hi Charles
> 
> Thank you for your feedback
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Let's use module_i2c/spi_driver()
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > 
> > Yeah I think from here on in the series these have the I2C/SPI
> > issues Lars mentions.
> 
> I can create xx-i2c.c xx-spi.c as Lars mentioned.
> Do you think it is nice ? or do nothing for these drivers is nice ?
> If it is "nice to have", I can try it, please let me know.
> 
> I will fixup I2C side patches only, and post these as v2 patch.
> I will post I2C/SPI patches if these were "nice to have"

Creating the seperate I2C/SPI files would indeed be the best way
to go, however, personally I would be inclined to leave them
alone. They are mostly legacy parts, I won't have hardware to
test almost all of them and there is no pressing need to update
them at this time.

Thanks,
Charles
