From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: add fsl_audmix DT binding documentation
Date: Fri, 25 Jan 2019 17:49:19 -0800
Message-ID: <20190126014918.GA2617@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>, Rob Herring <robh+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 12:46:29PM +0000, Viorel Suman wrote:

> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.

Another small thing, that I just noticed, is this list. It forces
the first input source to be the output source without giving any
chance. I feel that we could have some flexibility here: one node
for two input sources, and one node for the output source.

Well, there is no critical problem with the current binding since
it follows the SoC design. Yet I doubt if this routing logic will
never break.

Any suggestion, Rob?
