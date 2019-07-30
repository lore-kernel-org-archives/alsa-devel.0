From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802 amplifier
Date: Tue, 30 Jul 2019 15:12:09 +0200
Message-ID: <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Thomas Preston <thomas.preston@codethink.co.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jerome Brunet <jbrunet@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Annaliese McDermond <nh6z@nh6z.net>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Patrick Glaser <pglaser@tesla.com>, Rob Duncan <rduncan@tesla.com>, Nate
List-Id: alsa-devel@alsa-project.org

Hi Charles,

sorry for jumping in..

On 19-07-30 13:27, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
> > Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> > Cc: Patrick Glaser <pglaser@tesla.com>
> > Cc: Rob Duncan <rduncan@tesla.com>
> > Cc: Nate Case <ncase@tesla.com>
> > ---
> >  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
> > new file mode 100644
> > index 000000000000..f80aaf4f1ba0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
> > @@ -0,0 +1,26 @@
> > +ST TDA7802 audio processor
> > +
> > +This device supports I2C only.
> > +
> > +Required properties:
> > +
> > +- compatible : "st,tda7802"
> > +- reg : the I2C address of the device
> > +- enable-supply : a regulator spec for the PLLen pin

Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
regulator for that.

Regards,
  Marco

> > +
> > +Optional properties:
> > +
> > +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
> > +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)
> 
> I wouldn't have expected the gains to be available as a device
> tree setting.
> 
> > +- st,diagnostic-mode-ch13 : diagnotic mode for channels 1 and 3
> > +                            values: "Speaker" (default), "Booster"
> > +- st,diagnostic-mode-ch24 : diagnotic mode for channels 2 and 4
> > +                            values: "Speaker" (default), "Booster"
> > +
> > +Example:
> > +
> > +amp: tda7802@6c {
> > +	compatible = "st,tda7802";
> > +	reg = <0x6c>;
> > +	enable-supply = <&amp_enable_reg>;
> > +};
> > -- 
> > 2.21.0
> > 
> 
> Thanks,
> Charles
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
