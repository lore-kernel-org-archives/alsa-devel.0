From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001735]: OSS emulation 4-channel mode rear channels not working
Date: Wed, 11 Jan 2006 11:08:46 +0100
Message-ID: <47300ff42e3b0f2df899415c5742799c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 758F1158
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 11:08:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1735> 
======================================================================
Reported By:                giorby
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1735
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sarge 3.1
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 10:51 CET
Last Modified:              01-11-2006 11:08 CET
======================================================================
Summary:                    OSS emulation 4-channel mode rear channels not
working
Description: 
If I use the OSS emulation and try to play some 4-channel material, with
say mplayer or bplay, the rear channels are just a copy of the front
channels, whereas the same configuration and software worked perfectly
well with the native OSS driver. As the native OSS drivers are faded out
in favour of ALSA, I assumed that the emulation layer should be a sort of
drop-in replacement. Am I wrong?
Tested with Linux kernels 2.6.12/2.6.15.

======================================================================

----------------------------------------------------------------------
 giorby - 01-11-06 11:08 
----------------------------------------------------------------------
Sorry, I forgot to identify my soundcard... 
/proc/asound/devices lists:
0 [Live           ]: EMU10K1 - SBLive! Value [CT4832]
                     SBLive! Value [CT4832] (rev.6, serial:0x80271102) at
0xd400, irq 5

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 10:51 giorby         New Issue                                    
01-11-06 10:51 giorby         Distribution              => Debian sarge 3.1
01-11-06 10:51 giorby         Kernel Version            => 2.6.15          
01-11-06 11:08 giorby         Note Added: 0007561                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
