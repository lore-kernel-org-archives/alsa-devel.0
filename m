From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002035]: Realtek 861 card not
	functional using included alsa drivers
Date: Wed, 31 May 2006 21:02:17 +0200
Message-ID: <b2e293bcd74724b2dd075a7c968ddfcd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E776C11F
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 21:02:17 +0200 (MEST)
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
Last Modified:              05-31-2006 21:02 CEST
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
 taschenorakel - 05-31-06 20:20 
----------------------------------------------------------------------
GOOD NEWS: There is some version of snd-intel-hda which can produce sound
with this notebook. Bundled with my notebook there was some CD-ROM labled
with "Intervideo InstantOn"
(http://www.kefk.net/Linux/Distributionen/Speziell/InterVideo/index.asp).
It contains some mini Linux for quickly playing media files without
booting a full operating system.

The file C:\InstantON\lib_main contains a MIMIX filesystem containing this
version of snd-intel-hda.ko:

/tmp/m31/alsa-driver-1.0.9b_24a/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c;
compiled for "2.6.13 SMP preempt 686 gcc-3.4".

Checksums:

eee42797c5a4b11d04ac61de26b7ab51  snd-hda-codec.ko
c16bdc4c3f6bc1d77dae76bd752efffc  snd-hda-intel.ko

Now we just have to tell Intervideo to give us their version of
alsa-driver-1.0.9b_24a :-)

----------------------------------------------------------------------
 vertex - 05-31-06 21:02 
----------------------------------------------------------------------
I have contacted someone with Intervideo OEM sales dept. She is going to
try and get me in contact with someone in their engineering department. 
If there is any problem with that, I have the main contact for their legal
department. Seeing as how these drivers are released under the gpl, they
are legally obligated to provide source code for their modifications.

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
======================================================================
