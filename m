From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 10:14:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F107fcGuKeddZR0003dbb2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (sea2-f10.sea2.hotmail.com [207.68.165.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA08747
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 10:15:23 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The way I tested that channels is using alsa-lib/test/pcm -c6 -v , this 
should be ok rite? Anyway it can produce 440Hz sound, namely "tone A" on all 
six channels when I am using SBLive 2001, 2002 and Audigy 2001.

I think I don't understand how the module snd-oss-mixer / snd-oss-pcm will 
help; I compile and make install alsa-oss-1.0.4rc1.tar.bz2 without problem. 
I used the aumix and alsamixer, but I could only get Front L/R and 
Centre/Subwoofer analog channel output after the suggested changes make into 
alsa-kernel/pci/ac97/ac97_codec.c . Please advice.

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
