From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Tue, 28 Jun 2005 12:45:40 +0200
Message-ID: <cd38e5b55c527e2678da916f6146dadf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16AD81ED
	for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2005 12:45:40 +0200 (MEST)
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
Last Modified:              06-28-2005 12:45 CEST
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
 sst4 - 06-28-05 01:14 
----------------------------------------------------------------------
Takashi, first the good news - I managed to hear my own recording using
'echo123' automated voice testing service of Skype - which means that
capture
as such + OSS emulation basically work.

The volume of my recorded voice was sufficient and the sound quality was
quite
good of both their prerecorded message and my played back voice.

Now the bad news.

I created my ~/.asoundrc file according to my understanding of your
message
- my understanding may well be wrong.

cat ~/.asoundrc
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

pcm.dsp0 {
  type asym
  playback.pcm "plughw:0"
  capture.pcm {
    type plug
    slave.pcm "revocap"
  }
}

If I'm using this file, I hear only hiss when my recorded voice is played
back.

The file does not eliminate the

"volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument"

message.

I have aslo created /dev/dsp0 which is a symlink to /dev/dsp:

lrwxrwxrwx  1 root root 8 Jun 28 01:22 /dev/dsp0 -> /dev/dsp

- I am not sure whether this is necessary or not. Anyway, Skype does not
allow me to choose anything but /dev/dsp.

If I hide the ~/.asoundrc file, then I can use Skype as I described
above.

Another thing is capture loopback, i.e. ability to hear my own voice
while
I'm talking. Well, it's either or - I mean, if I enable loopback using
"H/W", "H/W 1" controls in 'alsamixer', I cannot hear Skype.

The funny workaround is this: I enable capture loopback only for one
channel,
say, "H/W". In such a case I hear myself while talking in the left
earphone,
and I hear Skype in the right earphone - "H/W 1" is set "PCM Out" for
this.

Is there a way to work with Skype normally ?

Thanks,
  Sergei.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
