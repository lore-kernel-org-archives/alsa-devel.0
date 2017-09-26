From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 6/7] uapi: sound: Avoid using timespec for struct snd_ctl_elem_value
Date: Wed, 27 Sep 2017 05:54:54 +0800
Message-ID: <CAMz4ku+JGvxD5UsEUc6js0QPHFSw3bd1qsWS_wg-P5oAMqsigQ@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <f47f86aa2bc1b96fbe47737f795ea1aee642caa0.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a3a0gDiC+3Rc5VONHap67d-L8QTYmvzS16XtKKVj24b5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3a0gDiC+3Rc5VONHap67d-L8QTYmvzS16XtKKVj24b5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21 September 2017 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The struct snd_ctl_elem_value will use 'timespec' type variables to record
>> timestamp, which is not year 2038 safe on 32bits system.
>>
>> Since there are no drivers will implemented the tstamp member of the
>> struct snd_ctl_elem_value, and also the stucture size will not be changed
>> if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.
>>
>> Thus we can simply change timespec to s64 for tstamp member to avoid
>> using the type which is not year 2038 safe on 32bits system.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  include/uapi/sound/asound.h |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index 1949923..71bce52 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -943,8 +943,8 @@ struct snd_ctl_elem_value {
>>                 } bytes;
>>                 struct snd_aes_iec958 iec958;
>>         } value;                /* RO */
>> -       struct timespec tstamp;
>> -       unsigned char reserved[128-sizeof(struct timespec)];
>> +       struct { s64 tv_sec; s64 tv_nsec; } tstamp;
>> +       unsigned char reserved[128-sizeof(struct { s64 tv_sec; s64 tv_nsec; })];
>>  };
>
> Maybe we should enforce that nobody uses the timespec field, by
> enclosing it in #ifdef __KERNEL__ (with a matching length below it);

OK.

-- 
Baolin.wang
Best Regards
