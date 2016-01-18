From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
Date: Mon, 18 Jan 2016 20:14:24 -0200
Message-ID: <CAOMZO5Dgcw-5hv4=H5LcJ2NVobz+4YW7Gu=Y8y88465CYLZ+=w@mail.gmail.com>
References: <569D3800.2040801@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569D3800.2040801@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 5:07 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> There is no guarantee that on fsl_ssi module load
> SSI registers will have their power-on-reset values.
>
> In fact, if the driver is reloaded the values in
> registers will be whatever they were set to previously.
>
> However, the cache needs to be fully populated at probe
> time to avoid non-atomic allocations during register
> access.
>
> Special case here is imx21-class SSI, since
> according to datasheet it don't have SACC{ST,EN,DIS}
> regs.
>
> This fixes hard lockup on fsl_ssi module reload,
> at least in AC'97 mode.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
