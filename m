From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001633]: Unable to get MIDI working with NForce2/Soundstorm
Date: Sat, 10 Dec 2005 23:03:04 +0100
Message-ID: <e33a137d050e4882a31d8e0112c4362a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF70216F
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 23:03:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1633> 
======================================================================
Reported By:                rjohnson
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1633
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-r2
======================================================================
Date Submitted:             12-10-2005 04:33 CET
Last Modified:              12-10-2005 23:03 CET
======================================================================
Summary:                    Unable to get MIDI working with NForce2/Soundstorm
Description: 
As near as I have been able to determine, the Nforce2 chip has on-board
MIDI capabilities, possibly using DLS sound banks.  After a great deal of
research, I found, according to
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Nvidia&card=.&chip=nForce&module=intel8x0,
that I want to add the option mpu_port=0x330 in my alsa conf file. 
However, after finally ditching the kernel drivers for the latest
alsa-driver gentoo module, which is also evidently the latest offering
available, I get the error: FATAL: Error inserting snd_intel8x0
(/lib/modules/2.6.12-gentoo-r9/alsa-driver/pci/snd-intel8x0.ko): Unknown
symbol in module, or unknown parameter
without fail.  Modinfo snd_intel8x0 makes no mention of the mpu_port
option, nor does the info for the module indicate any particular version
of the snd-intel8x0 module I'm using.
I did come across one other site that stated that midi was no longer
supported by snd-intel8x0, and to try snd-mpu401 instead.  However, that
gives me the modprobe error no such device.
What am I missing?
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-10-05 20:02 
----------------------------------------------------------------------
There are many, many varieties of intel8x0 hardware.  Does your board
physically have a game/MIDI port on it?  If so, is it enabled in the
BIOS?

Anyway as for the DLS synthesizer, Nvidia does not release any docs at
all, so unless you specifically hear otherwise, you should assume that
such features are UNsupported.  We don't even know for sure whether the
synth is actually in hardware or (more likely) whether it's implemented in
software by the Windows driver.

----------------------------------------------------------------------
 rjohnson - 12-10-05 23:03 
----------------------------------------------------------------------
No, it does not have a physical 15-pin game port.  I was merely hoping to
get the internal synthesizer working.

I know that Nvidia releases their own non-GPL audio drivers, but of the
one entry I saw online where someone attempted that to address the same
problem using Nvidia's drivers with alsa also failed.

I do thank you for your help, though.  Again, all of what I was finding
was  inconclusive, and I didn't know where else to turn to find out
definitively if there was any way for this to work.  And now I know.

Thanks again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 04:33 rjohnson       New Issue                                    
12-10-05 04:33 rjohnson       Distribution              => Gentoo          
12-10-05 04:33 rjohnson       Kernel Version            => 2.6.14-r2       
12-10-05 04:46 rlrevell       Note Added: 0006971                          
12-10-05 16:50 rjohnson       Note Added: 0006972                          
12-10-05 20:02 rlrevell       Note Added: 0006973                          
12-10-05 23:03 rjohnson       Note Added: 0006974                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
