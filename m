From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000718]: unknown symbol on modprobe
Date: Tue, 18 Jul 2006 20:27:25 +0200
Message-ID: <5bdd46b685b80b7178df4588ee30c156@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4542421F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:27:25 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=718> 
======================================================================
Reported By:                slonkak
Assigned To:                jcdutton
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
Last Modified:              07-18-2006 20:27 CEST
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

----------------------------------------------------------------------
 jdthood - 09-14-05 16:08 
----------------------------------------------------------------------
Submitter: So, did you fix the problem?

----------------------------------------------------------------------
 slonkak - 09-15-05 00:26 
----------------------------------------------------------------------
No, that did not fix the problem.  I got frustrated and just started using
the onboard sound instead.  That worked out of the box.  Go ahead and
close this ticket.  If I play anymore with this, it'll be on my own
time...

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
07-18-06 20:21 pzad           Assigned To              pzad =>             
07-18-06 20:27 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
