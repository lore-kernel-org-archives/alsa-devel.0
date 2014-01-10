From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/2] mfd: wm5110: Add registers for headphone short
 circuit control
Date: Fri, 10 Jan 2014 10:06:38 +0000
Message-ID: <20140110100638.GD28141@lee--X1>
References: <1389277765-23914-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389277765-23914-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: sameo@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 09 Jan 2014, Charles Keepax wrote:

> Add the registers necessary to enable/disable the headphone short
> circuit protection.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/wm5110-tables.c           |    6 ++++++
>  include/linux/mfd/arizona/registers.h |   27 +++++++++++++++++++++++=
++++
>  2 files changed, 33 insertions(+), 0 deletions(-)

I'm assuming the ASoC commit depends on this one?

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
