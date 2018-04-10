From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Fix divisor calculation
 failure at lower ratio
Date: Tue, 10 Apr 2018 12:17:47 -0300
Message-ID: <CAOMZO5AHDmpwZcgjrhQv_po9kcjJf0vXArrCEVqnOPcS7ci36Q@mail.gmail.com>
References: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Sun, Apr 8, 2018 at 8:57 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> When the desired ratio is less than 256, the savesub (tolerance)
> in the calculation would become 0. This will then fail the loop-
> search immediately without reporting any errors.
>
> But if the ratio is smaller enough, there is no need to calculate
> the tolerance because PM divisor alone is enough to get the ratio.
>
> So a simple fix could be just to set PM directly instead of going
> into the loop-search.
>
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Marek Vasut <marex@denx.de>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
