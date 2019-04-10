From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 3/4] ASoC: imx-audmix: fix object reference leaks in probe
Date: Wed, 10 Apr 2019 11:26:46 -0300
Message-ID: <CAOMZO5AM0OOTc0SKFMDGWnDpAWrM0-1cyeQjYb-7ZzX558hK=g@mail.gmail.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com> <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>"linuxppc-dev@lists.ozlabs.org" <linux>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 8:06 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Please provide a Fixes tag.
