From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [alsa-devel] [PATCH MC Next Gen] sound/usb: Fix out of bounds
 access in media_entity_init()
Date: Mon, 7 Dec 2015 07:23:59 -0700
Message-ID: <5665967F.4060704@osg.samsung.com>
References: <1449273629-4991-1-git-send-email-shuahkh@osg.samsung.com>
 <s5h8u563c9r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <s5h8u563c9r.wl-tiwai@suse.de>
Sender: linux-media-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mchehab@osg.samsung.com, perex@perex.cz, chehabrafael@gmail.com, hans.verkuil@cisco.com, prabhakar.csengg@gmail.com, chris.j.arges@canonical.com, alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

On 12/07/2015 01:15 AM, Takashi Iwai wrote:
> On Sat, 05 Dec 2015 01:00:29 +0100,
> Shuah Khan wrote:
>>
>> Fix the out of bounds access in media_entity_init() found
>> by KASan. This is a result of media_mixer_init() failing
>> to allocate memory for all 3 of its pads before calling
>> media_entity_init(). Fix it to allocate memory for the
>> right struct media_mixer_ctl instead of struct media_ctl.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>
>> This patch fixes the mixer patch below:
>> https://patchwork.linuxtv.org/patch/31827/
>>
>>  sound/usb/media.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/media.c b/sound/usb/media.c
>> index bebe27b..0cb44b9 100644
>> --- a/sound/usb/media.c
>> +++ b/sound/usb/media.c
>> @@ -233,8 +233,8 @@ int media_mixer_init(struct snd_usb_audio *chip)
>>  		if (mixer->media_mixer_ctl)
>>  			continue;
>>  
>> -		/* allocate media_ctl */
>> -		mctl = kzalloc(sizeof(struct media_ctl), GFP_KERNEL);
>> +		/* allocate media_mixer_ctl */
>> +		mctl = kzalloc(sizeof(struct media_mixer_ctl), GFP_KERNEL);
> 
> Isn't it better to use sizeof(*mctl)?
> 

Yes. That is definitely less error prone than
sizeof(struct foo). I will fix it and send the
corrected patch.

thanks,
-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
