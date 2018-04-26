From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] ALSA: add new 32-bit layout for
	snd_pcm_mmap_status/control
Date: Thu, 26 Apr 2018 13:34:34 +0200
Message-ID: <CAK8P3a1Axa35n508VwyQkEqzhKOJ48UpwRi2x0Y7T4z2G3SetQ@mail.gmail.com>
References: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
 <201804261121.VJnJJU0C%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3441F26722C
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:34:35 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id o64so25209564qkl.7
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 04:34:35 -0700 (PDT)
In-Reply-To: <201804261121.VJnJJU0C%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jeeja.kp@intel.com, SF Markus Elfring <elfring@users.sourceforge.net>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ingo Molnar <mingo@kernel.org>, gudishax.kranthikumar@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, subhransu.s.prusty@intel.com, Dan Carpenter <dan.carpenter@oracle.com>, hardik.t.shah@intel.com, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Baolin Wang <baolin.wang@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kbuild-all@01.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 5:07 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on v4.17-rc2]
> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
> config: i386-randconfig-n0-201816 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>>> sound/core/pcm_native.c:2827:25: error: field 'tstamp' has incomplete type
>      struct compat_timespec tstamp;
>                             ^~~~~~
>>> sound/core/pcm_native.c:2829:25: error: field 'audio_tstamp' has incomplete type
>      struct compat_timespec audio_tstamp;
>                             ^~~~~~~~~~~~

This is due to a dependency on one of Deepa's patches that is
currently in linux-next,
scheduled for 4.18-rc1, but that won't be in 4.17.

It seems likely that we won't come to a conclusion in time for 4.18
anyway, so that's
probably fine. If we want the patches in 4.18, I can come up with a
different way of
doing this.

       Arnd
