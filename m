From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 0/2] Add runtime PM for SAI digital audio interface
Date: Sat, 20 Apr 2019 22:42:15 -0700
Message-ID: <20190421054214.GA683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 20, 2019 at 03:59:03PM +0000, Daniel Baluta wrote:
> First patch uses system PM handlers to implement runtime PM. While
> the second patch moves clock handling from startup/shutdown to runtime
> PM handlers.
> 
>   ASoC: fsl: sai: Add support for runtime pm
>   ASoC: fsl: Move clock operation to PM runtime

Both patches should use the prefix:
ASoC: fsl_sai: Xxxxx yyyy

Thanks
