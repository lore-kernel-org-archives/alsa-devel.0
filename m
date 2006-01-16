From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001733]: Intel HDA Modem ?
Date: Mon, 16 Jan 2006 20:19:39 +0100
Message-ID: <ff7627a7b2b91a35243370d1f7cc764e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D62BE10E
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 20:19:39 +0100 (MET)
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
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733> 
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              01-16-2006 20:19 CET
======================================================================
Summary:                    Intel HDA Modem ?
Description: 
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

----------------------------------------------------------------------
 sashak - 01-13-06 00:16 
----------------------------------------------------------------------
> Can you send it

Sent.

----------------------------------------------------------------------
 chrmue - 01-16-06 20:19 
----------------------------------------------------------------------
thanks for the file! (the downloading problem was Internet Explorer
related! It seems that IE has problems getting small plain-text files!!!
That's another reason for getting this Modem to work in Linux!!!)

I applied it to the 1.0.11rc2 of alsa-driver release (had no CVS handy and
didn't wanted to download 15MB with analog) - seemed to fit well there
too.
And it worked! - i couldn't test it at this moment because i ran into
other problems with my wlan-card. In the end i had to apply irqpoll as
kernel-parameter, and while testing this my system once froze at booting
printing this message hundrets of times:

Jan 16 11:36:19 schmuckstueck kernel: ALSA
/usr/src/alsa/alsa-driver-1.0.11rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:520:
azx_get_response timeout

After i got the irq-problem fixed this was gone (my wlan now works well
too! but still i need the modem at my parents...)
btw: now the message appears again when starting jackd but doesn't freeze
(even jack is working!)
so i didn't bother anymore, but could this happen because i used the
release not the CVS? or is this irq-related?

anyway - my system now works fine with all hardware (had to patch yenta
too, but this is another story).

back to the modem aplay -l now gives me:
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC880 Digital [ALC880 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

-- Yipiiee!
But i went off-hook on bootup, which i found out was KMix! IT turned the
new recognized switch "Off-hook" on by default (this was the same with the
IEC958-Switch as i got to the release where it was introduced), so i
turned it off shut down kde (to save this settting) and voila! (good thing
that i saw the switches this moment!)

Then i got slmodemd running (just "slmodemd -a" didn't work - it assumes
modem:1 by default, but "slmodemd -a modem:0" works well!)
After a few tries i found out that i had to disconnect the telephone line
after an connection (or attempt) else NO DIALTONE was the result. I looked
at the switches in alsamixer and found out that the Off-hook switch STAYS
ON after slmodemd has got an disconnect (on serial side there is no
problem - on disconnect slmodemd gives NO CARRIER and gets back to
AT-Command mode and after switching the Off-hook switch off in alsamixer
or temporarily disconnecting the telephone-line i can connect again)

Now i got to: "connecting to my ISP via pppd"
After some unsuccessful tries, i found out that i had to switch Caller-Id
off for connecting to my ISP - What's this switch good for?
So i got CONNECTED!!!! momentary sending this message over it!

For the Off-hook-thing i got " disconnect "amixer sset Off-hook off >
/dev/null" " in my /etc/ppp/options, but this only works with pppd, which
is okay for me. (it just prevents me from staying off-hook after pppd has
disconnected by timeout, because i was fallen asleep viewing a website at
6 o' clock in the morning)

A good thing would be also to hear the negotiation process in the speakers
(in Windows there is a helper-program - agrsmmsg.exe . I suppose it
captures the sound from modem-line and plays it back thru the normal PCM
until connected. If I don't start this exe in windows i don't hear the
negotiation too (but get connected anyway))

But this far THANK YOU very very much. It is a good thing to got my
Notebook working with all hardware i need in linux, so again thank you for
the modem.

PS: speed is quite good: i get connections with 40-48kbit/s (as negotiated
speed) - at the moment 46667 - and downloading an 1.5MB file was done with
4.3KByte/s. In Windows i got 52kbit/s most times, but 40 is absolutely
okay for me. The download seemed to "hang" temporarily sometimes, but the
connection was stable. I suppose this is slmodemd-related (same with the
speed), but okay for me. (I think i saw these "hang"s in windows too, so
maybe it's my ISP...)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 07:23 chrmue         New Issue                                    
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0 
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15       
01-11-06 07:42 rlrevell       Note Added: 0007559                          
01-11-06 23:32 sashak         File Added: hda-modem-si3054-11c13026.patch       
            
01-11-06 23:35 sashak         Note Added: 0007571                          
01-12-06 00:00 sashak         Note Added: 0007574                          
01-12-06 00:02 sashak         Issue Monitored: sashak                      
01-12-06 05:35 chrmue         Note Added: 0007581                          
01-13-06 00:16 sashak         Note Added: 0007598                          
01-16-06 20:19 chrmue         Note Added: 0007692                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
