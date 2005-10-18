From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001481]: No "Master" is shown in alsamixer
Date: Tue, 18 Oct 2005 17:24:44 +0200
Message-ID: <f89e69f1e3f7f5742942ec9e873d15dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC7FF1A2
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2005 17:24:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1481> 
======================================================================
Reported By:                cartman
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1481
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Pardus
Kernel Version:             2.6.14-rc2
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-18-2005 11:17 CEST
Last Modified:              10-18-2005 17:24 CEST
======================================================================
Summary:                    No "Master" is shown in alsamixer
Description: 
Chipset is Realtek ALC260. All sound modules loaded :

cartman@pardus ~ $ lsmod|grep snd
snd_pcm_oss            47328  0
snd_mixer_oss          15936  1 snd_pcm_oss
snd_seq_dummy           2628  0
snd_seq_oss            30464  0
snd_seq_midi_event      5888  1 snd_seq_oss
snd_seq                47056  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          6732  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_hda_intel          13696  6
snd_hda_codec          81024  1 snd_hda_intel
snd_pcm                79752  4 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              20932  3 snd_seq,snd_pcm
snd                    46564  19
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          8072  2 snd_hda_intel,snd_pcm

======================================================================

----------------------------------------------------------------------
 tiwai - 10-18-05 17:24 
----------------------------------------------------------------------
ALC260 has no master volume control.  It has separate headphone and
line-out volume controls.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 11:17 cartman        New Issue                                    
10-18-05 11:17 cartman        Distribution              => Pardus          
10-18-05 11:17 cartman        Kernel Version            => 2.6.14-rc2      
10-18-05 17:24 tiwai          Status                   assigned => resolved
10-18-05 17:24 tiwai          Resolution               open => not an issue
10-18-05 17:24 tiwai          Note Added: 0006489                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
