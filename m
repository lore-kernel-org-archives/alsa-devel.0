From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001003]: Inverse S/PDIF control, S/PDIF occationally drops out
Date: Tue, 22 Mar 2005 20:01:03 +0100
Message-ID: <3d887475d04665b94ff00cccb5d6d36a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EB85A237
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 20:01:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1003> 
======================================================================
Reported By:                rpz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1003
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.770_FC3
======================================================================
Date Submitted:             03-21-2005 01:14 CET
Last Modified:              03-22-2005 20:01 CET
======================================================================
Summary:                    Inverse S/PDIF control, S/PDIF occationally drops
out
Description: 
When using the ALSA mixer or gnome volume control, the S/PDIF coaxial
output (IEC958 Playback AC97-SPSA) is reversed -- it only plays sound when
the control is set to zero. There is also no level control, it's either on
or off. The separate mute control (IEC958) seems to work OK.
Also, the sound disappears seemingly at random when using e.g. rhythmbox,
this especially happens between tracks, sometimes also in the middle of
tracks. The gstreamer driver is set to ALSA. It is possible to restore
sound by moving the "IEC958 Playback AC97-SPSA" slider to a nonzero value
and back to zero again.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-22-05 20:01 
----------------------------------------------------------------------
AC97-SPSA is no volume control.  It chooses the slot for SPDIF output
route.

I guess you don't play via "iec958" or "spdif" PCM but use the normal PCM.
 This is wrong.  The correct spdif route on ICH4 should use slots 10/11.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-05 01:14 rpz            New Issue                                    
03-21-05 01:14 rpz            Distribution              => Fedora Core 3   
03-21-05 01:14 rpz            Kernel Version            => 2.6.10-1.770_FC3
03-22-05 20:01 tiwai          Note Added: 0004131                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
