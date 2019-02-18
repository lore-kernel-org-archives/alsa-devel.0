From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Date: Mon, 18 Feb 2019 09:03:45 +0100
Message-ID: <20190218080345.GA27289@kroah.com>
References: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
Sender: stable-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2019 at 02:08:52AM +0000, S.j. Wang wrote:
> Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changes in v2
> - add Fixes tag and cc stable kernel.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
