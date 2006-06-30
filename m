From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001735]: OSS emulation 4-channel mode
	rear channels not working
Date: Fri, 30 Jun 2006 18:05:41 +0200
Message-ID: <8f07e0b012ea070c11676d9b9b7b9e5b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C06B29A
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 18:05:41 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Debian sarge 3.1
Kernel Version:             2.6.15
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-11-2006 10:51 CET
Last Modified:              06-30-2006 18:05 CEST
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

----------------------------------------------------------------------
 jcdutton - 06-30-06 18:05 
----------------------------------------------------------------------
Both the mentioned applications now support ALSA, so OSS emulation is not
required any more.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 10:51 giorby         New Issue                                    
01-11-06 10:51 giorby         Distribution              => Debian sarge 3.1
01-11-06 10:51 giorby         Kernel Version            => 2.6.15          
01-11-06 11:08 giorby         Note Added: 0007561                          
01-12-06 03:40 Adrian Bunk    Issue Monitored: Adrian Bunk                    
06-30-06 18:05 jcdutton       Status                   new => closed       
06-30-06 18:05 jcdutton       Note Added: 0010747                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
