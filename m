From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 03/13] ASoC: topology: ABI - Define DPCM
 trigger ordering for PCM
Date: Fri, 9 Sep 2016 19:40:58 +0800
Message-ID: <57D29FCA.8050706@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823174135.GA22076@sirena.org.uk> <57C91FD8.1090205@linux.intel.com>
 <57CE5F1B.3020601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F1B65265D2B
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:34:55 +0200 (CEST)
In-Reply-To: <57CE5F1B.3020601@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

We'll drop support for configuring DPCM trigger ordering in topology, 
and the driver will set this in kernel.

I'll submit the v2 series. Please review.

Thanks
Mengdong

On 09/06/2016 02:15 PM, Mengdong Lin wrote:
> + Rakesh
>
>
> Hi Hardik/Vinod/Rakesh,
>
> Would you please share more info about DPCM trigger ordering used in
> current ADSP firmware? And why we hope to configure this by topology?
>
> Here is Mark's question "Why do these things need to be triggered in
> this particular order and why is that invisible to the system?".
>
> Please see link
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-September/112539.html
>
>
> My mail client lost Mark's mail so I paste the link here.
>
> Thanks
> Mengdong
>
> On 09/02/2016 02:44 PM, Mengdong Lin wrote:
>>
>>
>> On 08/24/2016 01:41 AM, Mark Brown wrote:
>>> On Fri, Aug 19, 2016 at 06:12:55PM +0800, mengdong.lin@linux.intel.com
>>> wrote:
>>>
>>>> Definition of dynamic PCM trigger ordering is exposed to uapi asoc.h,
>>>> and topology allows user space to define the trigger ordering for PCM
>>>> (FE links).
>>>
>>> This seems *incredibly* implementation specific.  Why wouldn't the
>>> driver for the thing implementing the topology be able to figure out the
>>> ordering here?  What's the use case?  What happens when we change away
>>> from DPCM?
>>>
>>
>> There is another patch (04/13) to add generic flags and flag mask to PCM
>> objects. So we'll allow users to set DPCM trigger ordering as flags as
>> below, to avoid using trigger[] in ABI. The topology kernel driver will
>> check the flag bits and set the proper trigger ordering to FE DAI links.
>> If we change away from DPCM in the future, user can stop using these
>> flags. And the 32-bit flags seems enough for future extension.
>>
>> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
>> index f734bea..30da32f 100644
>> --- a/include/uapi/sound/asoc.h
>> +++ b/include/uapi/sound/asoc.h
>> @@ -130,6 +130,16 @@
>>   #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
>>   #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
>>
>> +/* DAI link flags */
>> +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 0)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 1)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_PLAYBACK_DPCM_TRIGGER_PRE       (1<<2)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_PLAYBACK_DPCM_TRIGGER_POST      (1<<3)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_PLAYBACK_DPCM_TRIGGER_BESPOKE   (1<<4)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_CAPTURE_DPCM_TRIGGER_PRE        (1<<2)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_CAPTURE_DPCM_TRIGGER_POST       (1<<3)
>> +#define SND_SOC_TPLG_LNK_FLGBIT_CAPTURE_DPCM_TRIGGER_BESPOKE    (1<<4)
>> +
>>   /*
>>    * Block Header.
>>    * This header precedes all object and object arrays below.
>> @@ -439,6 +449,8 @@ struct snd_soc_tplg_pcm {
>>          struct snd_soc_tplg_stream
>> stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
>>          __le32 num_streams;     /* number of streams */
>>          struct snd_soc_tplg_stream_caps caps[2]; /* playback and
>> capture for DAI */
>> +       __le32 flag_mask;       /* bitmask of flags to configure */
>> +       __le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag
>> value */
>>   } __attribute__((packed));
>>
>>
>> Thanks
>> Mengdong
