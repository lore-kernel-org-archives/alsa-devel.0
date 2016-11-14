From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: BUG: KASAN: use-after-free in snd_usb_audio_free
Date: Mon, 14 Nov 2016 09:55:54 -0700
Message-ID: <c0ebdec6-717a-c5d8-56e4-9b9a5a9e111d@osg.samsung.com>
References: <CAKocOOPt1s2m1JBGSqEBwO1SdeOt-CinDmw-Lp3JFUz5gMT5Bg@mail.gmail.com>
 <s5hr36e2waq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr36e2waq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuahkhan@gmail.com>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

On 11/14/2016 03:25 AM, Takashi Iwai wrote:
> On Sat, 12 Nov 2016 00:34:38 +0100,
> Shuah Khan wrote:
>>
>> Hi Takashi,
>>
>> I am seeing the following use-after-free error when I disconnect an
>> USB speaker. I saw this on 4.9-rc4 and 4.8.7. There might be race
>> condition between the disconnect and pcm close perhaps.
> 
> Thanks, this looks like a new discovery.
> Could you check whether the patch below works?
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 9e5276d6dda0..2ddc034673a8 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -315,7 +315,8 @@ static int snd_usb_audio_free(struct snd_usb_audio *chip)
>  		snd_usb_endpoint_free(ep);
>  
>  	mutex_destroy(&chip->mutex);
> -	dev_set_drvdata(&chip->dev->dev, NULL);
> +	if (!atomic_read(&chip->shutdown))
> +		dev_set_drvdata(&chip->dev->dev, NULL);
>  	kfree(chip);
>  	return 0;
>  }
> 

Hi Takashi,

The patch fixed the problem on 4.9-rc4. Didn't get a chance
to test it on 4.8.7.

thanks,
-- Shuah
