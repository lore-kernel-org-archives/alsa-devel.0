From: Richard Chan <rspchan@starhub.net.sg>
Subject: Re: Recent regression of ALC655 on VIA
Date: Sat, 17 Apr 2004 21:03:19 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40812B17.3090308@starhub.net.sg>
References: <407F8A76.1000907@starhub.net.sg> <s5hn05cro2k.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from eastgate.starhub.net.sg (eastgate.starhub.net.sg [203.116.1.189])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12437
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2004 15:03:30 +0200
In-reply-to: <s5hn05cro2k.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Your patch has fixed the problem - 5.1 is working again and I can set
the 'Mic As Center/LFE' control. Thank you.

Takashi Iwai wrote:

>At Fri, 16 Apr 2004 15:25:42 +0800,
>R CHAN wrote:
>  
>
>>Hi, recent Alsa changes (ac97_patch.c) seem to have broken my
>>ALC655 ac97 codec on via82xx. The breakage happened around 2.6.5.
>>
>>Specifically, I can no longer set
>>
>>Mic As Center/LFE control
>>
>>Unlike Line-In As Surround it is now reported
>>as a volume control with Mono values from 0-0.
>>Can't set that bit at all.
>>    
>>
>
>try the attached patch.
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
