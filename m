From: R CHAN <rspchan@starhub.net.sg>
Subject: Recent regression of ALC655 on VIA
Date: Fri, 16 Apr 2004 15:25:42 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407F8A76.1000907@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trantor.dso.org.sg (trantor.dso.org.sg [192.190.204.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA08761
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2004 09:28:05 +0200
Received: from escada.dso.org.sg (escada.dso.org.sg [192.190.204.10])
	by trantor.dso.org.sg (8.12.11/8.12.11) with ESMTP id i3G7Pvq9001501
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2004 15:25:59 +0800 (SGT)
Received: from starhub.net.sg ([172.18.118.105])
	by escada.dso.org.sg (8.12.10/8.12.10) with ESMTP id i3G7QYPY008828
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2004 15:26:35 +0800 (SGT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi, recent Alsa changes (ac97_patch.c) seem to have broken my
ALC655 ac97 codec on via82xx. The breakage happened around 2.6.5.

Specifically, I can no longer set

Mic As Center/LFE control

Unlike Line-In As Surround it is now reported
as a volume control with Mono values from 0-0.
Can't set that bit at all.

Secondly, I can't get 5.1 sound at all - though
duplicate front does work.

Previously, I tested surround and center/lfe using the following
plugs. I was able to test them as stereo pairs - now I can't get
sound using them at. Any suggestions?

#setup 5.1 device using hw:0,1
#Device 0 is stereo
#Device 1 is 5.1
pcm.via51
{
	type plug;
	slave {
		pcm "hw:0,1";
		channels 6;
		rate 48000;
	}
}

#Streams 2,3 = surround speakers
pcm.via23
{
	type plug;
	slave via51;
	ttable.2.0 1;
	ttable.3.1 1;
}

#Streams 4,5 = center/lfe speakers
pcm.via45
{
	type plug;
	slave via51;
	ttable.4.0 1;
	ttable.5.1 1;
	
}








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
