From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000988]: No errors, but no sound output
Date: Sat, 19 Mar 2005 00:16:22 +0100
Message-ID: <409d2620a70332f9fa4ae9d62e3a2a30@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C513E22D
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 00:16:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=988> 
======================================================================
Reported By:                madCoder
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   988
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.11-gentoo-r2
======================================================================
Date Submitted:             03-14-2005 00:35 CET
Last Modified:              03-19-2005 00:16 CET
======================================================================
Summary:                    No errors, but no sound output
Description: 
Sound was working fine in linux kernel 2.6.9 with ALSA version 1.0.6.  I
upgraded the kernel to 2.6.11-gentoo-r2, which contains ALSA version
1.0.8, and now I get no sound at all.  There are no error messages, the
kernel modules are loaded properly and appear to be working fine.  Playing
a file in XMMS, the spectrum analyzer shows that it should be playing
sound, but I get nothing from the speakers.

I've already checked that all the mixer channels are unmuted and turned
up, including DAC.  I know I'm not the only one, nor is this chipset the
only one, that has had this problem, so is it something in the core that
is causing all these problems, or are there just that many chipsets that
have suddenly developed the inability to produce sound?

lsmod, lspci, and /proc output are attached in Additional Info
======================================================================

----------------------------------------------------------------------
 tiwai - 03-18-05 18:19 
----------------------------------------------------------------------
Maybe the same bug as https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963
?

Try to turn on "External Amplifier" mixer switch.

----------------------------------------------------------------------
 madCoder - 03-19-05 00:16 
----------------------------------------------------------------------
Ok, I'll try that from the later kernel  (will respond after a reboot).
What is the intended purpose of the External Amplifier switch?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 00:35 madCoder       New Issue                                    
03-14-05 00:35 madCoder       Distribution              => gentoo          
03-14-05 00:35 madCoder       Kernel Version            => 2.6.11-gentoo-r2
03-14-05 00:37 madCoder       Issue Monitored: madCoder                    
03-16-05 12:56 tiwai          Note Added: 0003950                          
03-17-05 00:05 madCoder       File Added: asound.state                     
03-17-05 00:06 madCoder       Note Added: 0003973                          
03-17-05 00:08 madCoder       Note Edited: 0003973                         
03-18-05 18:19 tiwai          Note Added: 0004002                          
03-19-05 00:16 madCoder       Note Added: 0004008                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
