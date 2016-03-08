From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4] ASoC: imx-wm8958: add imx-wm8958
	machine driver
Date: Tue, 8 Mar 2016 10:04:36 -0300
Message-ID: <CAOMZO5AdwnV8RremJAmMBMeZXmm33pPFjjd=1rvHmpBMsDDxvQ@mail.gmail.com>
References: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 602982612D7
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 14:04:40 +0100 (CET)
Received: by mail-ig0-f182.google.com with SMTP id ir4so74031995igb.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2016 05:04:40 -0800 (PST)
In-Reply-To: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 8, 2016 at 3:27 AM, Zidan Wang <zidan.wang@freescale.com> wrote:

> --- /dev/null
> +++ b/sound/soc/fsl/imx-wm8958.c
...

> +#include <linux/mfd/wm8994/registers.h>
> +#include "../fsl/fsl_sai.h"

This include is not needed.
