From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 1/4] ASoC: simple-card: add simple audio card widgets
 support
Date: Thu, 9 Jan 2014 07:43:39 +0000
Message-ID: <978e195be6ae493584be24c6821a80ad@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
 <20140108175940.GQ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140108175940.GQ31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > For many audio cards there need to add some off-CODEC widgets, and this
> > is hard to be supported by dts only, because maybe some widgets need one
> > or more call backs, such as wevent.
> 
> The big question here would be why these widgets need to be added
>

For instance, from the SGTL5000 codec Spec:
----
The analog input block contains a stereo line input and a microphone input
with mic bias. Either input can be routed to the ADC. The line input can also
be configured to bypass the CODEC and be routed directly to the headphone
output.
----
And in the SGTL5000 codec driver there is one "Mic Bias" widget, and this
should be routed to one off-CODEC widget, like "Mic Jack"(the microphone input).


> the
> default thing is that all inputs and outputs are enabled so it can't be
> that and as you say callbacks are going to need to be added.
> 

Some drivers may need like this:
----
         SND_SOC_DAPM_PGA_E("Output Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
                         XXX_output_amp_event, SND_SOC_DAPM_PRE_PMU |
                         SND_SOC_DAPM_POST_PMD),
----
 ?



> If this is used then it probably makes sense for the card to set the
> fully routed flag since one possible use is to disable unconnected pins
> on the CODEC.
> 
> > +- simple-sudio-card,widgets		: The name of the audio card off-CODEC
> widgets.
> 
> simple-audio-card.  This also needs more documentation about what is
> supposed to be filled in here.
> 

Yes, if needed.

> > +void
> > +asoc_simple_card_widgets_unregister(struct asoc_simple_card_widgets *comp)
> 
> We always use snd_soc.
> 
> One interesting thing here is that this is done separately to the card
> itself.  Is there any actual dependency on the simple card, could this
> be made into a generic library that any machine driver could use?  I can
> see other machines being able to make use of this.

No, has no dependency on the simple card.




Thanks,

--
Best Regards,
Xiubo
