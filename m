From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: [ALSA - driver 0001047]: module hangs at
 seemingly random times
Date: Mon, 01 Aug 2005 01:15:36 +0800
Message-ID: <42ED0738.7090201@netvigator.com>
References: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org> <42EC84DE.4050306@netvigator.com> <200507311438.59443.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200507311438.59443.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Although au8810, au8820 and au8830 have 16 Sample Rate Convertors.

For au8820 and au8830 driver, snd_pcm_hw_params() will return "no more 
mixer error" and "no more sample rate convertor error" before all 
configured substreams are opened.

It seem to me that au8810's problem is related to snd_pcm_open()
after all configured substreams are opened.

May be you can change NR_ADB from 0x10 to 0x20 (a dirty workaround) ?


Alien wrote:
> I'm not too sure, but i _can_ tell you that lastly i had two weird errors 
> about something adb, when snd-au8810 didn't play any sound anymore, i was 
> able to kill all apps who use sound and modprobe -r snd-au8810, and modprobe 
> again, and without reboot i was able to get sound working again.
> 

In your case, if there are one or more stereo stream playing, 
snd_pcm_hw_params() will return "no more sample rate convertor error" 
before all configured substreams are opened.


> I must say that i haven't been on this PC much and haven't had much time to 
> test these things, allthough i'm planning too, (but i think i'll update CVS 
> first with these 2 patches who got lost accidentally before i test this. I 
> hope i'll get some time this week(end).

Igor V. Kovalenko already include the two lost patches in his patch to 
fix oopses on amd64

> 
> thanks for all the help and info concerning snd-au8810 (in 64bit)
> 
> AL13N
> 
> Op zondag 31 juli 2005 09:59, schreef Raymond:
> 
>>If there are 16 instances of aplay playing mono stream.
>>
>>What error will be returned by snd_pcm_open() for the 17th instance of
>>aplay ?
>>
>>
>>
>>alsa-kernel/pci/au88x0/au8810.h
>>
>>#define NR_ADB   0x10
>>
>>alsa-kernel/pci/au88x0/au8830.h
>>
>>#define NR_ADB   0x20
>>
>>
>>alsa-kernel/pci/au88x0/au88x0.c
>>
>>	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
>>		snd_card_free(card);
>>		return err;
>>	}
>>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
