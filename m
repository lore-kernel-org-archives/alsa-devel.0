From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Thu, 14 Dec 2017 09:32:44 +0000
Message-ID: <20171214093244.udrjwgfvpxpc3jq7@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FD95267A07
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 10:32:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 12, 2017 at 03:31:16PM -0600, Steven Eckhoff wrote:
> On Tue, Dec 12, 2017 at 04:32:54PM +0000, Mark Brown wrote:
> > On Mon, Dec 11, 2017 at 01:54:25PM -0600, Steven Eckhoff wrote:
> > > +static int tscs42xx_probe(struct snd_soc_codec *codec)
> > > +{
> > > +	int i;
> > > +	int ret;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(r_inits); ++i) {
> > > +		ret = snd_soc_write(codec, r_inits[i].reg, r_inits[i].def);
> > > +		if (ret < 0) {
> > > +			dev_err(codec->dev,
> > > +				"Failed to write codec defaults (%d)\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > 
> > I'd expect the driver to just reset the CODEC (it appears to have that
> > feature) and the regmap.
> > 
> These init values were meant to be driver defaults that differed from
> the device defaults. In hindsight this was a bad idea. I am removing
> them in the next revision and will have the machine driver setup the
> codec appropriately.
> 

Not sure what you mean here but setting up CODEC registers
directly from the machine driver is probably not ideal. You
should probably be looking into regmap_register_patch this lets
you apply a bunch of register settings to the chip every time you
do a regmap_cache_sync. This is useful for situations like the
chip has terrible register defaults you want to correct.

Thanks,
Charles
