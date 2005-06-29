From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Wed, 29 Jun 2005 21:40:56 +0200
Message-ID: <a89d568e7f271c0967f7014381f2b755@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 91AE917E
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 21:40:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1164> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1164
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-07-2005 00:33 CEST
Last Modified:              06-29-2005 21:40 CEST
======================================================================
Summary:                    aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN
failed: Invalid argument
Description: 
I've tried 'skype' with my M-Audio Revolution 7.1.

Soon (probably in a second) after this command line:

aoss skype &

the terminal window gets filled with

volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument

messages, and I do not hear anything in 'skype' connecting to their
automated 'echo123' service.

The message is not quite clear, and I believe it shouldn't flood the
screen.

I mean, the code should first check capabilities of the card and its
configuration and
issue the message once.


What is IGAIN in the message above ? Input gain ? That is, capture gain ?

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001096 no capture with M-Audio Revolution 7.1
======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-05 20:22 
----------------------------------------------------------------------
Hmm, did you apply the patch for aoss above?
After applying the patch, try once aoss skype with softvol plugin in
~/.asoundrc and quit immediately.  This should create a user-defined
control "Capture Volume".  Then again aoss skype without ~/.asoundrc.

----------------------------------------------------------------------
 sst4 - 06-29-05 21:40 
----------------------------------------------------------------------
Takashi, three minutes after publishing the patch (06-08-05 14:50 ->
06-08-05 14:53) you said:

"
With revo 7.1, this might not work, too, since revo has really no "Capture
Volume" (corresponding to IGAIN in OSS).

If so, it must be a bug of Skype. Skype must check DEVMASK before reading
IGAIN. 
".

So, it was an indication for me that you were not insisting on the patch
anymore.

If you think the patch is worth trying, I'll have to allocate some time
for learning how to non-destructively compile ALSA.

Thanks,
  Sergei.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-05 00:33 sst4           New Issue                                    
06-08-05 14:50 tiwai          Note Added: 0004923                          
06-08-05 14:51 tiwai          File Added: aoss-igain-fix.diff                   

06-08-05 14:53 tiwai          Note Added: 0004926                          
06-08-05 14:54 tiwai          File Added: aoss-igain-fix2.diff                  
 
06-08-05 14:55 tiwai          File Deleted: aoss-igain-fix.diff                 
  
06-12-05 19:35 sst4           Note Added: 0004999                          
06-13-05 13:03 tiwai          Note Added: 0005006                          
06-13-05 14:12 sst4           Note Added: 0005009                          
06-13-05 14:30 tiwai          Note Added: 0005010                          
06-13-05 15:55 sst4           File Added: asound.state.geberated_by_alsaconf    
               
06-13-05 15:59 sst4           File Added: asound.state.generated_by_alsaconf    
               
06-13-05 16:05 sst4           Note Added: 0005012                          
06-15-05 08:25 sst4           Note Added: 0005021                          
06-15-05 15:44 tiwai          Note Added: 0005035                          
06-22-05 01:48 rlrevell       Relationship added       duplicate of 0001096
06-28-05 00:59 sst4           Note Added: 0005290                          
06-28-05 01:14 sst4           Note Added: 0005291                          
06-28-05 12:45 tiwai          Note Added: 0005297                          
06-28-05 23:45 sst4           Note Added: 0005301                          
06-29-05 00:08 sst4           Note Added: 0005302                          
06-29-05 20:22 tiwai          Note Added: 0005311                          
06-29-05 21:40 sst4           Note Added: 0005316                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
