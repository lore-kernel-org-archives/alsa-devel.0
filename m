From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [asoc:fix/rt5645 1/1]
 sound/soc/codecs/rt5645.c:2947:3: warning: 'return' with no value,
 in function returning non-void
Date: Thu, 16 Jul 2015 21:03:29 +0800
Message-ID: <CANMq1KD5YjN1Dv5cEJ0YQMxMyEnSNZb=8AK4t7p_Uw3418V_Dw@mail.gmail.com>
References: <201507162001.z6afFgHb%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CF54266587
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 15:03:31 +0200 (CEST)
Received: by oibn4 with SMTP id n4so49683954oib.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 06:03:29 -0700 (PDT)
In-Reply-To: <201507162001.z6afFgHb%fengguang.wu@intel.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Jul 16, 2015 at 8:32 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git fix/rt5645
> head:   3c2234569cfff83718792f810a9bb855b78c2473
> commit: 3c2234569cfff83718792f810a9bb855b78c2473 [1/1] ASoC: rt5645: Check if codec is initialized in workqueue handler
> config: i386-randconfig-x009-201528 (attached as .config)
> reproduce:
>   git checkout 3c2234569cfff83718792f810a9bb855b78c2473
>   # save the attached .config to linux build tree
>   make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    sound/soc/codecs/rt5645.c: In function 'rt5645_irq_detection':
>>> sound/soc/codecs/rt5645.c:2947:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
>       return;
>       ^

Are you sending this patch to stable@?

This happens because I rebased the patch on f312bc59 "ASoC: rt5645:
Remove irq_jack_detection function" (which was your for-next at the
time), so it probably shouldn't be applied in its own branch...

The return value is ignored anyway, so the code should work as
intended, but a "return 0;", or -EINVAL, would be more proper...

Thanks,
