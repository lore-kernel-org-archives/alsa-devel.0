From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH v2 1/3] ep93xx i2s audio driver
Date: Wed, 26 May 2010 14:16:49 +0300
Message-ID: <201005261416.49362.peter.ujfalusi@nokia.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C1BD10381A
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 13:17:27 +0200 (CEST)
In-Reply-To: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "john.cooper@third-harmonic.com" <john.cooper@third-harmonic.com>, "chasedouglas@gmail.com" <chasedouglas@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, ext Ryan Mallon <ryan@bluewatersys.com>, "buytenh@wantstofly.org" <buytenh@wantstofly.org>, "r&d4@dave-tech.it" <r&d4@dave-tech.it>, "hartleys@visionengravers.com" <hartleys@visionengravers.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dhuggins@cs.cmu.edu" <dhuggins@cs.cmu.edu>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wednesday 26 May 2010 08:09:46 ext Ryan Mallon wrote:
> Add ep93xx i2s audio driver

..

> +static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info)
> +{
> +       int i;
> +
> +       /* Disable fifos */
> +       for (i =3D 0; i < 3; i++) {
> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN + (i * 4), 0);
> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN + (i * 4), 0);
> +       }
> +
> +       /* Disable i2s */
> +       ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
> +
> +       /* Disable clocks */
> +       clk_disable(info->lrclk);
> +       clk_disable(info->sclk);
> +       clk_disable(info->mclk);
> +}

I think this will break the other stream in duplex case, since you stop bot=
h =

FIFOs, and also disable the clocks.
Does the ep93xx supports duplex audio?

-- =

P=E9ter
