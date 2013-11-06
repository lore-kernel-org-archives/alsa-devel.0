From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/13] ASoC: Ux500: Match platform by device node when
 booting Device Tree
Date: Wed, 6 Nov 2013 12:47:20 +0100
Message-ID: <CACRpkdYCipiPM0YcosXV7t57LWnpeHRs=95bAs-v=wc-QRs00g@mail.gmail.com>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
	<1383732985-18928-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383732985-18928-10-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> We're getting closer to fully enabling the Ux500 ASoC driver for Device
> Tree. When we switch over from using AUXDATA we'll need to match platform
> by only Device Tree nodes. In this patch we NULL out the platform_name,
> and supply nodes for each platform device.
>
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
