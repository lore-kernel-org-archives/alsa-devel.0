From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Wed, 07 Aug 2013 10:26:35 +0200
Message-ID: <520204BB.9080603@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
 <5200B7B5.7050506@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
 <5200C369.6050607@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-112.synserver.de (smtp-out-112.synserver.de
 [212.40.185.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 01A6A26084D
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 10:28:53 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/07/2013 10:03 AM, Bard Liao wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>> Sent: Wednesday, August 07, 2013 3:45 PM
>> To: Bard Liao
>> Cc: Mark Brown; Oder Chiou; alsa-devel@alsa-project.org;
>> swarren@nvidia.com; swarren@wwwdotorg.org; lgirdwood@gmail.com; Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: change
>> widgetsequencefordepop
>>
>> On 08/07/2013 07:40 AM, Bard Liao wrote:
>>> Is there any way to run an event when power up/down a
>> snd_soc_dapm_kcontrol type widgt?
>>> Because we need to do something with mute/unmute headphone.
>>> e.g.
>>> rt5640_pmu_depop is what we need when unmute headphone.
>>> We need to set something before and after set the hp mute bit.
>>>
>>> If there is an event to do that, it will be easier to implement that.
>>
>> You can setup a event for the SND_SOC_DAPM_SWITCH, but this will run after
>> setting the mute bit and before clearing the mute bit.
> 
> It seems not to be suitable for me.
> For me, It is better to run before setting the mute bit and after clearing the mute bit, too.

That isn't really supported right now. If muting and unmuting the control is
such a complex sequence maybe it is better to stay with you previous
solution, without autodisable.

- Lars
