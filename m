From: "guan yim" <guanyim@hotmail.com>
Subject: Test: SBLive! (C) 2003 need extra effort on Rear Analog Output
Date: Thu, 25 Mar 2004 16:03:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F45tDqg4Sa38nz0001daa8@hotmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have tested 1.0.3 driver, lib, utils, oss. It looks like Creative SBLive! 
(C) 2001, 2002 and Creative SB Audigy (C) 2001 works well with snd-emu10k1 
driver and alsamixer is able to get them out with 5.1 analog output quite 
easily (all 6 channels have sound output), even without ~/.asoundrc, that's 
just modprobe snd-emu10k1 and play with alsamixer and I got all the channels 
(use alsa-lib/test/pcm to play sine wave on all 6 channels). But SBLive! (C) 
2003 is having trouble with alsamixer to get Rear Analog Audio. No matter 
what I do with Center/Surround/Wave Center/Wave Surround/Headphone/etc, I 
could not get any sound on the Rear Analog Channle.

Is there any specific things that make SBLive! (C) 2003 different from its 
2001 and 2002 batch? Is it only alsamixer uses some wrong name so that it 
cannot access the volume control for Rear Analog Audio?

Is it possible to see what "volume gain register" is alsamixer trying to 
set? Could I have some kind of debug message that alsamixer can show or the 
driver emu10k1 can show?

Thanks.

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
