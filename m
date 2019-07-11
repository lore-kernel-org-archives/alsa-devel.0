From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: codecs: ad193x: Use regmap_multi_reg_write() when initializing
Date: Thu, 11 Jul 2019 08:56:32 +0800
Message-ID: <CA+Px+wWa9MvK4UVqsrMGtSQ=ZUSQrX837JFma5EYdhu465YhXg@mail.gmail.com>
References: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 10, 2019 at 6:51 PM Codrin Ciubotariu
<codrin.ciubotariu@microchip.com> wrote:
>
> Using regmap_multi_reg_write() when we set the default values for our
> registers makes the code smaller and easier to read.
>
> Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM.  Thanks.
