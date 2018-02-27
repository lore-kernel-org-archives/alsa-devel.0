From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3] ASoC: imx-wm8962: Remove machine driver
Date: Mon, 26 Feb 2018 16:46:44 -0800
Message-ID: <20180227004643.GA6370@Asurada-Nvidia>
References: <1519672923-26886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AAE5F266F88
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 01:46:37 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id g12so6870797pgs.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 16:46:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1519672923-26886-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, broonie@kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, leonard.crestez@nxp.com, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 04:22:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> fsl-asoc-card machine driver also handles wm8962, so there is
> really no need for keeping the dedicated imx-wm8962 driver anymore.
> 
> Remove the imx-wm8962 machine driver.
> 
> Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Did you verify it on a certain hardware? If so, I may give my Ack
directly as it looks good to me. Otherwise, I would need to test.

> ---
> Changes since v2:
> - Also remove the dt-bindings
> 
>  .../devicetree/bindings/sound/imx-audio-wm8962.txt |  53 ----

And could you please also remove line 31 at
Documentation/devicetree/bindings/sound/fsl-asoc-card.txt ?

Since this imx-audio-wm8962.txt will be removed, that line could
be removed too. Thanks.
