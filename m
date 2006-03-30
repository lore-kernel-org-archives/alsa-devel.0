From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001979]: Missing symbols in oss mixer code
Date: Thu, 30 Mar 2006 10:00:50 +0200
Message-ID: <a2a9317ed4902afdd107636c99d83356@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 881D3141
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 10:00:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1979> 
======================================================================
Reported By:                zx80user
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1979
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-29-2006 23:03 CEST
Last Modified:              03-30-2006 10:00 CEST
======================================================================
Summary:                    Missing symbols in oss mixer code
Description: 
Attempting to load the snd-pcm-oss module and the snd-pcm-mixer modules
fails due to missing symbols.


======================================================================

----------------------------------------------------------------------
 zx80user - 03-29-06 23:05 
----------------------------------------------------------------------
/ # modprobe snd-pcm-oss
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
WARNING: Error inserting snd_mixer_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see )snd_pcm_oss: Unknown symbol
snd_mixer_oss_ioctl_card
FATAL: Error inserting snd_pcm_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-pcm-oss.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
/ # modprobe snd-mixer-oss
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
FATAL: Error inserting snd_mixer_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see dm)

----------------------------------------------------------------------
 Raymond - 03-30-06 10:00 
----------------------------------------------------------------------
What is the output of ruuning "amixer" ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 23:03 zx80user       New Issue                                    
03-29-06 23:04 zx80user       Issue Monitored: zx80user                    
03-29-06 23:05 zx80user       Note Added: 0009019                          
03-30-06 10:00 Raymond        Note Added: 0009024                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
