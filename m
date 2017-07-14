From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI assignments"
Date: Fri, 14 Jul 2017 15:36:57 +0200
Message-ID: <CACRpkdbOkxTstPdvUSMe3J+BF1ifnQoJNCf657U+UTHr=aBREQ@mail.gmail.com>
References: <20170712155530.17765-1-johan@kernel.org> <20170712155530.17765-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712155530.17765-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 12, 2017 at 5:55 PM, Johan Hovold <johan@kernel.org> wrote:

> This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
> assignments"), which seems to have been based on a misunderstanding and
> prevents the platform driver callbacks from being made (e.g. to
> preallocate DMA memory).
>
> The real culprit for the warnings about attempts to create duplicate
> procfs entries was commit 99b04f4c4051 ("ASoC: add Component level
> pcm_new/pcm_free" that broke PCM creation on systems that use more than
> one platform component.
>
> Fixes: f1013cdeeeb9 ("ASoC: ux500: drop platform DAI assignments")
> Cc: stable <stable@vger.kernel.org>     # 4.11
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

These static assignments should go away, but not for the wrong reason.
So this patch is fully in order given the source of the bug.

Yours,
Linus Walleij
