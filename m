From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [asoc:topic/st-dfsdm 2/2]
 sound/soc/stm/stm32_adfsdm.c:17:10: fatal error:
 linux/iio/adc/stm32-dfsdm-adc.h: No such file or directory
Date: Wed, 10 Jan 2018 19:20:55 +0100
Message-ID: <64269242-2179-f885-fa6e-ef1ec793ca32@st.com>
References: <201801110153.qJeFs7Gp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6401D266A74
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 19:21:06 +0100 (CET)
In-Reply-To: <201801110153.qJeFs7Gp%fengguang.wu@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,


On 01/10/2018 06:32 PM, kbuild test robot wrote:
> tree:=A0=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> topic/st-dfsdm
> head:=A0=A0 55da094824c4ef1d50bc591733d79448d00265bb
> commit: 55da094824c4ef1d50bc591733d79448d00265bb [2/2] ASoC: stm32: add
> DFSDM DAI support
> config: frv-allmodconfig (attached as .config)
> compiler: frv-linux-gcc (GCC) 7.2.0
> reproduce:
> =A0=A0=A0=A0=A0=A0=A0 wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
> =A0=A0=A0=A0=A0=A0=A0 chmod +x ~/bin/make.cross
> =A0=A0=A0=A0=A0=A0=A0 git checkout 55da094824c4ef1d50bc591733d79448d00265=
bb
> =A0=A0=A0=A0=A0=A0=A0 # save the attached .config to linux build tree
> =A0=A0=A0=A0=A0=A0=A0 make.cross ARCH=3Dfrv
> =

> All errors (new ones prefixed by >>):
> =

>>> sound/soc/stm/stm32_adfsdm.c:17:10: fatal error: linux/iio/adc/stm32-df=
sdm-adc.h: No such file or directory
> =A0=A0=A0 #include <linux/iio/adc/stm32-dfsdm-adc.h>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =A0=A0 compilation terminated.
> =

> vim +17 sound/soc/stm/stm32_adfsdm.c
> =

> =A0=A0=A0 14=A0
> =A0=A0=A0 15=A0 #include <linux/iio/iio.h>
> =A0=A0=A0 16=A0 #include <linux/iio/consumer.h>
> =A0 > 17=A0 #include <linux/iio/adc/stm32-dfsdm-adc.h>
> =A0=A0=A0 18 =

I checked the issue.
This is a fake problem related to the branch
remotes/origin/topic/st-dfsdm that is not based on
remotes/origin/topic/iio branch (containing commit for stm32-dfsdm-adc.h
file).

So can be ignored.

Regards
Arnaud

> =

> ---
> 0-DAY kernel test infrastructure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Intel
> Corporation
