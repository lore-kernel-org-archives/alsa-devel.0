From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Date: Mon, 21 Jan 2019 09:23:35 -0600
Message-ID: <20190121152335.GA12284@bogus>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus>
 <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Viorel Suman <viorel.suman@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "viorel.suman@gmail.com" <viorel.suman@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "perex@perex.cz" <perex@perex.cz>, alsa-
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 11:46:42AM -0800, Nicolin Chen wrote:
> On Fri, Jan 18, 2019 at 01:16:24PM +0000, Viorel Suman wrote:
> > > > 1. Moved "dais" node from machine driver DTS node to device driver
> > > > DTS node
> > > >   as suggested by Rob.
> > > That was not what I suggested. You still have a virtual node which
> > > looks to me to be unnecessary.
> > 
> > To me removing virtual node implies that AUDMIX machine driver (imx-
> > audmix.c + virtual node) shall be removed and machine driver code
> > merged into device driver (fsl_audmix.c + device node) - please let me
> > know if my understanding is wrong.
> 
> We could use a non-DT configuration right? From the driver logic,
> DT just registers a device corresponding to the machine driver so
> that it can probe(). We could register one in fsl_audmix instead.
> Please refer to how fsl_ssi registers the sound card device. The
> machine driver can get audmix_np from the parent device pointer,
> and I think that's all you need.

Yes.

> Or maybe someone else would provide a better way. But it'd work.

Or the machine driver could create the audmix device. That probably 
makes less sense, but either way there doesn't have to be a 1-1 
correspondence of DT nodes and (platform) devices.

I'm not an ASoC expert, but why can't the machine driver just control 
the audmix directly (with DAIs as separate drivers)? Is the audmix ever 
going to a be a component for a different machine driver?

Rob
