From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000988]: No errors, but no sound output
Date: Tue, 22 Mar 2005 19:42:03 +0100
Message-ID: <a26ec58bbedccde7127987c04da20bc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E73FA102
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 19:42:03 +0100 (MET)
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
Last Modified:              03-22-2005 19:42 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000963 Sounc card is mute
======================================================================

----------------------------------------------------------------------
 madCoder - 03-19-05 04:07 
----------------------------------------------------------------------
That did fix it, actually.  It's kind of strange that it wasn't necessary
in 1.0.6, but in 1.0.8 it is.  Oh well.  Thanks for the tip.

----------------------------------------------------------------------
 tiwai - 03-22-05 19:42 
----------------------------------------------------------------------
External Amplifier turns on/off the amplifier on the board if exists.
Turning off this will save the energy consumption a little bit.

Just to be sure:  please stop the ALSA driver once, then remove (or move)
/etc/asound.state, then restart ALSA again to get the "system default"
state.
Is "External Amplifier" control turned on or off as default?

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
03-19-05 04:07 madCoder       Note Added: 0004009                          
03-19-05 04:08 madCoder       Issue End Monitor: madCoder                    
03-22-05 15:13 jdthood        Relationship added       duplicate of 0000963
03-22-05 19:42 tiwai          Note Added: 0004128                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
