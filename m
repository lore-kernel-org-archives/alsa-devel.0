From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Date: Wed, 17 Jul 2019 13:49:37 -0300
Message-ID: <CAOMZO5B6M-YKB7gn0Gn7CJG+8YyvC_Xqu99wtHac_bQktm3T+g@mail.gmail.com>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-6-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717163014.429-6-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> To enable "zero cross detect" for ADC/HP, change
> HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
> CHIP_ANA_CTRL register.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
