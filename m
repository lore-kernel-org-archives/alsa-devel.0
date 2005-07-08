From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000416]: Signal but no sound on digital out (Nforce 1)
Date: Fri, 8 Jul 2005 10:37:44 +0200
Message-ID: <ffbb2c2b4eba31106ff45f38bb848f2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1C9F18F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:44 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=416> 
======================================================================
Reported By:                bonbons
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   416
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               SuSE 9.0
Kernel Version:             2.4.26
Resolution:                 duplicate
Duplicate:                  411
Fixed in Version:           
======================================================================
Date Submitted:             07-31-2004 21:46 CEST
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    Signal but no sound on digital out (Nforce 1)
Description: 
Independently of the status of the "Digital" element in alsamixer (muted or
not) my digital reciever connected to the Digital output of my mainboard
displays availability of PCM signal, but the sound output to my
head-phones through Line-Out is not available on the digital out.

There is no sound at all output to the digital out, no matter what
selections are done in AlsaMixer.

Is there a means to switch output mode of digital output to DolbyDigital
as under Windows and really switch of the Digital output?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000411 IEC958 status non-audio (and others) bi...
======================================================================

----------------------------------------------------------------------
 bonbons - 04-10-05 23:50 
----------------------------------------------------------------------
With drivers with kernel 2.6.10 (1.0.6) the digital output was never
switched off, no matter what mixer settings were (using alsamixer)

I did test with drives included with Linux-2.6.11 kernel release (1.0.8):

No mixer item has effect on the output to digital out

I was playing sound with this command:
aplay -D plughw:0,2 file.wav

At same time on other console a toggled the mute flags on each channel
individually (using alsamixer), sound output was not muted at all, and
volume changes had no effect either.


PS: How can I test 5.1 channel output to digital out? As all playback I
currently got is stereo PCM
PS2: Since previous note I changed distribution from SuSE to Gentoo



----------------------------------------------------------------------
 tiwai - 04-12-05 16:37 
----------------------------------------------------------------------
The non-audio SPDIF output has never worked properly on nForce because of
lack of hardware information.  Try to complain Nvidia, so that we'll get
the necessary information to program the driver code...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-04 21:46 bonbons        New Issue                                    
07-31-04 21:46 bonbons        Distribution              => SuSE 9.0        
07-31-04 21:46 bonbons        Kernel Version            => 2.4.26          
08-01-04 18:19 bonbons        Note Added: 0001517                          
04-08-05 22:34 jdthood        Note Added: 0004378                          
04-10-05 23:49 bonbons        Note Added: 0004440                          
04-10-05 23:50 bonbons        Note Edited: 0004440                         
04-11-05 09:43 jdthood        Status                   new => acknowledged 
04-12-05 16:37 tiwai          Note Added: 0004449                          
04-12-05 17:17 tiwai          Relationship added       duplicate of 0000411
04-12-05 17:17 tiwai          Duplicate ID             0 => 411            
04-12-05 17:17 tiwai          Status                   acknowledged => resolved
04-12-05 17:17 tiwai          Resolution               open => duplicate   
04-12-05 17:17 tiwai          Assigned To               => tiwai           
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
