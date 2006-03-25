From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001956]: regression BUG:0001517 No sound on Acer TravelMate.
Date: Sat, 25 Mar 2006 04:33:50 +0100
Message-ID: <9bc930edb8f211573915726640ce522a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A68E1B8
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 04:33:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1956> 
======================================================================
Reported By:                flujan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1956
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.13
======================================================================
Date Submitted:             03-23-2006 21:30 CET
Last Modified:              03-25-2006 04:33 CET
======================================================================
Summary:                    regression BUG:0001517 No sound on Acer TravelMate.
Description: 
The problem where solved in the CVS from 2006-03-01 but in the rc4 version
the problem returns. 
======================================================================

----------------------------------------------------------------------
 tiwai - 03-24-06 13:01 
----------------------------------------------------------------------
Sorry, not "laptop" but "acer".

If the model doesn't work, first, make sure that you set up mixer
correctly.
Upload /etc/asound.state (after "alsactl store"), and
/proc/asound/card0/codec#* files for checking, together with the output of
"lspci -nv" for class 0403 device.
(All these important files are missing in the old bug report...)

----------------------------------------------------------------------
 flujan - 03-25-06 04:33 
----------------------------------------------------------------------
This is the output provided by alsaconf. It detects the hda-intel driver
and then produces this:


WARNING: Error inserting snd_page_alloc
(/lib/modules/2.6.13/kernel/sound/acore/snd-page-alloc.ko): Invalid module
format
WARNING: Error inserting snd
(/lib/modules/2.6.13/kernel/sound/acore/snd.ko): Invalid module format
WARNING: Error inserting snd_timer
(/lib/modules/2.6.13/kernel/sound/acore/snd-timer.ko): Invalid module
format
WARNING: Error inserting snd_pcm
(/lib/modules/2.6.13/kernel/sound/acore/snd-pcm.ko): Invalid module
format
WARNING: Error inserting snd_hda_codec
(/lib/modules/2.6.13/kernel/sound/pci/hda/snd-hda-codec.ko): Invalid
module format
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.13/kernel/sound/pci/hda/snd-hda-intel.ko): Invalid
module format

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-06 21:30 flujan         New Issue                                    
03-23-06 21:30 flujan         Distribution              => Slackware       
03-23-06 21:30 flujan         Kernel Version            => 2.6.13          
03-24-06 11:57 tiwai          Note Added: 0008914                          
03-24-06 12:52 er-ku          Note Added: 0008915                          
03-24-06 13:01 tiwai          Note Added: 0008916                          
03-25-06 04:33 flujan         Note Added: 0008941                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
