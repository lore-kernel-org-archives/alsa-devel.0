From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000718]: unknown symbol on modprobe
Date: Fri, 17 Dec 2004 01:35:18 +0100
Message-ID: <9b1dd149741d9e2a062f940476d22127@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C7CB2265
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2004 01:35:18 +0100 (MET)
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
Kernel Version:             Linux titan.mtaloy.edu 2.6.5-1.358 view.php?id=1 Sat
May 8 09:04:50 EDT 2004 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             12-10-2004 03:18 CET
Last Modified:              12-17-2004 01:35 CET
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
	
	# card https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
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
 tiwai - 12-16-04 18:42 
----------------------------------------------------------------------
When you built the kernel with CONFIG_SND_DEBUG_DETECT, pass
--with-debug=detect option to configure.  When only CONFIG_SND_DEBUG,
--with-debug=full, instead.
Similarly, when CONFIG_SND_VERBOSE_PRINTK is disabled, pass
--disable-verbose-printk option.

----------------------------------------------------------------------
 slonkak - 12-17-04 01:35 
----------------------------------------------------------------------
I will try these.  I would like to keep this ticket open for a while.  My
linux box is at school and I'm home for break.  I won't be able to try
your suggestion until the middle of January...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-04 03:18 slonkak        New Issue                                    
12-10-04 03:18 slonkak        Distribution              => Fedore Core 2   
12-10-04 03:18 slonkak        Kernel Version            => Linux
titan.mtaloy.edu 2.6.5-1.358
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Sat May 8 09:04:50 EDT
2004 i686 athlon i386 GNU/Linux
12-16-04 18:42 tiwai          Note Added: 0002838                          
12-17-04 01:35 slonkak        Note Added: 0002844                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
