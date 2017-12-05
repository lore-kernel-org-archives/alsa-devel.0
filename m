From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ALSA: pcm: prevent UAF in snd_pcm_info
Date: Tue, 5 Dec 2017 11:29:07 -0800
Message-ID: <CAGXu5j+WH2N2Xu_FahJcC9VTDD1+c5LFtFPv3O9-9AgXyRCi=w@mail.gmail.com>
References: <20171205171657.74392-1-ndesaulniers@google.com>
 <s5hvahldm28.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 96EA126698E
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 20:29:10 +0100 (CET)
Received: by mail-vk0-f66.google.com with SMTP id x140so1035207vke.4
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 11:29:10 -0800 (PST)
In-Reply-To: <s5hvahldm28.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Robb Glasser <rglasser@google.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 5, 2017 at 11:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 05 Dec 2017 18:16:55 +0100,
> Nick Desaulniers wrote:
>>
>> From: Robb Glasser <rglasser@google.com>
>>
>> When the device descriptor is closed, the `substream->runtime` pointer
>> is freed. But another thread may be in the ioctl handler, case
>> SNDRV_CTL_IOCTL_PCM_INFO. This case calls snd_pcm_info_user() which
>> calls snd_pcm_info() which accesses the now freed `substream->runtime`.
>>
>> Signed-off-by: Robb Glasser <rglasser@google.com>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Looks reasonable.  Applied with Cc to stable now.

FWIW, this was assigned CVE-2017-0861. (Best to get it into the commit
log if possible.)

-Kees

>
>
> thanks,
>
> Takashi
>
>> ---
>>  sound/core/pcm.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
>> index 9070f277f8db..09ee8c6b9f75 100644
>> --- a/sound/core/pcm.c
>> +++ b/sound/core/pcm.c
>> @@ -153,7 +153,9 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
>>                               err = -ENXIO;
>>                               goto _error;
>>                       }
>> +                     mutex_lock(&pcm->open_mutex);
>>                       err = snd_pcm_info_user(substream, info);
>> +                     mutex_unlock(&pcm->open_mutex);
>>               _error:
>>                       mutex_unlock(&register_mutex);
>>                       return err;
>> --
>> 2.15.0.531.g2ccb3012c9-goog
>>
>>



-- 
Kees Cook
Pixel Security
