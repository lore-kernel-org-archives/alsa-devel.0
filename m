From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000746]: No sound when play
Date: Tue, 25 Jan 2005 15:31:51 +0100
Message-ID: <d6972ace87a9a0fa242fe8b9fd87cb60@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9A527263
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 15:31:51 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=746> 
======================================================================
Reported By:                smuslo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   746
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               fedora core 3
Kernel Version:             2.6.9-1.681_FC3.smp
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             12-24-2004 19:34 CET
Last Modified:              01-25-2005 15:31 CET
======================================================================
Summary:                    No sound when play
Description: 
My system :
aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDA [ICH6 HDA], device 0: CMI9880 [CMI9880]
  Subdevices: 1/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0

lsmod
snd_pcm_oss            51496  0
snd_mixer_oss          21632  2 snd_pcm_oss
snd_azx                19312  1
snd_hda_codec          44544  1 snd_azx
snd_pcm                87044  3 snd_pcm_oss,snd_azx,snd_hda_codec
snd_timer              27524  1 snd_pcm
snd                    56804  6
snd_pcm_oss,snd_mixer_oss,snd_azx,snd_hda_codec,snd_pcm,snd_timer
soundcore              12961  2 snd
snd_page_alloc         14088  2 snd_azx,snd_pcm



======================================================================

----------------------------------------------------------------------
 smuslo - 12-24-04 20:59 
----------------------------------------------------------------------
Reboot and work fine !!!!

----------------------------------------------------------------------
 tiwai - 01-25-05 15:31 
----------------------------------------------------------------------
Forgot to resolve this issue...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-04 19:34 smuslo         New Issue                                    
12-24-04 19:34 smuslo         Distribution              => fedora core 3   
12-24-04 19:34 smuslo         Kernel Version            => 2.6.9-1.681_FC3.smp
12-24-04 19:38 smuslo         Issue Monitored: smuslo                      
12-24-04 19:38 smuslo         Note Added: 0002931                          
12-24-04 20:59 smuslo         Note Added: 0002932                          
12-24-04 21:00 smuslo         Issue End Monitor: smuslo                    
01-25-05 15:31 tiwai          Status                   new => resolved     
01-25-05 15:31 tiwai          Resolution               open => not an issue
01-25-05 15:31 tiwai          Assigned To               => tiwai           
01-25-05 15:31 tiwai          Note Added: 0003407                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
