From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001529]: hardware mixing does not work with spdif
Date: Tue, 8 Nov 2005 18:38:51 +0100
Message-ID: <7c7a96822d8fcc1727332b82d6331cf3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 571D31C0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 18:38:51 +0100 (MET)
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
Last Modified:              11-08-2005 18:38 CET
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
 tiwai - 11-08-05 18:38 
----------------------------------------------------------------------
It's not supported.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-05 14:24 visit0r        New Issue                                    
11-05-05 14:24 visit0r        Distribution              => Debian Unstable 
11-05-05 14:24 visit0r        Kernel Version            => 2.6.14          
11-05-05 14:27 visit0r        Issue Monitored: visit0r                     
11-08-05 18:38 tiwai          Note Added: 0006634                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
