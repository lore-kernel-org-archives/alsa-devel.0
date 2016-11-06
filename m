From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: fsl: fix fsl_spdif.c build errors
Date: Sun, 6 Nov 2016 13:40:35 -0800
Message-ID: <42b77fd8-4f54-2638-9110-f2fe0d52f629@infradead.org>
References: <7ea1cd5a-9215-18ed-2412-b6860a0b708f@infradead.org>
 <CAOMZO5DPP7suoCzSjkSzCugiC-nCNcLL8Xn68QdgaC3M9P_=cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 214ED266218
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 22:40:44 +0100 (CET)
In-Reply-To: <CAOMZO5DPP7suoCzSjkSzCugiC-nCNcLL8Xn68QdgaC3M9P_=cA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Xiubo Li <Xiubo.Lee@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Geliang Tang <geliangtang@163.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 11/06/16 11:43, Fabio Estevam wrote:
> Hi Randy,
> 
> On Sat, Nov 5, 2016 at 9:16 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors in sound/soc/fsl/fsl_spdif.c by selecting BITREVERSE.
>> Fixes these build errors:
> 
> Care to explain why the error is happening?

The driver uses bitreverse functions but does not select BITREVERSE
in its kconfig description, so the bitrev functions are not built
into the kernel.  In the kbuild robot supplied config file,
FSL_SPDIF=y and BITREVERSE=m, which causes the build error.
By having this driver select BITREVERSE, CONFIG_BITREVERSE=y so there
is no build error.

>> sound/built-in.o: In function `spdif_write_channel_status':
>> fsl_spdif.c:(.text+0xbe39d): undefined reference to `byte_rev_table'
>> fsl_spdif.c:(.text+0xbe3a8): undefined reference to `byte_rev_table'
>> fsl_spdif.c:(.text+0xbe3be): undefined reference to `byte_rev_table'
>> fsl_spdif.c:(.text+0xbe3d8): undefined reference to `byte_rev_table'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Applies-to: all 3.x, all 4.x
> 
> Not sure if this last line is correct. The kbuild report says this
> error starts to happen with:
> commit: 8cfc8ddc99df9509a46043b14af81f5c6a223eab pstore: add lzo/lz4
> compression support

That commit makes no sense to me regarding this build error.

This driver uses bitrev functions even way back in 3.x so this
patch could be applied to many stable kernel versions.

> on a x86_64 randconfig.
> 
> Also, why only SND_SOC_FSL_SPDIF needs to have BITREVERSE selected?

It's the only source file in sound/soc/fsl/ that uses bitreverse functions.


-- 
~Randy
