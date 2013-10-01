From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] ASoC: imx-sgtl5000: do not use devres
 on a foreign device
Date: Mon, 30 Sep 2013 17:41:55 -0700
Message-ID: <CAOesGMi5SmBq9bvRTgfeV0w=B1QcokGnVNM5vUqiBQ4JUYw2KQ@mail.gmail.com>
References: <1380115268-32118-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 132A026517B
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 02:41:56 +0200 (CEST)
Received: by mail-qa0-f46.google.com with SMTP id j7so2859092qaq.5
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 17:41:56 -0700 (PDT)
In-Reply-To: <1380115268-32118-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sachin Kamat <sachin.kamat@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Sep 25, 2013 at 6:21 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Changes since v1:
>  - Rebased onto asoc/for-next, adding back imx_sgtl5000_remove.

[...]

> +static int imx_sgtl5000_remove(struct platform_device *pdev)
> +{
> +       struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
> +
> +       clk_put(data->codec_clk);
> +
> +       return 0;
> +}
> +

This function is never referenced nor called from anywhere, so if you
want to add it back you've better add a reference to it as well. :)

For now it results in:

sound/soc/fsl/imx-sgtl5000.c:185:12: warning: 'imx_sgtl5000_remove'
defined but not used [-Wunused-function]


-Olof
