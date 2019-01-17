From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Date: Thu, 17 Jan 2019 10:18:04 -0600
Message-ID: <20190117161804.GA5760@bogus>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 12:46:25PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.
> 
> Changes since V2:
> 1. Moved "dais" node from machine driver DTS node to device driver DTS node
>   as suggested by Rob.

That was not what I suggested. You still have a virtual node which looks 
to me to be unnecessary.

> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (4):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
>   ASoC: add imx-audmix DT binding documentation
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
>  .../devicetree/bindings/sound/imx-audmix.txt       |  18 +
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 102 ++++
>  sound/soc/fsl/imx-audmix.c                         | 334 +++++++++++++
>  7 files changed, 1076 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
