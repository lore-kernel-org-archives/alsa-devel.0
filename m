From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001882]: Use ESC key to stop the speaker-test instead of using ctrl-C
Date: Fri, 24 Mar 2006 17:42:50 +0100
Message-ID: <19bc01a7ca1b7dcf2907dd4cb907364d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06DC61CE
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 17:42:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1882> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1882
Category:                   speakertest
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-27-2006 03:57 CET
Last Modified:              03-24-2006 17:42 CET
======================================================================
Summary:                    Use ESC key to stop the speaker-test instead of
using ctrl-C
Description: 
Is it possible to use ESC key to stop the speaker-test instead of abort the
test by using control-C ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726
======================================================================

----------------------------------------------------------------------
 Raymond - 03-24-06 17:32 
----------------------------------------------------------------------
Still missing a comma 

speaker-test -c 8 -t wav -D surround71
 
speaker-test 1.0.11rc4
 
Playback device is surround71
Stream parameters are 48000Hz, S16_LE, 8 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 256 to 8192
Period size range from 128 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
Cannot open WAV file
/usr/share/sounds/alsa/Side_Left.wavSide_Right.wavChannel_9.wav



----------------------------------------------------------------------
 tiwai - 03-24-06 17:42 
----------------------------------------------------------------------
Fixed on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-06 03:57 Raymond        New Issue                                    
02-27-06 04:01 rlrevell       Note Added: 0008212                          
03-01-06 09:51 Raymond        Note Added: 0008277                          
03-01-06 09:53 Raymond        Note Edited: 0008277                         
03-01-06 18:01 rlrevell       Note Added: 0008284                          
03-02-06 04:36 Raymond        Note Added: 0008293                          
03-02-06 04:46 Raymond        Note Edited: 0008293                         
03-02-06 04:49 Raymond        Note Edited: 0008293                         
03-02-06 12:44 tiwai          Status                   new => resolved     
03-02-06 12:44 tiwai          Resolution               open => won't fix   
03-02-06 12:44 tiwai          Assigned To               => tiwai           
03-02-06 12:44 tiwai          Note Added: 0008298                          
03-24-06 17:29 Raymond        Status                   resolved => feedback
03-24-06 17:29 Raymond        Resolution               won't fix => reopened
03-24-06 17:29 Raymond        Note Added: 0008924                          
03-24-06 17:32 Raymond        Note Edited: 0008924                         
03-24-06 17:42 tiwai          Status                   feedback => resolved
03-24-06 17:42 tiwai          Resolution               reopened => fixed   
03-24-06 17:42 tiwai          Note Added: 0008929                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
