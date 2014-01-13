From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Mon, 13 Jan 2014 14:18:28 +0100
Message-ID: <20140113131828.GC12183@pengutronix.de>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
 <20140113123721.GV29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4ACDB2610D2
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 14:18:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140113123721.GV29039@sirena.org.uk>
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

On Mon, Jan 13, 2014 at 12:37:21PM +0000, Mark Brown wrote:
> On Sat, Jan 11, 2014 at 02:48:31PM +0100, Markus Pargmann wrote:
> > Add tlv320aic32x4 to the compatible list in the binding documentation.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Applied, thanks but you should really also add this compatible string to
> the driver.

Oh, I didn't notice that the 320aic3x driver actually has of_device_ids.
I was using the 320aic3x4 driver which only defines i2c_device_id but it
still matches with the compatible fields from my devicetree.

So perhaps it is better to drop this patch as it is no explicit
compatible in the driver?

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
