From: "Bradee-oh!" <bradeeoh@bradeeoh.com>
Subject: Advanced 5.1 + DMIX configuration problems...
Date: Mon, 24 May 2004 17:26:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B29299.7000407@bradeeoh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from backup.rwgusa.net (smtp.rwgusa.net [66.240.200.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA19278
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2004 02:23:59 +0200
Received: from mail.rwgusa.net (mail [10.1.1.5])
	by backup.rwgusa.net (8.12.8/8.12.8) with ESMTP id i4P0Nush002650
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2004 17:23:57 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've posted the following message on the alsa-user list a few times and 
gotten no response.  Especially since it's a fairly complicated setup 
and probably a rare one that could reveal certain bugs that wouldn't be 
found otherwise, I thought I'd give the development list a shot so the 
people who know the nitty-gritty under the hood stuff can comment

-----

I first started experimenting with the stereo -> 5.1 configuration and
got it to work great!

Then in the interests of everyone sharing the card, I fiddled around
with dmixing the new 5.1 device and succeeded - now stereo apps are
upmixed to 5.1, share with each other, AND share with real 5.1 apps.

Then I tried to throw OSS into the mix using AOSS.  Here's where my
problem is...

A stereo OSS app DOES work in the configuration - for a very short
amount of time.  After a variable amount of time (1 to 5 minutes,
roughly) the OSS app will be cruising along and then the next time it
tries to play a sound, it will freeze.  Not because the sound card is
blocked, because it happens when nothing else is accessing the card.
But, in the process of freezing, it does block the sound card as nothing
else (ALSA or OSS) can use it until I kill the OSS app.

After it happens once, it seems to happen very quickly every subsequent
time until I reboot.  By very quickly, I mean the OSS app may get one or
two sounds off before it freezes 10 seconds into execution.

Here is the asound.conf I am using -

pcm.!default{
   type plug
   slave.pcm "dsp0"
}

pcm.dsp0{
   type plug
   slave {
     pcm "mixed51"
     channels 6
     rate 48000
   }
   ttable.0.0 1
   ttable.1.1 1
   ttable.0.2 1
   ttable.1.3 1
   ttable.0.4 0.2
   ttable.1.4 0.2
   ttable.0.5 0.5
   ttable.1.5 0.5
}

pcm.mixed51 {
   type dmix
   ipc_key 1099234
   ipc_key_add_uid TRUE
   slave {
     pcm "hw:0,1"
     rate 48000
     channels 6
     period_time 0
     period_size 1024
     buffer_time 0
     buffer_size 4096
   }
}

ctl.mixer0 {
   type hw
   card 0
}

My soundcard is a CMIPCI (8738) and I am running ALSA 1.04_rc2, as
included in kernel 2.6.5.  Notice the hardware device is hw:0,1 as that
is the 5.1 device for this card.

The way I use this setup is as follows -

-OSS apps using AOSS obviously route directly to dsp0.  That upmixes the
stereo to 5.1 then uses mixed51 to dmix it.

-Stereo ALSA apps using the default PCM get rerouted to dsp0, or
alternately I tell them specifically to use dsp0

-5.1 ALSA apps I tell to use mixed51 directly as they don't need the
stereo->5.1 hack but DO need to share the card via dmix


Any explanations or solutions are MUCH appreciated - even if the 
official developer explanation is "don't do that, it doesn't work"   tia

-Brady
---
[This E-mail has been scanned by Declude Virus running on mail.rwgusa.net and is virus-free]



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
