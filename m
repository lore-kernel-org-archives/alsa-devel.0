From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: mc13xxx: Do not use platform data with
 devicetree
Date: Fri, 9 May 2014 12:30:30 +0100
Message-ID: <20140509113030.GV5767@lee--X1>
References: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> This patch removes platform data usage for codec and touchscreen
> when driver is used with devicetree.
> This fixes possible "null pointer dereference" error if DTS uses
> "fsl,mc13xxx-uses-codec" or "fsl,mc13xxx-uses-touch" options.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/mfd/mc13xxx-core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
