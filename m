From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Wed, 23 Apr 2008 22:10:45 +0100
Message-ID: <480FA5D5.9090208@warmcat.com>
References: <480C8260.70501@warmcat.com>	<s5hr6czb3po.wl%tiwai@suse.de>	<480CDC26.3010506@warmcat.com>	<s5h63uab2k1.wl%tiwai@suse.de>	<480DC787.9070208@warmcat.com>	<s5h3apeb0gq.wl%tiwai@suse.de>
	<480DCBC6.3050203@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id ADE3E24719
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 23:10:56 +0200 (CEST)
In-Reply-To: <480DCBC6.3050203@warmcat.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Somebody in the thread at some point said:

>> Hm, then the problem is somewhere different.
>> You hear neither from speaker nor HP-jack?
> 
> Nothing, despite changing settings "headphone" and "IEC958" in alsamixer 
> -c0 (alsamixer by itself picks up pulseaudio nowadays apparently).  It's 
> as if the amp is powered down, or we route everything to modem :-) 

Just some derisory extra information, external mic jack is working fine 
(and has bias voltage), Line-jack is also OK, but built-in mic is dead 
with some very small noise, maybe it is not given bias.  If the issue 
was basically power management enabling, it could make sense.

I saw realtek are pretty good with their datasheets, but there is none 
for ALC889 in their ftp site that has the rest.

I also recompiled alsa 1.0.16 for grins but it didn't make any change. 
I looked in alsa-kernel/pci/hda/patch_realtek.c and enabled 
SND_CONFIG_DEBUG and SND_CONFIG_VERBOSE_PRINTK because there seemed to 
be some extra features generated then for ALC device GPIO pin control. 
But they didn't turn up in alsamixer.  Do you know if there is an 
existing way to meddle with GPIO controls on ALC889 from inside ALSA easily?

-Andy
