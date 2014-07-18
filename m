From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 0/2] ASoC: fsl_sai: Two bug fixes for fsl_sai driver
Date: Fri, 18 Jul 2014 02:38:06 +0000
Message-ID: <9e28b763e864442baccf0f45d975ef51@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405603108.git.nicoleotsuka@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@tabi.org" <timur@tabi.org>, "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Nicolin Chen [mailto:nicoleotsuka@gmail.com]
> Sent: Thursday, July 17, 2014 9:22 PM
> To: broonie@kernel.org
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; alsa-
> devel@alsa-project.org; timur@tabi.org; Xiubo Li-B47053; Wang Shengjiu-B02247;
> Chen Guangyu-B42378
> Subject: [PATCH 0/2] ASoC: fsl_sai: Two bug fixes for fsl_sai driver
> 
> Nicolin Chen (2):
>   ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
>   ASoC: fsl_sai: Fix incorrect register writing in fsl_sai_isr()
> 

Yes, they are all looks good to me.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Thanks,

BRs
Xiubo


>  sound/soc/fsl/fsl_sai.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --
> 1.8.4
