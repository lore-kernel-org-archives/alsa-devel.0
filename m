From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: line6: constify snd_kcontrol_new
	structures
Date: Thu, 13 Apr 2017 12:04:06 +0530
Message-ID: <CAOH+1jEdEE2xB3pr2_o_g6BL-cAWR+ZoqfPUXcP5z7Qubn5epQ@mail.gmail.com>
References: <1492002647-11016-1-git-send-email-bhumirks@gmail.com>
 <3474e601-524f-ed87-f5a8-0634d10723b6@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id E0A472669CD
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:34:09 +0200 (CEST)
Received: by mail-io0-f195.google.com with SMTP id k87so11077502ioi.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 23:34:09 -0700 (PDT)
In-Reply-To: <3474e601-524f-ed87-f5a8-0634d10723b6@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Julia Lawall <julia.lawall@lip6.fr>, alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 12, 2017 at 7:15 PM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> Hi,
>
>
> On Apr 12 2017 22:10, Bhumika Goyal wrote:
>>
>> Declare snd_kcontrol_new strcutures as const as they are only passed as
>> an argument to the function snd_ctl_new1. This argument is of type const,
>> so snd_kcontrol_new structures having this property can be made const too.
>> Done using Coccinelle:
>>
>> @r disable optional_qualifier@
>> identifier x;
>> position p;
>> @@
>> static struct snd_kcontrol_new x@p={...};
>>
>> @ok@
>> identifier r.x;
>> position p;
>> @@
>> snd_ctl_new1(&x@p,...)
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.x;
>> @@
>> x@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.x;
>> @@
>> +const
>> struct snd_kcontrol_new x;
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>> ---
>>  sound/usb/line6/pod.c      | 2 +-
>>  sound/usb/line6/toneport.c | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> I have interests in your way to detect this kind of issue, because below
> 'struct snd_kcontrol_new' array seems not to be detected. I think there's a
> space to improve it.
>

Thanks for pointing it out. The  logic that I use currently for my
scripts doesn't take into account the arrays. I will extend the script
for arrays too.

Thanks,
Bhumika

> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/usb/line6/pcm.c#n432
>
> 432 /* control definition */
> 433 static struct snd_kcontrol_new line6_controls[] = {
> 434         {
> 435                 .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>
> Later, I'll post for the above line.
>
>
>> diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
>> index 17aa616..358224c 100644
>> --- a/sound/usb/line6/pod.c
>> +++ b/sound/usb/line6/pod.c
>> @@ -380,7 +380,7 @@ static int snd_pod_control_monitor_put(struct
>> snd_kcontrol *kcontrol,
>>  }
>>
>>  /* control definition */
>> -static struct snd_kcontrol_new pod_control_monitor = {
>> +static const struct snd_kcontrol_new pod_control_monitor = {
>>         .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>>         .name = "Monitor Playback Volume",
>>         .index = 0,
>> diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
>> index 8e22f43..ba7975c 100644
>> --- a/sound/usb/line6/toneport.c
>> +++ b/sound/usb/line6/toneport.c
>> @@ -250,7 +250,7 @@ static void toneport_start_pcm(unsigned long arg)
>>  }
>>
>>  /* control definition */
>> -static struct snd_kcontrol_new toneport_control_monitor = {
>> +static const struct snd_kcontrol_new toneport_control_monitor = {
>>         .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>>         .name = "Monitor Playback Volume",
>>         .index = 0,
>> @@ -261,7 +261,7 @@ static struct snd_kcontrol_new
>> toneport_control_monitor = {
>>  };
>>
>>  /* source selector definition */
>> -static struct snd_kcontrol_new toneport_control_source = {
>> +static const struct snd_kcontrol_new toneport_control_source = {
>>         .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>>         .name = "PCM Capture Source",
>>         .index = 0,
>
>
>
> Regards
>
> Takashi Sakamoto
