From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] DMA fixes for ux500 ASoC driver
Date: Wed, 12 Jun 2013 11:51:33 +0200
Message-ID: <CACRpkdYpDoMCikZyQhDgnZA7QgvrTirBAKamaxBpNoT+8m=+yA@mail.gmail.com>
References: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 12, 2013 at 9:57 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> The DMA driver used on ux500 has been recently reworked to make it
> device-tree capable, but the rework required to drop some "features",
> such as opportunistic channel allocation and hardcoded addresses, that
> the ASoC driver was relying upon.
>
> This series fixes the audio driver to make it work with the current
> dma40 implementation, and works fine even when booting with device-tree.

FWIW: all look good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
