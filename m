From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - Add more support for Dell systems.
Date: Mon, 20 Aug 2007 06:56:52 -0700
Message-ID: <1187618212.4189.183.camel@razman.gruemaster.com>
References: <1187553279.4189.145.camel@razman.gruemaster.com>
	<s5htzqumsq8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DEC6103833
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 15:56:55 +0200 (CEST)
In-Reply-To: <s5htzqumsq8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

That's hard to tell.  I have two different Windows INI files for the
same system with different pin configs.  This is from the newer INI
file.  The difference is the reason I created a new model.

Tobin

On Mon, 2007-08-20 at 11:59 +0200, Takashi Iwai wrote:

> At Sun, 19 Aug 2007 12:54:39 -0700,
> Tobin Davis wrote:
> > 
> > This patch adds support for more Dell systems with Sigmatel/IDT codecs.
> > 
> > Signed off by Tobin Davis <tdavis@dsl-only.net>                              
> 
> Hm, the pin config looks different from the patch in ALSA bug#3319.
> 
> 	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3319
> 
> Which one is correct?
> 
> 
> Takashi
> 
> > 
> > [2 Dell.patch <text/x-patch; UTF-8 (7bit)>]
> > diff -r d6314f13dcc7 pci/hda/patch_sigmatel.c
> > --- a/pci/hda/patch_sigmatel.c	Fri Aug 17 09:17:36 2007 +0200
> > +++ b/pci/hda/patch_sigmatel.c	Sun Aug 19 09:53:07 2007 -0700
> > @@ -39,6 +39,7 @@
> >  
> >  enum {
> >  	STAC_REF,
> > +	STAC_XPS,
> >  	STAC_9200_MODELS
> >  };
> >  
> > @@ -63,6 +64,7 @@ enum {
> >  	STAC_D945GTP3,
> >  	STAC_D945GTP5,
> >  	STAC_922X_DELL,
> > +	STAC_922X_DELL2,
> >  	STAC_INTEL_MAC_V1,
> >  	STAC_INTEL_MAC_V2,
> >  	STAC_INTEL_MAC_V3,
> > @@ -456,12 +458,19 @@ static unsigned int ref9200_pin_configs[
> >  	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
> >  };
> >  
> > +static unsigned int xps9200_pin_configs[8] = {
> > +	0x40c003fc, 0x0144131f, 0x04a11020, 0x90170310,
> > +	0x40f000fa, 0x0421121f, 0x90170310, 0x408003fb,
> > +};
> > +
> >  static unsigned int *stac9200_brd_tbl[STAC_9200_MODELS] = {
> >  	[STAC_REF] = ref9200_pin_configs,
> > +	[STAC_XPS] = xps9200_pin_configs,
> >  };
> >  
> >  static const char *stac9200_models[STAC_9200_MODELS] = {
> >  	[STAC_REF] = "ref",
> > +	[STAC_XPS] = "xps",
> >  };
> >  
> >  static struct snd_pci_quirk stac9200_cfg_tbl[] = {
> > @@ -480,9 +489,9 @@ static struct snd_pci_quirk stac9200_cfg
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cd,
> >  		      "Dell Inspiron E1705/9400", STAC_REF),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01ce,
> > -		      "Dell XPS M1710", STAC_REF),
> > +		      "Dell XPS M1710", STAC_XPS),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cf,
> > -		      "Dell Precision M90", STAC_REF),
> > +		      "Dell Precision M90", STAC_XPS),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d6,
> >  		      "unknown Dell", STAC_REF),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d8,
> > @@ -596,11 +605,18 @@ static unsigned int stac922x_dell_pin_co
> >  	0x50a003f3, 0x405003f4
> >  };
> >  
> > +static unsigned int stac922x_dell2_pin_configs[10] = {
> > +	0x02211230, 0x01a1902e, 0x01111212, 0x01114210,
> > +	0x02a11021, 0x01116211, 0x404003f0, 0x40c003f1,
> > +	0x01813120, 0x400003f2
> > +};
> > +
> >  static unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
> >  	[STAC_D945_REF] = ref922x_pin_configs,
> >  	[STAC_D945GTP3] = d945gtp3_pin_configs,
> >  	[STAC_D945GTP5] = d945gtp5_pin_configs,
> >  	[STAC_922X_DELL] = stac922x_dell_pin_configs,
> > +	[STAC_922X_DELL2] = stac922x_dell2_pin_configs,
> >  	[STAC_INTEL_MAC_V1] = intel_mac_v1_pin_configs,
> >  	[STAC_INTEL_MAC_V2] = intel_mac_v2_pin_configs,
> >  	[STAC_INTEL_MAC_V3] = intel_mac_v3_pin_configs,
> > @@ -620,6 +636,7 @@ static const char *stac922x_models[STAC_
> >  	[STAC_D945GTP5]	= "5stack",
> >  	[STAC_D945GTP3]	= "3stack",
> >  	[STAC_922X_DELL] = "dell",
> > +	[STAC_922X_DELL2] = "dell2",
> >  	[STAC_INTEL_MAC_V1] = "intel-mac-v1",
> >  	[STAC_INTEL_MAC_V2] = "intel-mac-v2",
> >  	[STAC_INTEL_MAC_V3] = "intel-mac-v3",
> > @@ -697,6 +714,7 @@ static struct snd_pci_quirk stac922x_cfg
> >  		      "Mac Mini", STAC_INTEL_MAC_V3),
> >  	/* Dell */
> >  	SND_PCI_QUIRK(0x1028, 0x01d7, "Dell XPS M1210", STAC_922X_DELL),
> > +	SND_PCI_QUIRK(0x1028, 0x01d2, "Dell ", STAC_922X_DELL2),
> >  
> >  	{} /* terminator */
> >  };
> > diff -r d6314f13dcc7 Documentation/ALSA-Configuration.txt
> > --- a/Documentation/ALSA-Configuration.txt	Fri Aug 17 09:17:36 2007 +0200
> > +++ b/Documentation/ALSA-Configuration.txt	Sun Aug 19 12:51:56 2007 -0700
> > @@ -954,7 +954,11 @@ Prior to version 0.9.0rc4 options had a 
> >  			can be adjusted.  Appearing only when compiled with
> >  			$CONFIG_SND_DEBUG=y
> >  
> > -	STAC9200/9205/9254
> > +	STAC9200
> > +	  ref		Reference board
> > +	  XPS		Dell XPS Systems
> > +
> > +	STAC9205/9254
> >  	  ref		Reference board
> >  	  dell-m43	Dell Precision
> >  	  dell-m44	Dell Inspiron
