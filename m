From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in
 probe
Date: Tue, 9 Apr 2019 21:30:26 -0700
Message-ID: <20190410043025.GE3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lis>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 09, 2019 at 11:27:42AM +0000, Viorel Suman wrote:
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
