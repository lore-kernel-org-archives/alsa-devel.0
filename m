From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001958]: /proc/asound/card0/codec#0 missing
Date: Wed, 29 Mar 2006 19:08:56 +0200
Message-ID: <a4566a8cfb169c15ef4d7241e725cf9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7CE71173
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 19:08:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1958> 
======================================================================
Reported By:                chibo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1958
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (Breezy)
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             03-24-2006 13:28 CET
Last Modified:              03-29-2006 19:08 CEST
======================================================================
Summary:                    /proc/asound/card0/codec#0 missing
Description: 
The file /proc/asound/card0/codec#0 doesn't exist and /proc/asound/cards
has only a single line: --- no soundcards ---

lsmod | grep snd
snd_hda_intel          18196  0
snd_hda_codec         139056  1 snd_hda_intel
snd_pcm_oss            45984  0
snd_mixer_oss          16640  1 snd_pcm_oss
snd_pcm                85768  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              23044  1 snd_pcm
snd                    56904  7
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9184  1 snd
snd_page_alloc         10632  2 snd_hda_intel,snd_pcm

lspci | grep Audio
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)

======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 19:08 
----------------------------------------------------------------------
There must be related kernel error messages.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 13:28 chibo          New Issue                                    
03-24-06 13:28 chibo          Distribution              => Ubuntu (Breezy) 
03-24-06 13:28 chibo          Kernel Version            => 2.6.12-10-386   
03-24-06 14:22 chibo          Issue Monitored: chibo                       
03-29-06 19:08 tiwai          Note Added: 0009009                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
