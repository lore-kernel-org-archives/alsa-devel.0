From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000935]: M-Audio Delta 1010-LT; S/PDIF out = 0Volts on device open
Date: Fri, 30 Dec 2005 23:23:35 +0100
Message-ID: <307bedd6af643b4810ea3d2147607b21@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02D9A148
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:23:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=935> 
======================================================================
Reported By:                stever8
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   935
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Redhat Linux 7.3, modified
Kernel Version:             2.4.26
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-23-2005 20:09 CET
Last Modified:              12-30-2005 23:23 CET
======================================================================
Summary:                    M-Audio Delta 1010-LT; S/PDIF out = 0Volts on device
open
Description: 
Our original report:

When we first load the alsa drivers, we see a S/PDIF output signal from
the 1010LT 
on an oscilloscope. A minidisc player also sees this as a valid signal (it
is all 
zeros, silence).

As soon as our program opens the audio device, however, the signal goes
to 0V on the oscilloscope, and the minidisc of course sees "no signal".
We can't output S/PDIF, no matter what settings we try in Envy24control.

Strangely enough, if we do the following, we do get S/PDIF output :
. Plug in an external S/PDIF input source (which is muted so as not to
mix
with our sound).
. In Envy24control, set the Master Clock to "Word Clock". (it doesn't work
if the 
master clock is set to "S/PDIF")


Jaroslav Kysela suggested:
Strange. Could you try to comment lines:
        //if (reset)        
        //        snd_cs8427_reset(cs8427);

in alsa-kernel/i2c/cs8427.c and test if the signal is present after this
change?

Which I did. The S/PDIF signal no longer goes away (it appears on the
scope, and the minidisc player recognizes it as a valid signal) however it
just contains silence.

======================================================================

----------------------------------------------------------------------
 jdthood - 09-19-05 10:06 
----------------------------------------------------------------------
stever8: Were you able to solve this problem?  Have you tried playing with
the various mixer switches listed by amixer?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:23 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 20:09 stever8        New Issue                                    
02-23-05 20:09 stever8        Distribution              => Redhat Linux 7.3,
modified
02-23-05 20:09 stever8        Kernel Version            => 2.4.26          
09-19-05 10:06 jdthood        Note Added: 0006284                          
12-30-05 23:23 rlrevell       Status                   new => closed       
12-30-05 23:23 rlrevell       Note Added: 0007287                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
