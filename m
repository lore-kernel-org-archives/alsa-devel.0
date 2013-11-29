From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] MFD: twl6040: reg_defaults support for regmap
Date: Fri, 29 Nov 2013 16:00:32 +0000
Message-ID: <20131129160032.GC26982@lee--X1>
References: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
 <1385733827-19831-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385733827-19831-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Nov 2013, Peter Ujfalusi wrote:

> Add reg_defaults to regmap and at the same time implement proper powe=
r state
> handling with using regcache_cache_only(), regcache_sync() and
> regcache_mark_dirty().
> This will make sure that we do not need to do restore operations in c=
hild
> drivers anymore.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl6040.c | 92 +++++++++++++++++++++++++++++++++++++++++=
++++++++--
>  1 file changed, 89 insertions(+), 3 deletions(-)

The code looks fine to me (me =3D !regmap expert), so with Mark's Ack I
will apply.

Mark, is an immutable branch required for this patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
