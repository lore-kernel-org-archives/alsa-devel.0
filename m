From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Tue, 14 Jan 2014 09:50:19 +0100
Message-ID: <20140114085019.GD12183@pengutronix.de>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
 <20140113123721.GV29039@sirena.org.uk>
 <20140113131828.GC12183@pengutronix.de>
 <20140113154457.GY29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 42563261609
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 09:50:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140113154457.GY29039@sirena.org.uk>
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

Hi,

On Mon, Jan 13, 2014 at 03:44:57PM +0000, Mark Brown wrote:
> On Mon, Jan 13, 2014 at 02:18:28PM +0100, Markus Pargmann wrote:
> > On Mon, Jan 13, 2014 at 12:37:21PM +0000, Mark Brown wrote:
> 
> > > Applied, thanks but you should really also add this compatible string to
> > > the driver.
> 
> > Oh, I didn't notice that the 320aic3x driver actually has of_device_ids.
> > I was using the 320aic3x4 driver which only defines i2c_device_id but it
> > still matches with the compatible fields from my devicetree.
> 
> > So perhaps it is better to drop this patch as it is no explicit
> > compatible in the driver?
> 
> Or you could add the compatible string to the driver as I suggested...
> I don't see any reason for the device not to have a compatible string?

The codec is not working here at the moment, so I can't test if the
aic3204 codec is really working with the aic3x driver.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
