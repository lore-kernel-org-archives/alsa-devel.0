From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] mfd: Add initial WM8958 support
Date: Mon, 1 Nov 2010 23:52:04 -0200
Message-ID: <AANLkTikzEdgUqVU0N=y7Vy+fnqKyskVp6p0zMpdYmenk@mail.gmail.com>
References: <1288635611-25560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288635611-25560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 1, 2010 at 4:20 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> diff --git a/include/linux/mfd/wm8994/core.h b/include/linux/mfd/wm89=
94/core.h
> index de79bae..3fd3684 100644
> --- a/include/linux/mfd/wm8994/core.h
> +++ b/include/linux/mfd/wm8994/core.h
> @@ -17,6 +17,11 @@
>
> =C2=A0#include <linux/interrupt.h>
>
> +enum wm8994_type {
> + =C2=A0 =C2=A0 =C2=A0 WM8994 =3D 0,
> + =C2=A0 =C2=A0 =C2=A0 WM8958 =3D 1,
> +};
> +
Don't need to initialize with =3D 0 and with =3D 1. This is done by def=
ault.
