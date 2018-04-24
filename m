From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Date: Tue, 24 Apr 2018 15:29:38 +0200
Message-ID: <CAK8P3a0aWk1yJtcBBBiHuaTOMvgy1v4KpnXqtc9HudOEoCfiaQ@mail.gmail.com>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 312502676A6
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:29:39 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id h19so329353qkj.10
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 06:29:39 -0700 (PDT)
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, SF Markus Elfring <elfring@users.sourceforge.net>, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 24, 2018 at 2:06 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since many structures will use timespec type variables to record time stamp
> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
> tries to introduce new structures removing timespec type to compatible native
> mode and compat mode.
>
> Moreover this patchset also converts the internal structrures to use timespec64
> type and related APIs.
>
> Arnd Bergmann (2):
>   ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
>   ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
>
> Baolin Wang (6):
>   ALSA: Replace timespec with timespec64
>   ALSA: Avoid using timespec for struct snd_timer_status
>   ALSA: Avoid using timespec for struct snd_ctl_elem_value
>   ALSA: Avoid using timespec for struct snd_pcm_status
>   ALSA: Avoid using timespec for struct snd_rawmidi_status
>   ALSA: Avoid using timespec for struct snd_timer_tread

Thanks a lot for picking this up again and including my two patches!

I've done a private review yesterday, but will have another look either
today or tomorrow to see if I missed anything. I've also applied the
series to my randconfig build tree and will see if that finds any new
bugs. The builder has already found a bug in one of my two patches,
so there might be more.

      Arnd
