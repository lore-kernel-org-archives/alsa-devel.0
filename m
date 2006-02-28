From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001862]: snd_pcm_hw_params_get_rate_max return -1 for "default" pcm
Date: Tue, 28 Feb 2006 04:03:34 +0100
Message-ID: <dd608285be1393ab431457dbe742f652@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D02BC19C
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 04:03:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1862> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1862
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-21-2006 07:00 CET
Last Modified:              02-28-2006 04:03 CET
======================================================================
Summary:                    snd_pcm_hw_params_get_rate_max return -1 for
"default" pcm
Description: 
For hw:0 playback and capture pcm

snd_pcm_hw_params_get_rate_min return 5000
snd_pcm_hw_params_get_rate_max return 48000

For "default" playback and capture pcm

snd_pcm_hw_params_get_rate_min return 4000
snd_pcm_hw_params_get_rate_max return -1


======================================================================

----------------------------------------------------------------------
 Raymond - 02-28-06 04:03 
----------------------------------------------------------------------
"default" of my sound card is "plughw" and it should return 192000 

#define SND_PCM_PLUGIN_RATE_MIN 4000	/**< minimal rate for the rate plugin
*/
#define SND_PCM_PLUGIN_RATE_MAX 192000	/**< maximal rate for the rate
plugin */

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 07:00 Raymond        New Issue                                    
02-28-06 04:03 Raymond        Note Added: 0008238                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
