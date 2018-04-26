From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/8] ALSA: Avoid using timespec for struct
	snd_pcm_status
Date: Thu, 26 Apr 2018 14:50:23 +0200
Message-ID: <CAK8P3a3qhR9rWhgewzOWXVLFY2yhp=Nbvj7-ThRrX+i55VGMpA@mail.gmail.com>
References: <7809a25514e8f7f72a276d19414346b2e4100945.1524570852.git.baolin.wang@linaro.org>
 <201804261703.caDB8Qo5%fengguang.wu@intel.com>
 <CAMz4kuJ0xy-0UByd8UzSUyc9iwgytH7EYE2JPDXFTe-1PFG3+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2783A2677F1
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 14:50:24 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id m5-v6so1875933qti.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 05:50:24 -0700 (PDT)
In-Reply-To: <CAMz4kuJ0xy-0UByd8UzSUyc9iwgytH7EYE2JPDXFTe-1PFG3+A@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jeeja.kp@intel.com, SF Markus Elfring <elfring@users.sourceforge.net>, kbuild test robot <lkp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ingo Molnar <mingo@kernel.org>, gudishax.kranthikumar@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, subhransu.s.prusty@intel.com, Dan Carpenter <dan.carpenter@oracle.com>, hardik.t.shah@intel.com, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kbuild-all@01.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 12:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:

>>
>>    971
>>    972  static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
>>    973                                   struct snd_pcm_status32 __user * _status,
>>    974                                   bool ext)
>>    975  {
>>    976          struct snd_pcm_status64 status64;
>>    977          struct snd_pcm_status32 status32;
>>    978          int res;
>>    979
>>    980          memset(&status64, 0, sizeof(status64));
>>    981          memset(&status32, 0, sizeof(status32));
>>    982          /*
>>    983           * with extension, parameters are read/write,
>>    984           * get audio_tstamp_data from user,
>>    985           * ignore rest of status structure
>>    986           */
>>    987          if (ext && get_user(status64.audio_tstamp_data,
>>    988                              (u32 __user *)(&_status->audio_tstamp_data)))
>>    989                  return -EFAULT;
>>    990          res = snd_pcm_status64(substream, &status64);
>>    991          if (res < 0)
>>    992                  return res;
>>    993
>>    994          status32 = (struct snd_pcm_status32) {
>>  > 995                  .state = status64.state,
>>    996                  .trigger_tstamp_sec = status64.trigger_tstamp_sec,
>>    997                  .trigger_tstamp_nsec = status64.trigger_tstamp_nsec,
>>    998                  .tstamp_sec = status64.tstamp_sec,
>>    999                  .tstamp_nsec = status64.tstamp_nsec,
>>   1000                  .appl_ptr = status64.appl_ptr,
>>   1001                  .hw_ptr = status64.hw_ptr,
>>   1002                  .delay = status64.delay,
>>   1003                  .avail = status64.avail,
>>   1004                  .avail_max = status64.avail_max,
>>   1005                  .overrange = status64.overrange,
>>> 1006                  .suspended_state = status64.suspended_state,
>
> I am not sure for the warning here, we should change 'snd_pcm_state_t'
> to 's32' for struct snd_pcm_status64?
>
> typedef int __bitwise snd_pcm_state_t;

The problem is that snd_pcm_status32 uses 'u32' here instead of snd_pcm_state_t,
and the __bitwise annotation makes the two types incompatible. This is a
preexisting problem, the warning mail just appeared because you moved that
code to a different file.

If you want to avoid that warning, either use a type case with '__force',
or change the snd_pcm_status32 structure to also use snd_pcm_state_t.

That would be a useful change, but it should be separate from your
other changes since it's an unrelated problem.

      Arnd
