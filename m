From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 2/4] ASoC: tlv320aic32x4: DT support
Date: Mon, 20 Jan 2014 13:58:41 +0100
Message-ID: <20140120125841.GA6114@pengutronix.de>
References: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
 <1390219558-25341-3-git-send-email-mpa@pengutronix.de>
 <1390222497.5871.2.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B4E4F261A10
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:58:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390222497.5871.2.camel@pizza.hi.pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 20, 2014 at 01:54:57PM +0100, Philipp Zabel wrote:
> Am Montag, den 20.01.2014, 13:05 +0100 schrieb Markus Pargmann:
> > Add DT support for this codec. The bindings differ a bit from the aic3x
> > codec bindings, so I created a new binding documentation.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../devicetree/bindings/sound/tlv320aic32x4.txt    | 18 ++++++++++++++++
> >  sound/soc/codecs/tlv320aic32x4.c                   | 25 ++++++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> > new file mode 100644
> > index 0000000..cff06ea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> > @@ -0,0 +1,18 @@
> > +Texas Instruments - tlv320aic32x4 Codec module
> > +
> > +The tlv320aic32x4 serial control bus communicates through I2C protocols
> > +
> > +Required properties:
> > + - compatible: Should be "ti,tlv320aic32x4"
> > + - reg: I2C slave address
> > +
> > +Optional properties:
> > + - gpio-reset: Reset-GPIO phandle with args as described in gpio/gpio.txt
> 
> This should be "reset-gpios".

Thanks, I will fix it for v3.

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
