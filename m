From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001132]: Realtek ALC260, snd-hda-intel, 2.4.21-32, catastrophic CrAsH
Date: Thu, 2 Jun 2005 00:27:30 +0200
Message-ID: <644ae174960fabd18a4e5cb8818e21af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B9DD1A4
	for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2005 00:27:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1132> 
======================================================================
Reported By:                speedking
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1132
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     feedback
Distribution:               RHEL 3 U5 gold
Kernel Version:             2.4.21-32
======================================================================
Date Submitted:             05-28-2005 02:02 CEST
Last Modified:              06-02-2005 00:27 CEST
======================================================================
Summary:                    Realtek ALC260, snd-hda-intel, 2.4.21-32,
catastrophic CrAsH
Description: 
system hangs when either 'alsaconf' runs or you attempt a 'modprobe
snd-hda-intel'

System is a HP xw4300 workstation, Intel based, running an Azalia
compliant" "Intel High definition Audio" Realtek ALC 260 chip onboard.




======================================================================

----------------------------------------------------------------------
 speedking - 05-31-05 22:46 
----------------------------------------------------------------------
So I have myself this fancy script to build all the ALSA components I need
including a 'jack-audio-connection-kit' to sense when the headphones are
plugged in.  So, I went back to the basics and copied my 1.0.9 bz2 files
to /usr/src/alsa and ran a './configure;make;make install' on driver, lib,
and utils.  I followed that up with a 'modprobe snd-emu10k1;modprobe
snd-pcm-oss;modprobe snd-mixer-oss;modprobe snd-seq-oss and sure enough,
the Audigy 2ZS card works.

So...I removed the card, rebooted, and went back into my /usr/src/alsa
directory.  Starting in the drivers directory I tried a 'make
clean;./configure;make;make install' and got failures up the wazoo.  So I
then skipped the 'make clean' and just did a './configure;make;make
install' for each driver, lib, and util which was successful.  I followed
that up with a 'modprobe snd-hda-intel;modprobe snd-pcm-oss;modprobe
snd-mixer-oss;modprobe snd-seq-oss' and I can get .wav files to play out
of the externel speaker.  Headphone is not working.

I can't however get any music to play off the CD player through the ALC260
chip.  I could get the CD to play through the Audigy 2ZS card however.

Any idea where to look for what's wrong with the CD player.  The CD player
is connected to the motherboard appropriately, the CD plays with the RHEL3
CD player, but alsamixer only gets hissing out of the external speaker
through the 'mono' channel.



----------------------------------------------------------------------
 speedking - 06-02-05 00:27 
----------------------------------------------------------------------
I have now verified that RHEL 4 U1 beta 2 x86_64 bits along with ALSA 1.0.9
final also do NOT play CD music, just like RHEL3 U5 x86_64 gold bits.  

The CD player or audio player that is OEM to RHEL4/RHEL3 plays the CD, you
can hear the CD player mechanically run, the 'read' light on the front of
the CD player blinks, the CD player application counts the tracks but no
music emenates from either the external speaker or the headphone jack.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 02:02 speedking      New Issue                                    
05-28-05 02:02 speedking      Distribution              => RHEL 3 U5 gold  
05-28-05 02:02 speedking      Kernel Version            => 2.4.21-32       
05-31-05 12:58 tiwai          Status                   assigned => resolved
05-31-05 12:58 tiwai          Resolution               open => fixed       
05-31-05 12:58 tiwai          Note Added: 0004825                          
05-31-05 19:10 speedking      Status                   resolved => feedback
05-31-05 19:10 speedking      Resolution               fixed => reopened   
05-31-05 19:10 speedking      Note Added: 0004848                          
05-31-05 19:11 speedking      Note Edited: 0004848                         
05-31-05 19:14 speedking      Note Edited: 0004848                         
05-31-05 19:15 tiwai          Note Added: 0004849                          
05-31-05 19:23 speedking      Note Added: 0004850                          
05-31-05 19:26 speedking      Note Edited: 0004850                         
05-31-05 19:26 tiwai          Note Added: 0004851                          
05-31-05 19:44 speedking      Note Added: 0004852                          
05-31-05 19:51 tiwai          Note Added: 0004853                          
05-31-05 20:11 speedking      Note Added: 0004854                          
05-31-05 22:43 speedking      Note Added: 0004856                          
05-31-05 22:46 speedking      Note Edited: 0004856                         
06-02-05 00:27 speedking      Note Added: 0004872                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
