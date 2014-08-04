From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Mon, 04 Aug 2014 10:13:29 -0500
Message-ID: <53DFA319.6050900@tabi.org>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 4580226084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:13:32 +0200 (CEST)
In-Reply-To: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Falzoi <fabio.falzoi84@gmail.com>
Cc: alsa-devel@alsa-project.org, adamo.a60@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, mpa@pengutronix.de, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

On 08/04/2014 10:08 AM, Fabio Falzoi wrote:
> Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
> Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
> the pcm1792a codec.
> In CBM_CFS mode, when using a sample size of 16 bits, we cannot use
> CCSR_SSI_SCR_I2S_MODE_MASTER since we get a frame sync every 16 bits.
>
> Signed-off-by: Michael Trimarchi<michael@amarulasolutions.com>
> Signed-off-by: Fabio Falzoi<fabio.falzoi84@gmail.com>
> Tested-by: Angelo Adamo<adamo.a60@gmail.com>

Acked-by: Timur Tabi <timur@tabi.org>
