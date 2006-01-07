From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001697]: Sound does not work
Date: Sat, 7 Jan 2006 01:26:01 +0100
Message-ID: <3a56ca4e05d11a02a5d584e27feb51b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD3FA128
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 01:26:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1697> 
======================================================================
Reported By:                rkoenig
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1697
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               doesn't matter
Kernel Version:             doesn't matter
======================================================================
Date Submitted:             01-01-2006 10:27 CET
Last Modified:              01-07-2006 01:26 CET
======================================================================
Summary:                    Sound does not work
Description: 
The SiS 7012 based sound controllers on all the mainboards of Fujitsu
Siemens Computers refuse to work. 

The reason is that the hardware setup is done in a way so that the codec
is the tertiary codec. Problem is that during initialisation the
snd_intel8x0 driver checks the ready bit for the tertiary codec on bit 28
of the global status register, but on SiS 7012 the codec ready status is
set in bit 18. But even fixing that in source doesn't help much because
the driver has to many branches that are depending on the chip type
(INTEL, SIS, whatever) so that I get a codec ready, but then subsequent
errors from the codecs.


======================================================================

----------------------------------------------------------------------
 sashak - 01-07-06 01:26 
----------------------------------------------------------------------
You are about sound (intel8x0) and not modem (intel8x0m) driver? (This
report was opened for intel8x0m - modem driver).

About the problem itself. Is this general feature(s) of SiS7012 or
something specific for FS machines (AFAIK SiS7012 data sheet is not
published)? Which errors do you have after ICH_TCR redefine?

And about driver split I think it is not needed just because different
ICH_TCR values - this may be solved in current driver. And anyway I don't
have reference hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-01-06 10:27 rkoenig        New Issue                                    
01-01-06 10:27 rkoenig        Distribution              => doesn't matter  
01-01-06 10:27 rkoenig        Kernel Version            => doesn't matter  
01-07-06 01:26 sashak         Note Added: 0007500                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
