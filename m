From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on
 pri/sec PCM
Date: Fri, 15 Feb 2019 08:24:17 +0100
Message-ID: <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
 <20190214160011.3940-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214160011.3940-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2019 at 17:00, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Currently when playing sound with different sample rates actual
> sample rate will be determined by audio stream which starts first
> on either primary or secondary PCM. The audio root clock will be
> configured appropriately only for the first stream. As the hardware
> is limited to same sample rate on both interfaces we need to disallow
> streams with different sample rates. It is done by this patch by
> returning error in FE hw_params if there is already active stream
> running with different sample rate.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Is this the fix for
"aplay: set_params:1403: Unable to install hw params:"
which appeared in today's next (so after your last round of patches get merged)?
https://krzk.eu/#/builders/1/builds/3093/steps/24/logs/stdio

Also, since yesterday (so with previous rounds of patches) the audss
rebind freezes entire kernel:
https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/stdio
https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/serial0

It is not important test but it was always passing in my suite.

Best regards,
Krzysztof
