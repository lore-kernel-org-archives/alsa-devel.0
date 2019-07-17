From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 6/6] ASoC: sgtl5000: Fix charge pump source assignment
Date: Wed, 17 Jul 2019 13:50:02 -0300
Message-ID: <CAOMZO5Bqf-mWxsvgVYg1+xk=hvGRNocfhRH1F39HBD7q_UY2uw@mail.gmail.com>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-7-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717163014.429-7-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> If VDDA != VDDIO and any of them is greater than 3.1V, charge pump
> source can be assigned automatically [1].
>
> [1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
