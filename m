From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: fix fsl_spdif.c build errors
Date: Sun, 6 Nov 2016 20:05:01 -0200
Message-ID: <CAOMZO5BCsVwwZ_K9-3VFvK1QuX7gAAabii3czZf35ohR_vuTVA@mail.gmail.com>
References: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
 <CAOMZO5DPP7suoCzSjkSzCugiC-nCNcLL8Xn68QdgaC3M9P_=cA@mail.gmail.com> <42b77fd8-4f54-2638-9110-f2fe0d52f629@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <42b77fd8-4f54-2638-9110-f2fe0d52f629@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Geliang Tang <geliangtang@163.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Randy,

On Sun, Nov 6, 2016 at 7:40 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> The driver uses bitreverse functions but does not select BITREVERSE
> in its kconfig description, so the bitrev functions are not built
> into the kernel.  In the kbuild robot supplied config file,
> FSL_SPDIF=y and BITREVERSE=m, which causes the build error.
> By having this driver select BITREVERSE, CONFIG_BITREVERSE=y so there
> is no build error.

This makes sense, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
