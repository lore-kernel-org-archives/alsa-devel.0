From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001920]: output from only 2 speakers(out of 5 speakers)
Date: Tue, 14 Mar 2006 19:23:22 +0100
Message-ID: <fac85075f717ad2933c706bae0616d19@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76B0615E
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 19:23:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1920> 
======================================================================
Reported By:                binilbenjamin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1920
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6
======================================================================
Date Submitted:             03-13-2006 19:02 CET
Last Modified:              03-14-2006 19:23 CET
======================================================================
Summary:                    output from only 2 speakers(out of 5 speakers)
Description: 
i'm having a 5.1 speakers..when i play music ,only 2 of them are working!!!
i had changed the channel mode in alsamixer to 6 channel..yet no
changes!!! 
Motherboard : Asus A8N-E
OS: fedora core 4

======================================================================

----------------------------------------------------------------------
 rlrevell - 03-14-06 19:12 
----------------------------------------------------------------------
What happens with:

speaker-test -Dsurround51 --channels=6

And what is the output of "cat /proc/asound/version"?

Did you install the latest alsa-lib/libasound too (1.0.11-rc3)?

----------------------------------------------------------------------
 tiwai - 03-14-06 19:23 
----------------------------------------------------------------------
The proper routing to center/LFE on software isn't too trivial since the
output to them requires the mixing of left/right channels.

For example, define your own PCM like below in ~/.asoundrc:
  pcm.mysurround {
    type plug
    slave {
      pcm "surround51"
      channels 6
    }
    ttable {
      0.0 1
      1.1 1
      0.2 1
      1.3 1
      0.4 0.5
      1.4 0.5
      0.5 0.5
      1.5 0.5
    }
  }

Then play with aplay -Dmysurround somefile.wav.  You can define it as the
defaut PCM by adding:

  pcm.!default "mysurround"

Combining with this and soft-mixing is also another story...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 19:02 binilbenjamin  New Issue                                    
03-13-06 19:02 binilbenjamin  Distribution              => Fedora Core 4   
03-13-06 19:02 binilbenjamin  Kernel Version            => 2.6             
03-13-06 19:33 rlrevell       Note Added: 0008455                          
03-13-06 19:49 binilbenjamin  Note Added: 0008457                          
03-13-06 19:54 rlrevell       Note Added: 0008458                          
03-13-06 20:16 binilbenjamin  Note Added: 0008459                          
03-13-06 20:25 rlrevell       Note Added: 0008460                          
03-14-06 17:44 binilbenjamin  Note Added: 0008501                          
03-14-06 17:56 rlrevell       Note Added: 0008504                          
03-14-06 18:34 binilbenjamin  Note Added: 0008505                          
03-14-06 18:52 rlrevell       Note Added: 0008506                          
03-14-06 19:00 rlrevell       Note Added: 0008507                          
03-14-06 19:02 binilbenjamin  Note Added: 0008508                          
03-14-06 19:12 rlrevell       Note Added: 0008509                          
03-14-06 19:23 tiwai          Note Added: 0008510                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
