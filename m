From: "guan yim" <guanyim@hotmail.com>
Subject: 0.9.8 lib + 1.0.6a driver + old sblive = no ac3 passthrough
Date: Tue, 14 Dec 2004 06:20:48 +0200
Message-ID: <BAY22-F28708B2255DC9FF4966C4BAFAC0@phx.gbl>
References: <645ab6912a4317dc73d71a8a0fbddade@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (bay22-f28.bay22.hotmail.com [64.4.16.78])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BFACD28D
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2004 05:21:34 +0100 (MET)
In-Reply-To: <645ab6912a4317dc73d71a8a0fbddade@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: pranay_k@hotmail.com
List-Id: alsa-devel@alsa-project.org

Hi all,

When I use alsa-tools-0.9.8/ac3dec to play an ac3 file with passthrough 
option, it gives me the following messages:

Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
ALSA lib pcm_hw.c:1055:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No 
such device
snd_pcm_open: No such device
Output open failed


I am using 0.9.8 lib + 1.0.6a driver + old sblive (chip: eMicro 28028) . 
However if I use everything in 0.9.8 it is ok. I check the file  
/dev/snd/pcmC0D3p  and it is indeed there. Why I couldn't mix different 
version of lib and driver? Please tell me the reason.

Thanks
guanyim

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
