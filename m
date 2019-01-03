From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Date: Thu, 3 Jan 2019 12:03:19 -0800
Message-ID: <20190103200319.GA2586@Asurada-Nvidia.nvidia.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Jan 03, 2019 at 03:56:46PM +0000, Viorel Suman wrote:
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> > 
> > Would it be better to align with that? It's your decision though.
> 
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to 
> rename it.

We had AUDMUX, so "AUDMIX" doesn't sound bad to me at all. The only
reason that we are discussing this is because RM uses more "AUDMIX"s
over "amix"s. I'd have chosen AUDMIX if I were you, yet not strongly
as I said. And it looks like Rob is asking you to use AUDMIX in DT
binding doc.

> > > +Device driver configuration example:
> > > +======================================
> > > +  amix: amix@59840000 {
> > > +    compatible = "fsl,imx8qm-amix";
> > > +    reg = <0x0 0x59840000 0x0 0x10000>;
> > > +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> > > +    clock-names = "ipg";
> > > +    power-domains = <&pd_amix>;
> > > +  };
> > From the description of DT and RM, I don't see how it connects to
> > SAIs.
> > 
> > Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be
> > better to have such information in the doc.
> 
> Please check chapter "16.1.2.2 Audio Mixer" in RM: it has two dedicated
> SAI interfaces, SAI4 and SAI5. Audio Mixer operates on bit clock of one
> of these interfaces.

OK. I am actually more wondering how you connect it with SAI on
the software level: for imx8qm, SAI4/5 are used, but later SoCs
might use other SAI blocks. So it might be necessary to indicate
the connections in DT.

> > > +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned
> > > int fmt)
> > > +{
> > > +       /* For playback the AMIX is slave, and for record is master
> > > */
> > > +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > > +       case SND_SOC_DAIFMT_CBM_CFM:
> > > +       case SND_SOC_DAIFMT_CBS_CFS:
> > So it's used either for playback or capture only, not both at same
> > time?
> 
> From IP functional perspective AMIX capture is the result of AMIX
> playback - AMIX output represents the resulting mixed audio stream
> routed to SAI4 RX signals (bit & frame clocks and data). So once we
> have playback on either SAI4 or SAI5 (or both) - we can capture the
> AMIX output on SAI4.

Ah, it sounds like a looping block then, receiving bclk from SAI4
-- slave, and routing the bclk back to SAI4 -- master; SAI4 works
at ASYNC mode?

> I guess it would be nice to send the machine driver as part of this
> patchset also - it defines two input SAI interfaces as frontends and
> AMIX - as backend. Userspace sees only two SAI interfaces exposed, both
> of them having playback enabled, and only SAI4 having capture enabled.

DPCM? So you are having the links in the sound DT nodes, i.e. the
machine driver?

Thanks
Nicolin
