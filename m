From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH V6] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Sun, 13 Mar 2016 09:53:50 +0100
Message-ID: <20160313085346.GA8896@panicking>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
 <20160222031944.GT18327@sirena.org.uk>
 <20160311225937.GA27257@panicking>
 <20160311230930.GB27257@panicking>
 <20160311232856.GC27257@panicking>
 <20160312055317.GT3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160312055317.GT3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 12, 2016 at 12:53:17PM +0700, Mark Brown wrote:
> On Sat, Mar 12, 2016 at 12:29:00AM +0100, Michael Trimarchi wrote:
> 
> > diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
> > index 4118106..609f07f 100644
> > --- a/sound/soc/codecs/pcm179x-i2c.c
> > +++ b/sound/soc/codecs/pcm179x-i2c.c
> > @@ -44,12 +44,6 @@ static int pcm179x_i2c_remove(struct i2c_client *client)
> >  	return pcm179x_common_exit(&client->dev);
> >  }
> >  
> > -static const struct of_device_id pcm179x_of_match[] = {
> > -	{ .compatible = "ti,pcm1792a", },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> > -
> 
> One effect of moving this out of the I2C driver is to break module
> autoloading: currently modutils does not pay attention to the reference
> from the driver structure to the ID table but instead just looks at the
> MODULE_DEVICE_TABLE.  This is a problem with some existing devices but
> we shouldn't introduce new instances.
> 
> I don't actually know if MODULE_DEVICE_TABLE can reference an object in
> a different file off the top of my head, though a brief test suggests it
> has issues.
> 
Does this approch can work?

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 609f07f..6bed54f 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -49,6 +49,7 @@ static const struct i2c_device_id pcm179x_i2c_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcm179x_i2c_ids);
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 
 static struct i2c_driver pcm179x_i2c_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
index 6ae0e4d..556c875 100644
--- a/sound/soc/codecs/pcm179x-spi.c
+++ b/sound/soc/codecs/pcm179x-spi.c
@@ -48,6 +48,7 @@ static const struct spi_device_id pcm179x_spi_ids[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, pcm179x_spi_ids);
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 
 static struct spi_driver pcm179x_spi_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index fb01822..a34af5b 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -255,7 +255,6 @@ const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1796", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 EXPORT_SYMBOL_GPL(pcm179x_of_match);
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap)
> > +static int pcm179x_startup(struct snd_pcm_substream *substream,
> > +			    struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> > +	u64 formats = PCM1792A_FORMATS;
> > +
> > +	switch (priv->codec_model) {
> > +	case PCM1795:
> > +		formats = PCM1795_FORMATS;
> > +		break;
> 
> It would be more data driven to just register a different DAI structure
> for the 1795.  Both approaches work, it's just a little nicer to avoid
> code where possible.

Yes I know but my idea was exactly to not create special DAI because
technically they are the same code with diffferent constraints. This even
give an other example of the usage of the API.

Michael


-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
