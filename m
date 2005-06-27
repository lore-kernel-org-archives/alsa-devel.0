From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Tue, 28 Jun 2005 00:59:26 +0200
Message-ID: <3a16cd3780e92bfb41ed81a46a80e10c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6C261E5
	for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2005 00:59:26 +0200 (MEST)
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
Last Modified:              06-28-2005 00:59 CEST
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
 tiwai - 06-15-05 15:44 
----------------------------------------------------------------------
I don't understand what you mean "enable capture" in general.  One of your
bugreports told that you could capture (even on OSS) with a certain
application.

Again, revo has no capture control.  At least, the hardware spec I got
tells so.

The thing that Skype aborts when no IGAIN exists is the bug of Skype.  It
has to be fixed by the application itself.  Please report this to Skype at
first.

As a workaround of this problem, you can add a softvol plugin to 
create a virtual volume attenuator.  For example,

pcm.revocap {
  type softvol
  slave.pcm {
    type hw
    card 0
  }
  control {
    name "Capture Volume"
    card 0
  }
}

Then, define "dsp0" PCM:

pcm.dsp0 {
  type asym
  playback.pcm "plughw:0"
  capture.pcm {
    type plug
    slave.pcm "revocap"
  }
}

so that aoss uses the newly defined capture PCM.

----------------------------------------------------------------------
 sst4 - 06-28-05 00:59 
----------------------------------------------------------------------
Takashi, please unmark the issue as duplicate of  duplicate of 0001096.

The latter was regarding capture (loopback) functionality as a whole, and
this
one is regarding certain error message in OSS emulation mode.

Issues can be marked as duplicate if resolving one of them automatically
resolves
the other and vice versa. It is not the case.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
