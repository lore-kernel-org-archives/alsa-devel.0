From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: fix fsl_spdif.c build errors
Date: Sun, 6 Nov 2016 17:43:53 -0200
Message-ID: <CAOMZO5DPP7suoCzSjkSzCugiC-nCNcLL8Xn68QdgaC3M9P_=cA@mail.gmail.com>
References: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Geliang Tang <geliangtang@163.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Randy,

On Sat, Nov 5, 2016 at 9:16 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors in sound/soc/fsl/fsl_spdif.c by selecting BITREVERSE.
> Fixes these build errors:

Care to explain why the error is happening?

> sound/built-in.o: In function `spdif_write_channel_status':
> fsl_spdif.c:(.text+0xbe39d): undefined reference to `byte_rev_table'
> fsl_spdif.c:(.text+0xbe3a8): undefined reference to `byte_rev_table'
> fsl_spdif.c:(.text+0xbe3be): undefined reference to `byte_rev_table'
> fsl_spdif.c:(.text+0xbe3d8): undefined reference to `byte_rev_table'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Applies-to: all 3.x, all 4.x

Not sure if this last line is correct. The kbuild report says this
error starts to happen with:
commit: 8cfc8ddc99df9509a46043b14af81f5c6a223eab pstore: add lzo/lz4
compression support

on a x86_64 randconfig.

Also, why only SND_SOC_FSL_SPDIF needs to have BITREVERSE selected?
