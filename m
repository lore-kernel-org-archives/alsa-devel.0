From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Quattro MIDI
Date: Wed, 23 Oct 2002 21:29:07 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB69613.5020309@boosthardware.com>
References: <s5hbs5m30yi.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0210230913550.5856-100000@studcom.urz.uni-halle.de> <s5h3cqx320w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA04183
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 14:30:19 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 23 Oct 2002 09:37:31 +0200 (METDST),
> Clemens Ladisch wrote:
> 
>>Takashi Iwai wrote:
>>
>>>Clemens Ladisch wrote:
>>>
>>>>It seems the USB subsystem only loads the first id_table entry it finds
>>>>for each interface. As a quick fix, remove the Quattro entry from
>>>>usbquirks.h, but I'm going to write a patch to use both pcm and MIDI.
>>>
>>>ok, i'll remove it.
>>
>>The Quattro id_table entry matches both PCM and MIDI interfaces because I
>>removed the interface class from most entries nine days ago. I did this
>>because my Roland SC-8820 didn't hotplug because the kernel didn't pass
>>the interface class to the hotplug scripts because the device class isn't
>>zero. However, devices with different interfaces do have device class zero
>>(well, I hope they do :), so using the interface class for matching
>>shouldn't prevent hotplugging for these devices.
>>
>>This patch adds interface class matching for some devices with both PCM
>>and MIDI interfaces.
> 
> 
> thanks!
> committed to cvs now.
> 

I haven't tested this patch yet but from last nights cvs I can report 
that the quattro is giving much better results while using jack.

If I run with lowlat and all the options for latency control I can get a 
pure sine wave from ecasound.

Alsaplayer also performs much better.

I will investigate more obviously :)



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
