From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001529]: hardware mixing does not work with spdif
Date: Thu, 10 Nov 2005 21:50:09 +0100
Message-ID: <c8ee2f2b86639baeae8db05b2e639230@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1029E184
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 21:50:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1529> 
======================================================================
Reported By:                visit0r
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1529
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Unstable
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-05-2005 14:24 CET
Last Modified:              11-10-2005 21:50 CET
======================================================================
Summary:                    hardware mixing does not work with spdif
Description: 
I'm using SB Live! with s/pdif passthrough for PCM and AC3. 

It works fine for a single application when I use 'spdif' as a device, but
 hardware mixing does not work. It has never worked for me, thus I thought

previously it's just not supported in my card revision for some reason.
After I upgraded my kernel to 2.6.14, the hardware mixing suddenly started
to work with the 'default' device. 

Now it stopped working again, 'default' device does not produce sounds at
all, and I have to use 'spdif' using which hardware mixing does not work
(only one app may play sounds at once). I have no idea what made it stop,
possibly some
Debian Unstable package upgrade broke it.

I'd appreciate any pointers for solving this long standing problem of
mine.

I have installed a new alsalib (1.0.10rc2) from Debian Experimental, so it

should not be the reason.

Thanks.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-10-05 19:12 
----------------------------------------------------------------------
OK, point taken
Then "spdif" device isn't appropriate because it outputs via a special PCM
device (hw:0,2) for raw output to avoid the modification of data.

You may output to SPDIF from hw:0,0 and toggling "IEC958 Optical Raw"
switch manually (may need "SB Live Analog/Digital Output Jack", too).

----------------------------------------------------------------------
 visit0r - 11-10-05 21:50 
----------------------------------------------------------------------
It seems to work. Disabling IEC958 Optical Raw was the solution. Thanks a
lot! This issue can be now closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-05 14:24 visit0r        New Issue                                    
11-05-05 14:24 visit0r        Distribution              => Debian Unstable 
11-05-05 14:24 visit0r        Kernel Version            => 2.6.14          
11-05-05 14:27 visit0r        Issue Monitored: visit0r                     
11-08-05 18:38 tiwai          Note Added: 0006634                          
11-08-05 19:26 visit0r        Note Added: 0006639                          
11-08-05 19:56 visit0r        Note Added: 0006642                          
11-10-05 19:12 tiwai          Note Added: 0006669                          
11-10-05 21:50 visit0r        Note Added: 0006672                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
