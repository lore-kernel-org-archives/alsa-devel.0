From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Date: Wed, 16 Jan 2019 10:21:52 +0200
Message-ID: <CAEnQRZBn7nM-KrGSvnzPWuU=a+jyRxfEKhZSsDD4wTqr6spkwg@mail.gmail.com>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com> <20190115205755.GA4022@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115205755.GA4022@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Viorel Suman <viorel.suman@nxp.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2019 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for Audio Mixer
> > machine driver.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > new file mode 100644
> > index 0000000..6ac1230
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> > @@ -0,0 +1,24 @@
> > +NXP Audio Mixer (AUDMIX) machine driver.
> > +
> > +Required properties:
> > +===================================
> > +  - compatible               : Compatible list, contains "fsl,imx-audmix"
> > +
> > +  - model            : Short audio card description.
> > +
> > +  - dais             : Must contain a list of phandles to AUDMIX connected
> > +                       DAIs. The current implementation requires two phandles
> > +                       to SAI interfaces to be provided, the first SAI in the
> > +                       list being used to route the AUDMIX output.
> > +
> > +  - audmix-controller        : Must contain the phandle to the AUDMIX device node.
>
> I don't think you need 2 nodes for this as this one is just a virtual
> device. Just add the dais property to the audmix node.

Hi Rob,

Thanks for the suggestion. We want to understand better the reasoning
behind this.

Is it because dais are physically connected to AUDMIX node?

In ALSA we usually add all the components inside the
associated machine driver virtual node.

thanks,
Daniel.
