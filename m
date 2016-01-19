From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about device recovery when under/over run
	error case
Date: Tue, 19 Jan 2016 12:21:55 +0900
Message-ID: <569DABD3.4080707@sakamocchi.jp>
References: <87twmbfqio.wl%kuninori.morimoto.gx@renesas.com>
 <569C7215.2000801@sakamocchi.jp>
 <87si1vfmv6.wl%kuninori.morimoto.gx@renesas.com>
 <s5h4mebs33a.wl-tiwai@suse.de>
 <87vb6q4ev2.wl%kuninori.morimoto.gx@renesas.com>
 <569D8E35.4010306@sakamocchi.jp>
 <87si1u46d9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FD082604D6
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 04:21:59 +0100 (CET)
In-Reply-To: <87si1u46d9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 19 2016 12:08, Kuninori Morimoto wrote:
>>>>>> Userspace can get to know the XRUN state by calling some APIs. Then,
>>>>>> it can recover PCM substream by executing SNDRV_PCM_IOCTL_PREPARE
>>>>>> ioctl.
>>>>>
>>>>> I think we can use snd_pcm_stop_xrun() for this purpose.
>>>>
>>>> Right.  But beware of locking by this function.  Unlike snd_pcm_stop()
>>>> this function takes the stream lock by itself.
>>>
>>> Thanks !
>>> I see. I will investigate it.
>>
>> The 'lock' is what I mentioned in former message to you:
>>
>> [alsa-devel] Can I stop sound from driver as system error ?
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102010.html
>
> Yes, I had asked same question to ML, I'm sorry about that.
> And, can I confirm about your concern ?
> I guess you are worrying about dead-lock by stop xrun, but is that correct ?

Recent SoC tends to accumurate much IPs with variety functionalities.

If your SoC, R-Car, has such IPs and snd-soc-rcar utilize it, I can 
assume that snd-soc-rcar require to wait for some events after operating 
to the IPs. Or snd-soc-rcar require to manage race conditions between 
many PCM substreams.

In this case, current structure of snd-soc-rcar may cause problems (at 
least, in the end of last year), because it pushes many operations into 
'struct snd_pcm_ops.trigger'. This callback is executed in both of 
process context and interrupt context and drivers should not wait for 
events or should not manage race conditions.

This is my concern about it.


Regards

Takashi Sakamoto
