From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Test: SBLive! (C) 2003 need extra effort on Rear Analog Output
Date: Fri, 26 Mar 2004 13:40:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <SEA2-F33lIOiyQMGi3t000256a6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




>From: p z oooo <pzad@pobox.sk>
>Reply-To: p z oooo <pzad@pobox.sk>
>To: guanyim@hotmail.com
>CC: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] Test: SBLive! (C) 2003 need extra effort on Rear 
>Analog Output
>Date: Fri, 26 Mar 2004 08:27:57 +0100
>
>In alsa-driver/alsa-kernel/emu10k1/emumixer there are two static
>arrays:
>1) static char *emu10k1_remove_ctls[]
>remove from this array:
>"Surround Playback Switch",
>"Surround Playback Volume",
>
>2)
>static char *emu10k1_rename_ctls[]
>remove from this array:
>"Surround Digital Playback Volume", "Surround Playback Volume",
>
>recompile, you will maybe have these controls in mixer:
>"Surround Digital Playback Volume"
>"Surround Playback Volume"
>
>unmute and set volume for both volume.
>
>If not working - try same with center, and LFE.
>
>If not working - this must be other problem
>
>Peter Zubaj
>


Thanks...I have tried just now. It doesn't work. So alsamixer is indeed 
innocent :)
By the way, I am quite curious that....why suddenly the SBLive 2003 can't 
even be used with alsa 0.9.8, while SBLive 2001, 2002 can... What's the good 
purpose for Creative to do something that makes SBLive 2003 looks like 
another new card ? When using alsa 0.9.8, snd-emu10k1 says it cannot find 
the card :)

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
