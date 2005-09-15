From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000718]: unknown symbol on modprobe
Date: Thu, 15 Sep 2005 15:13:40 +0200
Message-ID: <ae9b72c494014ad2d476c254009b2324@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9ACDB176
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:13:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=718> 
======================================================================
Reported By:                slonkak
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   718
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedore Core 2
Kernel Version:             Linux titan.mtaloy.edu 2.6.5-1.358 #1 Sat May 8
09:04:50 EDT 2004 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             12-10-2004 03:18 CET
Last Modified:              09-15-2005 15:13 CEST
======================================================================
Summary:                    unknown symbol on modprobe
Description: 
I have a Sound Blaster Audigy Platinum eX.

My steps:
> Download and unpackage alsa-{driver,lib,utils} in /var/tmp
> modprobe soundcore (I had previously unloaded all sound modules)
> in /var/tmp/alsa-driver-xxxx, ./configure --with-cards=emu10k1
--with-sequencer=yes;make;make install
> ./snddevices
> chmod a+rw /dev/dsp /dev/mixer /dev/sequencer /dev/midi 
> configure, make, and make install utils and lib
> added these to modprobe.conf
        # ALSA portion
        alias char-major-116 snd
        alias snd-card-0 snd-emu10k1
	# module options should go here

        # OSS/Free portion
        alias char-major-14 soundcore
        alias sound-slot-0 snd-card-0
	
	# card #1
	alias sound-service-0-0 snd-mixer-oss
	alias sound-service-0-1 snd-seq-oss
	alias sound-service-0-3 snd-pcm-oss
	alias sound-service-0-8 snd-seq-oss
	alias sound-service-0-12 snd-pcm-oss
> modprobe snd-emu10k1;modprobe snd-pcm-oss;modprobe
snd-mixer-oss;modprobe snd-seq-oss

I get fatal errors on the modprobes (see additional info)
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-15-05 01:29 
----------------------------------------------------------------------
Isn't the platinum eX a USB device?  If so then emu10k1 is the wrong
driver.

----------------------------------------------------------------------
 slonkak - 09-15-05 15:13 
----------------------------------------------------------------------
No, my Platinum eX is a PCI card, with an extension circuitboard that takes
up another PCI slot (but doesn't actually plugin to the PCI slot, it
connects to the main board via what looks like an IDE cable).  My Platinum
eX also has an external device for many, many inputs (optical, spdif,
midi, etc).  That device connects to the extension circuitboard via it's
own (what looks like a parallel, but isn't) cable.

So, to answer your question, my card isn't USB, it's PCI.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-04 03:18 slonkak        New Issue                                    
12-10-04 03:18 slonkak        Distribution              => Fedore Core 2   
12-10-04 03:18 slonkak        Kernel Version            => Linux
titan.mtaloy.edu 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 athlon i386
GNU/Linux
12-16-04 18:42 tiwai          Note Added: 0002838                          
12-17-04 01:35 slonkak        Note Added: 0002844                          
09-14-05 16:08 jdthood        Note Added: 0006174                          
09-15-05 00:26 slonkak        Note Added: 0006188                          
09-15-05 01:29 rlrevell       Note Added: 0006189                          
09-15-05 15:13 slonkak        Note Added: 0006204                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
