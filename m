From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/8] ALSA: Replace timespec with timespec64
Date: Thu, 26 Apr 2018 16:41:14 +0800
Message-ID: <CAMz4kuL-3m-jPGV1ZdsadXyWxnu+jNMccCtzbcKGcpN33gnaxg@mail.gmail.com>
References: <7373ade7cb5a8d6a5fca07e78cf992ba7372bd7f.1524570852.git.baolin.wang@linaro.org>
 <201804261345.1lsWsCDl%fengguang.wu@intel.com>
 <CAK8P3a2TpW8rDw9YrWsJRkyawi+VkqaZQR6_WCSRpn96W6UbEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EA1326722C
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 10:41:15 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id f63-v6so23402153oic.4
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 01:41:15 -0700 (PDT)
In-Reply-To: <CAK8P3a2TpW8rDw9YrWsJRkyawi+VkqaZQR6_WCSRpn96W6UbEg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jeeja.kp@intel.com, SF Markus Elfring <elfring@users.sourceforge.net>, kbuild test robot <lkp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ingo Molnar <mingo@kernel.org>, gudishax.kranthikumar@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, subhransu.s.prusty@intel.com, Dan Carpenter <dan.carpenter@oracle.com>, hardik.t.shah@intel.com, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kbuild-all@01.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 26 April 2018 at 16:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 26, 2018 at 10:15 AM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Baolin,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on v4.17-rc2]
>> [also build test ERROR on next-20180424]
>> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
>> config: sh-ecovec24_defconfig (attached as .config)
>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=sh
>>
>> Note: the linux-review/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145 HEAD 53cdcc389f07bdd923be240cdb746a97de063301 builds fine.
>>       It only hurts bisectibility.
>>
>> All errors (new ones prefixed by >>):
>>
>>    sound/core/pcm_lib.c: In function 'update_audio_tstamp':
>>>> sound/core/pcm_lib.c:256:54: error: passing argument 2 of 'timespec_equal' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
>>                                                          ^~~~~~~~~~~~
>
>
> Probably a mistake during rebasing: patch 8/8 fixes this, but it should be done
> right here by moving the open-coded comparison into the first patch:
>
> -       if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
> +       if (runtime->status->audio_tstamp.tv_sec != audio_tstamp->tv_sec ||
> +           runtime->status->audio_tstamp.tv_nsec != audio_tstamp->tv_nsec) {
>

Sorry, it's my mistake. Yes, I can fix this issue like what you showed.

-- 
Baolin.wang
Best Regards
