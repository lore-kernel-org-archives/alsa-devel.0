From: CAG <cag@fsk-hh.org>
Subject: Re: M-Delta Audiophile 192 (ice1724) Recording
Date: Mon, 04 Feb 2008 18:37:48 +0100
Message-ID: <47A74D6C.9030100@fsk-hh.org>
References: <47A24665.80402@fsk-hh.org>	<47A250E7.8040005@fsk-hh.org>	<s5hd4rg3m7x.wl%tiwai@suse.de>	<47A721AE.6090205@fsk-hh.org>
	<s5hejbs3gqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id CAD3E10380E
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 18:40:12 +0100 (CET)
In-Reply-To: <s5hejbs3gqm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



Takashi Iwai schrieb:
> At Mon, 04 Feb 2008 15:31:10 +0100,
> CAG wrote:
>> hi,
>>
>> Takashi Iwai schrieb:
>>> At Thu, 31 Jan 2008 23:51:19 +0100,
>>> Computer AG im FSK wrote:
>>>> Hi,
>>>>
>>>> I  forget to mention that we patched
>>>> /usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c
>>>> instead of
>>>> /usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c
>>>>
>>>> because /usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c is just
>>>> 3 lines long or so and looks like including
>>>> /usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c.
>>>>
>>>> Does this matter ?
>>> No, it's the right place to apply.
>>>
>>> So far, I have no further idea what could be wrong.  It's really hard
>>> to debug remotely without hardware and without any datasheet... >
>>>
>>> Takashi
>> We get this card working with O.S.S., recording works now. Anyway, OSS 
>> is not our preferred sound system...
> 
> If the GPL'ed version of OSS works, then we can see the driver code.
> Could you check whether it works?  If we have a reference source, it
> will be greatly helpful to debug.
Ok, we will check this this week. I found a link to "Envy24 under 
FreeBSD", where details specs and the driver code are listed:
http://envy24.svobodno.com/driver/envy24ht/

But I will get back to you as soon as we tested the GPL Version.

> 
>> We would like to know if there will be future development for this card. 
>> We bought 4 cards for our studio, it really would help us out.
>>
>> Is there any way to support the alsa project to fix this issue ? What 
>> about our offer to lend a card for development ? Our finances aren't 
>> very well but  we could also think about a small donation for hardware 
>> i.e.
> 
> Well, the problem is another one - the lack of the hardware
> information such as datasheet.  The codec chip itself is known but the
> connection of the chip is unknown.  This is what M-audio knows at
> best.  Or you can track the pin connections on your board...
> 
> Above all, the most missing thing for me is the time.  I'm willing to
> help you but have likely too little time.  I hope someone else could
> help more intensively...
Well I can imagine... :)

Toast
> 
> 
> Takashi
