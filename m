From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] ALSA: pcm: Fix snd_pcm_hw_params struct copy in compat mode
Date: Mon, 18 Jan 2016 21:00:19 +0800
Message-ID: <CANMq1KC_EFc0p=2T-sVnFviPkAcW8qNuOoH-unwNjsRygGeu8Q@mail.gmail.com>
References: <1453088958-6214-1-git-send-email-drinkcat@chromium.org>
	<s5ha8o3s89j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha8o3s89j.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 2:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 18 Jan 2016 04:49:18 +0100,
> Nicolas Boichat wrote:
>>
>> Running a kernel with KASan enabled, we spotted that the following
>> read in sound/soc/soc-pcm.c:soc_pcm_hw_params() is out of bounds:
>>
>>               /* copy params for each codec */
>>               codec_params = *params;
>>
>> The problem comes from sound/core/pcm_compat.c,
>> snd_pcm_ioctl_hw_params_compat, where we're copying from a
>> struct snd_pcm_hw_params to a struct snd_pcm_hw_params32:
>>
>>       /* only fifo_size is different, so just copy all */
>>       data = memdup_user(data32, sizeof(*data32));
>>
>> It turns out that snd_pcm_hw_params is 4 bytes longer than
>> snd_pcm_hw_params32, that's why an out-of-bounds read happens.
>>
>> We separate kmalloc and memory copy operations to make sure
>> data has the correct length.
>>
>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Thanks for reporting.  This is indeed effectively a revert of the
> commit ef44a1ec6eee ('ALSA: sound/core: use memdup_user()'), which is
> obviously wrong.  Sigh, it's a really danger of such a "cleanup"
> patch.

Oh, well spotted!

> Could you rephrase the changelog mentioning the affecting commit and
> resubmit?

Sure. Looking at that commit, there is another suspicious memdup_user
in sound/seq/seq_compat.c (similar issue: struct snd_seq_port_info32
is 4 bytes shorter than struct snd_seq_port_info). I'll revert that
one as well.

>
> Takashi
>
>> ---
>>  sound/core/pcm_compat.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
>> index b48b434..9630e9f 100644
>> --- a/sound/core/pcm_compat.c
>> +++ b/sound/core/pcm_compat.c
>> @@ -255,10 +255,15 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
>>       if (! (runtime = substream->runtime))
>>               return -ENOTTY;
>>
>> -     /* only fifo_size is different, so just copy all */
>> -     data = memdup_user(data32, sizeof(*data32));
>> -     if (IS_ERR(data))
>> -             return PTR_ERR(data);
>> +     data = kmalloc(sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     /* only fifo_size (RO from userspace) is different, so just copy all */
>> +     if (copy_from_user(data, data32, sizeof(*data32))) {
>> +             err = -EFAULT;
>> +             goto error;
>> +     }
>>
>>       if (refine)
>>               err = snd_pcm_hw_refine(substream, data);
>> --
>> 2.6.0.rc2.230.g3dd15c0
>>
>>
