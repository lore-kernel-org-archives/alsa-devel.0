From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002035]: Realtek 861 card not
	functional using included alsa drivers
Date: Tue, 13 Jun 2006 11:32:47 +0200
Message-ID: <cd51c4ff9dc53343ad8edd7d1cee7d31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E125175
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 11:32:48 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2035> 
======================================================================
Reported By:                vertex
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2035
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2080_FC5smp
======================================================================
Date Submitted:             04-18-2006 20:00 CEST
Last Modified:              06-13-2006 11:32 CEST
======================================================================
Summary:                    Realtek 861 card not functional using included alsa
drivers
Description: 
I am using the FC5 drivers to begin with.  The packages are labeled version
1.0.11rc2.  There are only a few options when I run alsamixer. Using the
stock drivers, I have these options:

Headphone switch
CD level
Mic level
Input Source switch(Mic/CD)

I compiled the 1.0.11rc5 drivers from source and rebooted. I now have
these channels when I run alsamixer:

Front switch
CD level
Mic level
Input Source switch(Mic/CD)

I tried compiling the 1.0.9 drivers from Realtek's website(said nothing
about the 861), but they did not build.  In fact, the install script
overwrote my asound libraries requiring a package replacement to get back
to a sane state.

Please let me know if there is something more I can provide.
======================================================================

----------------------------------------------------------------------
 jlpedrosa - 06-12-06 18:22 
----------------------------------------------------------------------
Hi

I have the same problem  with a new laptop (atech) with the same audio
hardware, lspci gives me :
Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller
(rev 02)
(also from Uniwill)
I'm Using suse 10.1 wich uses almost the last alsa-driver, (rc4 i think)
but i tried with the last. I opened the driver and saw the posibilities:
auto, last... but none of them worked.
 
if i put auto option for the module i cat see in /var/log/message:
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

If can i help making any tests or whatever, don't doubt, just ask.



----------------------------------------------------------------------
 jlpedrosa - 06-13-06 11:32 
----------------------------------------------------------------------
I've come back to the original suse Alsadriver.
tried every model for the driver. 
I get exactly the same lime from dmesg:

ALSA sound/pci/hda/hda_codec.c:2097: autoconfig: line_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2101:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2103:    hp=0xb, dig_out=0x0, din_in=0x0
ALSA sound/pci/hda/hda_codec.c:2111:    inputs: mic=0xd, fmic=0x0,
line=0x0, fline=0x0, cd=0x11, aux=0x0

I can't find any BIOS update.
I found a guy saying have solved the problem but he doesen't specify the
model of intel HDA (i also saw similar problems but onn other hda). 
http://www.gidnetwork.com/b-106.html

he says to remove the alsa from kernel ans use latest alsa, but i'm using
suse, and i thinks it's the way suse behaves. Maybe some one more expert
would know if it's useful.

I saw that you wanna try a older live distro... just tell me wich one and
i will.

I don't know if tiwai reeds this (if you do just e-mail me or something so
I know). If anyone knows how to contatc him to offer me to make any test..
tell me

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 20:00 vertex         New Issue                                    
04-18-06 20:00 vertex         Distribution              => Fedora Core 5   
04-18-06 20:00 vertex         Kernel Version            => 2.6.16-1.2080_FC5smp
04-18-06 20:09 rlrevell       Note Added: 0009339                          
04-18-06 20:25 pzad           Note Added: 0009340                          
04-18-06 20:40 vertex         Note Added: 0009342                          
04-18-06 20:50 vertex         Note Added: 0009343                          
04-18-06 22:25 rlrevell       Note Added: 0009345                          
04-18-06 22:32 vertex         Note Added: 0009346                          
04-18-06 22:45 rlrevell       Note Added: 0009347                          
04-18-06 23:02 vertex         Note Added: 0009348                          
04-20-06 14:41 tiwai          Note Added: 0009375                          
04-20-06 20:21 vertex         File Added: modprobe.hda.intel.txt                
   
04-20-06 20:22 vertex         File Added: codec0.during.playback                
   
04-20-06 20:23 vertex         Note Added: 0009398                          
04-21-06 16:50 tiwai          Note Added: 0009416                          
04-21-06 16:51 tiwai          Note Added: 0009417                          
04-21-06 16:54 tiwai          Note Added: 0009418                          
04-21-06 18:56 vertex         Note Added: 0009428                          
04-26-06 00:37 vertex         Note Added: 0009499                          
05-11-06 00:44 vertex         Note Added: 0009755                          
05-11-06 00:46 vertex         File Added: dmesg.debug.txt                    
05-11-06 00:47 vertex         File Added: codec0.noplayback.new                 
  
05-29-06 23:33 taschenorakel  Note Added: 0010015                          
05-30-06 19:11 vertex         Note Added: 0010021                          
05-31-06 20:20 taschenorakel  Note Added: 0010028                          
05-31-06 21:02 vertex         Note Added: 0010029                          
05-31-06 21:06 vertex         Note Added: 0010030                          
05-31-06 22:43 rlrevell       Note Added: 0010032                          
05-31-06 22:51 rlrevell       Note Added: 0010033                          
05-31-06 23:23 vertex         Note Added: 0010035                          
06-01-06 00:30 taschenorakel  Note Added: 0010036                          
06-10-06 14:04 taschenorakel  Note Added: 0010146                          
06-11-06 11:56 jlpedrosa      Note Added: 0010151                          
06-12-06 18:22 jlpedrosa      Note Edited: 0010151                         
06-13-06 11:32 jlpedrosa      Note Added: 0010191                          
======================================================================
