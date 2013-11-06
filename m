From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 12/13] ASoC: ux500_pcm: Differentiate between pdata and DT initialisation
Date: Wed, 6 Nov 2013 12:51:37 +0100
Message-ID: <CACRpkdbsMhvKRB1BJBWO21BnDag1L9RkxskiVsck52piuGmnmw@mail.gmail.com>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
	<1383732985-18928-13-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383732985-18928-13-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible request channel call
> back and, due to the work we laid down earlier in this patch-set, we
> can use core function calls to populate the DMA slave_config. We also
> require slightly different flags to inform the core that we 'are'
> booting with DT.
>
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
