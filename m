From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: amixer cget :Assertion `ctl && info &&
 (info->id.name[0] || info->id.numid)' failed. Aborted
Date: Wed, 05 Oct 2011 09:59:42 +0200
Message-ID: <4E8C0E6E.2000700@perex.cz>
References: <CAN8cciZmMsDx+0tX8izFzXpLPpSD2YS==BN=oG0KWFg9rBaxOA@mail.gmail.com>
	<s5hzkhiqj5q.wl%tiwai@suse.de>
	<CAN8ccib5ymF1DLMBLdmO-hc9FtHHJ9nV=kWgQ-zDEJnKQ59f+g@mail.gmail.com>
	<s5hobxvyj78.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EB091038BB
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:59:44 +0200 (CEST)
In-Reply-To: <s5hobxvyj78.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 5.10.2011 09:46, Takashi Iwai wrote:
> At Wed, 5 Oct 2011 15:25:44 +0800,
> Raymond Yau wrote:
>>
>> 2011/10/3 Takashi Iwai <tiwai@suse.de>:
>>> At Sat, 1 Oct 2011 11:30:44 +0800,
>>> Raymond Yau wrote:
>>>>
>>>> There is assertion when specify iface=PCM  or iface=PCM,name='' when
>>>> using amixer -c0 cget
>>>>
>>>> according to the synthax
>>>>
>>>> [[iface=<iface>,][name='name',][index=<index>,][device=<device>,][subdevice=<subdevice>]]|[numid=<numid>]
>>>>
>>>>
>>>> amixer -c0 cget iface=PCM
>>>> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>>>> (info->id.name[0] || info->id.numid)' failed.
>>>> Aborted
>>>>
>>>> amixer -c0 cget iface=PCM,name=''
>>>> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>>>> (info->id.name[0] || info->id.numid)' failed.
>>>> Aborted
>>>
>>> So, the empty string isn't checked before assert().  It's bad.
>>> It must be easy to fix.  Care to create and send a patch?
>>>
>>>
>>
>> The syntax seem also wrong.
>>
>> [[iface=<iface>,][name='name',][index=<index>,][device=<device>,][subdevice=subdevice>]]|[numid=<numid>]
>>
>>
>> it should be
>>  [numid=<numid>] |
>>  [[iface=<iface>,name='name'][,index=<index>][,device=<device>]] |
>>  [[iface=<iface>,name='name'][,device=<device>][,subdevice=<subdevice>]]
>>
>> since you cannot specify index and subdevice at the same time
> 
> The index and subdevice are different things.
> Typically, the index is set > 0 when multiple elements with the same
> iface and name are present.  The subdevice is rather specification of
> the device itself, e.g. PCM substream number.

The correct syntax should be:

[[iface=<iface>,]name='name'[,index=<index>,][device=<device>,][subdevice=subdevice>]]
OR numid=<numid>

The name or numid is mandatory.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
