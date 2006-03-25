From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001882]: Use ESC key to stop the speaker-test instead of using ctrl-C
Date: Sat, 25 Mar 2006 13:22:35 +0100
Message-ID: <8827e85f9d54a89b4a58fbb1fbf3d21e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 912621BF
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 13:22:35 +0100 (MET)
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


The following issue has been REOPENED.
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
Status:                     feedback
======================================================================
Date Submitted:             02-27-2006 03:57 CET
Last Modified:              03-25-2006 13:22 CET
======================================================================
Summary:                    Use ESC key to stop the speaker-test instead of
using ctrl-C
Description: 
Is it possible to use ESC key to stop the speaker-test instead of abort the
test by using control-C ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726
======================================================================

----------------------------------------------------------------------
 tiwai - 03-24-06 17:42 
----------------------------------------------------------------------
Fixed on CVS.  Thanks.

----------------------------------------------------------------------
 Raymond - 03-25-06 13:22 
----------------------------------------------------------------------
-n,--nloops     specify number of loops to test, 0 = infinite


 ./speaker-test -n
 
speaker-test 1.0.11rc4
 
./speaker-test: invalid option -- n
Unknown option '?'


It should exit when encounter error 

speaker-test -c 4 -D surround51 
 
speaker-test 1.0.11rc4
 
Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument

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
03-25-06 13:22 Raymond        Status                   resolved => feedback
03-25-06 13:22 Raymond        Resolution               fixed => reopened   
03-25-06 13:22 Raymond        Note Added: 0008947                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
