From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: mid-x86 add jack detect support
Date: Wed, 19 Jan 2011 18:54:03 +0000
Message-ID: <20110119185403.GF17150@opensource.wolfsonmicro.com>
References: <1295441296-32180-1-git-send-email-priya.harsha@intel.com>
	<20110119144138.GB16328@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A446301084470BBE1@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 653EB10384B
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:54:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A446301084470BBE1@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 10:18:04PM +0530, Koul, Vinod wrote:

> > Since this is a common pattern we should ideally have some utility code
> > which can take any table of ADC values in conjunction with any ADC and
> > use those to do detection.

> Yes the codec reads into the ADC to measure the micbias voltage.
> It has map where we know based on micbais present what kind of accessory maybe
> connected. Since this is entirely codec domain it should be in codec.
> Let me know if you disagree.

Well, the ADC is clearly part of the CODEC but the logic surrounding
walking through the table and coming up with jack statuses to report
based off it isn't, that's a generic thing which should probably be
sitting along with soc-jack.c (possibly in there, possibly as a separate
file).

> > > +static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
> > > +{
> > > +	int base_addr, chnl_addr;
> > > +	int value;
> > > +	static int channel_index;

> > The functions added in this header look like they'd be better placed in
> > the source file?

> Typically ADC should be a separate driver but we don't have that yet so
> though of adding these as helpers.
> When we get a proper adc driver we can replace this with code calling adc.

I'd suggest putting the bodies of the function into the main CODEC
driver for now.
