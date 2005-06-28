From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Tue, 28 Jun 2005 23:45:19 +0200
Message-ID: <e8b6e576e9967787390af3e711dfd2e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 530C4194
	for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2005 23:45:20 +0200 (MEST)
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
Last Modified:              06-28-2005 23:45 CEST
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
 tiwai - 06-28-05 12:45 
----------------------------------------------------------------------
Unfortunately, the ICE1724 doesn't allow the mixing of multiple sources for
the playback.  That is, *either* PCM, analog-in or spdif-in can be used
*exclusively*.  If you choose the analog-loopback, you can't hear PCM.

The only possible way to solve this is to do mixing on software.  But, of
course, you will get a certain latency in comparison with the hardware
mixing.  The best solution would be to use JACK, but again, OSS-emulation
makes the problem...

I don't see how you started skype in your recent reports.  If you start
skype with "aoss", ~/.asoundrc has influence, and /dev/dsp* doesn't matter
at all because the emulation doesn't open /dev/dsp* at all.
OTOH, if you don't use "aoss", it's most likely through the kernel OSS
emulation.  In this case, ~/.asoundrc has no influence.at all.

Anyway, it looks like aoss still has a problem with IGAIN.  I'll check on
it.  (But if Skype works only with a warning message, you can forget it
for a while...)

----------------------------------------------------------------------
 sst4 - 06-28-05 23:45 
----------------------------------------------------------------------
Takashi, all the time I was using Skype as

aoss Skype
.

And I can't just forget the warning message - printing it consumes too
much
CPU time, and the sound becomes distorted.

In order to be able to use Skype for real purposes I suppressed the
message
this way (starting Skype from 'tcsh'):

aoss skype >& /dev/null
.

The problem is that in such a manner I suppress all error messages - it's
too
reckless IMHO.

The best way to resolve the issue would be to implement SW gain control
( https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1187 ); as a
temporary
measure it would be nice to suppress the particular message this issue is
about.

The latter is possible if the message is produced by ALSA. The
suppression
should be selective, of course, i.e. through command line switch, config
file,
environment variable or something like that.

...

Can there be an ALSA application that even is OSS emulation performs SW
mixing ?

I.e. an application that can take the desired capture stream (if they are
separate) and loop it to PCM out. Is it possible ?

I think such an issue has already been raised in
alsa-user@lists.sourceforge.net .

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
