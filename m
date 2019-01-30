From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Date: Wed, 30 Jan 2019 10:32:18 -0600
Message-ID: <20190130163218.GA16270@bogus>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
 <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
 <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Viorel Suman <viorel.suman@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2019 at 11:43:16AM -0800, Nicolin Chen wrote:
> On Tue, Jan 22, 2019 at 11:14:27AM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for NXP Audio Mixer
> > CPU DAI driver.
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > new file mode 100644
> > index 0000000..45f807e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > @@ -0,0 +1,54 @@
> > +NXP Audio Mixer (AUDMIX).
> > +
> > +The Audio Mixer is a on-chip functional module that allows mixing of two
> > +audio streams into a single audio stream. Audio Mixer has two input serial
> > +audio interfaces. These are driven by two Synchronous Audio interface
> > +modules (SAI). Each input serial interface carries 8 audio channels in its
> > +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> > +from two interfaces into a single sample. Before mixing, audio samples of
> > +two inputs can be attenuated based on configuration. The output of the
> > +Audio Mixer is also a serial audio interface. Like input interfaces it has
> > +the same TDM frame format. This output is used to drive the serial DAC TDM
> > +interface of audio codec and also sent to the external pins along with the
> > +receive path of normal audio SAI module for readback by the CPU.
> > +
> > +The output of Audio Mixer can be selected from any of the three streams
> > + - serial audio input 1
> > + - serial audio input 2
> > + - mixed audio
> > +
> > +Mixing operation is independent of audio sample rate but the two audio
> > +input streams must have same audio sample rate with same number of channels
> > +in TDM frame to be eligible for mixing.
> > +
> > +Device driver required properties:
> > +=================================
> > +  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> > +
> > +  - reg			: Offset and length of the register set for the device.
> > +
> > +  - clocks		: Must contain an entry for each entry in clock-names.
> > +
> > +  - clock-names		: Must include the "ipg" for register access.
> > +
> > +  - power-domains	: Must contain the phandle to AUDMIX power domain node
> > +
> > +  - dais		: Must contain a list of phandles to AUDMIX connected
> > +			  DAIs. The current implementation requires two phandles
> > +			  to SAI interfaces to be provided, the first SAI in the
> > +			  list being used to route the AUDMIX output.
> > +
> > +  - model		: Must contain machine driver name which will configure
> > +			  and instantiate the appropriate audio card.
> 
> I don't feel this is necessary for DT node. The driver should be
> able to figure out a proper name for the machine driver: it could
> use the compatible string to get "imx8qm-audmix" as the name like
> fsl_ssi; Or it could have built-in "imx-audmix" of_device_id data
> corresponding to "fsl,imx8qm-audmix" compatible string -- for any
> non-imx compatible in the future, use something else.

I tend to agree, but either way:

Rob Herring <robh@kernel.org>
