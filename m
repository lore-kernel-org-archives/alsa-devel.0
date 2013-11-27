From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv1] ASoC: SGTL5000: Fix kernel failed while getting
 regulator consumers
Date: Wed, 27 Nov 2013 08:13:03 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828CE2A8@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1385459713-6778-1-git-send-email-Li.Xiubo@freescale.com>
 <20131126134411.GQ14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131126134411.GQ14725@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, Fabio Estevam <Fabio.Estevam@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "oskar@scara.com" <oskar@scara.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> > +static int sgtl5000_external_vddd_used(struct snd_soc_codec *codec)
> > +{
> > +	struct regulator *consumer;
> > +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	consumer = regulator_get(codec->dev, sgtl5000-
> >supplies[VDDD].supply);
> > +	if (IS_ERR(consumer)) {
> > +		return 0;
> > +	}
> > +	regulator_put(consumer);
> > +
> > +	return 1;
> > +}
> 
> This is going to fail to do what you expect if a dummy regulator is
> substituted which it will almost all of the time when the supply is
> genuinely absent.  It's also going to interact poorly with probe
> deferral.
> 

There is one dependency patch: "regulator: core: Provide a dummy regulator with full constraints".

>From the dependency patch, we can see that using regulator_get_optional() instead can resovle the problem you descripted above.

When or will this dependency patch be merged into the -next tree ?



> I'd expect to see a commit description that describes how the driver
> currently tries to handle this, why it doesn't work and how the patch
> fixes it.  

The SGTL5000 requires 2 external power supplies: VDDA and VDDIO. An optional third external power supply VDDD may be provided externally to achieve lower power.If an external supply is not used for VDDD, the SGTL5000 driver will register it's own non-DT regulator device, and then provides the VDDD supply consumer, and now there will be two register devices exist, non-DT regulator for VDDD and DT regulator for VDDIO, VDDA.   


		
+++++++++++++++++++
+			+------------|3.3V VDDIO
+			+
+  SGTL5000	codec	+---X   VDDD
+			+
+			+------------|3.3V VDDA
+++++++++++++++++++
		


If an external supply is not used for VDDD, in the DT file, only "VDDA-supply" and "VDDIO-supply" properties will be presented. This caused the following kernel failed while trying to get the external VDDD regulator consumer before trying to register it's own regulator device. 

sgtl5000 0-000a: Failed to get supply 'VDDD': -19

While if an external supply is used for VDDD, in the DT file, all the three "VDDA-supply", "VDDIO-supply" and "VDDD-supply" properties can absent, by just using the dummy regulator. 

IMO, the failed log will confuse most people(especially for those not familiar with the SGTL5000 driver) that why getting the 'VDDD' supply failed but it still works? or is there something wrong with it ? ,etc.


Yes, this is a buggy patch, and I will revise it later.


--
Best Regards,
