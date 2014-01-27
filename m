From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 6/6] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 27 Jan 2014 10:15:05 -0200
Message-ID: <CAOMZO5B34KpVZ3PFkWd2xctEqTBFSSvP3GkcmcaogzgLHWdEgQ@mail.gmail.com>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 58F0F2625FD
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:15:06 +0100 (CET)
Received: by mail-vc0-f169.google.com with SMTP id hq11so3404712vcb.28
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 04:15:05 -0800 (PST)
In-Reply-To: <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 27, 2014 at 10:03 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> +static int aic32x4_i2c_setup_regulators(struct device *dev,
> +               struct aic32x4_priv *aic32x4)
> +{
> +       int ret;
> +
> +       aic32x4->supply_ldo = devm_regulator_get_optional(dev, "ldoin");
> +       aic32x4->supply_iov = devm_regulator_get_optional(dev, "iov");
> +       aic32x4->supply_dv = devm_regulator_get_optional(dev, "dv");
> +       aic32x4->supply_av = devm_regulator_get_optional(dev, "av");
> +
> +       if (!IS_ERR(aic32x4->supply_ldo)) {
> +               ret = regulator_enable(aic32x4->supply_ldo);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (!IS_ERR(aic32x4->supply_iov)) {
> +               ret = regulator_enable(aic32x4->supply_iov);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (!IS_ERR(aic32x4->supply_dv)) {
> +               ret = regulator_enable(aic32x4->supply_dv);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (!IS_ERR(aic32x4->supply_av)) {
> +               ret = regulator_enable(aic32x4->supply_av);
> +               if (ret)
> +                       return ret;

Using regulator_bulk_enable() would simplify the code.

Regards,

Fabio Estevam
