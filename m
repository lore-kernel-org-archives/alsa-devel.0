From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Date: Thu, 17 Jan 2019 14:24:58 -0800
Message-ID: <20190117222458.GG16918@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 02:22:18PM -0800, Nicolin Chen wrote:
> On Thu, Jan 17, 2019 at 12:46:25PM +0000, Viorel Suman wrote:
> > The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> > drivers and related DT bindings documentation.
> > 
> > Changes since V2:
> > 1. Moved "dais" node from machine driver DTS node to device driver DTS node
> >   as suggested by Rob.
> 
> Yea, it makes a lot of sense. Otherwise, since the connection
> between IP blocks is fixed inside the SoC, the virtual sound
> node would need to be put in the soc-level dtsi, which sounds
> odd to me.
> 
> > Changes since V1:
> > 1. Original patch split into distinct patches for the device driver and
> >   DT binding documentation.
> > 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
> >   RM-compliant.
> > 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> > 4. Added machine driver and related DT binding documentation.
> > 
> > Viorel Suman (4):
> >   ASoC: fsl: Add Audio Mixer CPU DAI driver
> >   ASoC: add fsl_audmix DT binding documentation
> >   ASoC: fsl: Add Audio Mixer machine driver
> >   ASoC: add imx-audmix DT binding documentation
> 
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Oops. Just saw Rob's new reply. The drivers look good to me though.
