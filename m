From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Wed, 15 Jan 2014 09:57:56 +0100
Message-ID: <20140115085756.GG12183@pengutronix.de>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
 <20140113123721.GV29039@sirena.org.uk>
 <20140113131828.GC12183@pengutronix.de>
 <20140113154457.GY29039@sirena.org.uk>
 <20140114085019.GD12183@pengutronix.de>
 <20140114121426.GB15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 955192650DB
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2014 09:58:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140114121426.GB15567@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 14, 2014 at 12:14:26PM +0000, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 09:50:19AM +0100, Markus Pargmann wrote:
> > On Mon, Jan 13, 2014 at 03:44:57PM +0000, Mark Brown wrote:
> 
> > > Or you could add the compatible string to the driver as I suggested...
> > > I don't see any reason for the device not to have a compatible string?
> 
> > The codec is not working here at the moment, so I can't test if the
> > aic3204 codec is really working with the aic3x driver.
> 
> Why would you add the compatible string to the aic3x driver, there is a
> separate driver for this chip?

Right, was confused a little. I will add proper bindings for aic32x4 as
soon as I have everything up and running.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
