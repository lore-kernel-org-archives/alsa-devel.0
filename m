From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 4/7] sound: core: Avoid using timespec for struct snd_rawmidi_status
Date: Fri, 22 Sep 2017 09:54:39 +0800
Message-ID: <CAMz4kuLsKwCv2vFk3Pg3_sQdH1M+baWKYXz21opp6KchzHR=zg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <d4a0a3d89148f8fb0680c8846879039d71c2da02.1505973912.git.baolin.wang@linaro.org>
 <CAK8P3a1iiJfdodP0kLCOb4GTMPw-5DEciLAdMCMh5SPhTJLyeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1iiJfdodP0kLCOb4GTMPw-5DEciLAdMCMh5SPhTJLyeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On 21 September 2017 at 20:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> -       case SNDRV_RAWMIDI_IOCTL_STATUS:
>> +#if __BITS_PER_LONG == 32
>> +       case SNDRV_RAWMIDI_IOCTL_STATUS32:
>> +       {
>> +               int err = 0;
>> +               struct snd_rawmidi_status32 __user *status = argp;
>> +               struct snd_rawmidi_status32 status32;
>> +               struct snd_rawmidi_status64 status64;
>> +
>> +               if (copy_from_user(&status32, argp,
>> +                                  sizeof(struct snd_rawmidi_status32)))
>> +                       return -EFAULT;
>> +               switch (status32.stream) {
>> +               case SNDRV_RAWMIDI_STREAM_OUTPUT:
>> +                       if (rfile->output == NULL)
>> +                               return -EINVAL;
>> +                       err = snd_rawmidi_output_status(rfile->output, &status64);
>> +                       break;
>> +               case SNDRV_RAWMIDI_STREAM_INPUT:
>> +                       if (rfile->input == NULL)
>> +                               return -EINVAL;
>> +                       err = snd_rawmidi_input_status(rfile->input, &status64);
>> +                       break;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +               if (err < 0)
>> +                       return err;
>> +
>> +               if (put_user(status64.stream, &status->stream) ||
>> +                   put_user(status64.tstamp.tv_sec, &status->tstamp.tv_sec) ||
>> +                   put_user(status64.tstamp.tv_nsec, &status->tstamp.tv_nsec) ||
>> +                   put_user(status64.avail, &status->avail) ||
>> +                   put_user(status64.xruns, &status->xruns))
>> +                       return -EFAULT;
>> +               return 0;
>> +       }
>
> This follows the existing coding style for the other functions, but I think
> it would be nicer to express the last part as
>
>        status32 = (struct snd_rawmidi_status32) {
>                .stream = status->stream,
>                .tstamp.tv_sec, &status->tstamp.tv_sec,
>                .tstamp.tv_nsec, &status->tstamp.tv_nsec,
>                .avail, &status->avail,
>                .xruns, &status->xruns,
>        };
>        if (copy_to_user(status, &status32, sizeof(*status))
>               return -EFAULT;
>        return 0;
>
> It's completely equivalent, I just find my version easier to read, and
> it should produce slightly better object code.
>
> Maybe the maintainers have a preference, or there might be
> a good reason to use the series of put_user() instead.

I just saw there are not many put_user() will be used in this
function, but I agree with you and I like to change as you suggested.

-- 
Baolin.wang
Best Regards
