From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001184]: xmms/beep "couldn't open audio" on song change
Date: Mon, 2 Jan 2006 10:21:22 +0100
Message-ID: <11cb97f94279cdd147b5adc4e1b311ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B3DBF142
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 10:21:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1184> 
======================================================================
Reported By:                Xero
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1184
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             06-11-2005 21:14 CEST
Last Modified:              01-02-2006 10:21 CET
======================================================================
Summary:                    xmms/beep "couldn't open audio" on song change
Description: 
When playing a song in beep sometimes it'll pop up a "couldn't open audio"
box as if the device is in use. This is using dmix, however, so that
seemed a bit weird. I normally have to close and reopen beep to resolve
this. I believe xmms does the same thing because I've read about people
having the exact same issue with xmms.

This starts showing up when I start pressing play again:

ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: Connection refused
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: No such file or directory
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: No such file or directory
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: No such file or directory
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: No such file or directory


However one thing which I've never seen mentioned in the previous reports,
is that when trying to use another app through dmix it doesn't work
either. Here's what mplayer says, when trying to play a video:

alsa-init: 1 soundcard found, using: default
ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-30443-1118514847-814284: No such file or directory
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
alsa-init: playback open error: No such file or directory
Could not open/initialize audio device -> no sound.
Audio: no sound

so apparently something went wrong with /tmp/alsa-dmix-*. As soon as I
closed beep, all other applications started working properly again, and
when I start it back up again, it works fine again too, until it does this
again. It seems to do it sporadically so it's somewhat hard to test for.

Attached is my asoundrc.
======================================================================

----------------------------------------------------------------------
 skandalfo - 01-01-06 13:20 
----------------------------------------------------------------------
Yes, I confirm the behaviour. I don't see any socket/connect related
message, and I keep seeing the "device busy" when xine switches audio
formats.

However, I probably never got the socket/connect problem in the first
place. I simply saw this bug report for xine-lib:

https://sourceforge.net/tracker/index.php?func=detail&aid=1226595&group_id=9655&atid=109655

And when I came here looking for a matching bug I thought this one to be
the same problem, although I'm not sure anymore. Maybe I should have just
filed a new bug about my specific problem...


Although I don't actually know the innards of alsa-lib, my impression is
that the sequence of events in my case is the following one:

1. xine opens default pcm for 2.0 audio; that would use dmix
2. xine plays audio, that's buffered by dmix and played on the backend hw
pcm.
3. xine wants to swich format, so it has to close the 2.0 pcm and open the
5.1 one.
4. xine closes the default pcm audio. This closes the dmix plugin, but
probably the dmix plugin doesn't close the hw pcm yet, until any buffered
audio is finally flushed.
5. xine tries to open the 5.1 pcm, in this case surround51, that's not
dmix-mapped. As the hw pcm is STILL allocated by dmix, this call fails.
6. eventually dmix flushes its pending buffers and deallocates the hw pcm,
but xine has already bailed out...

See in the xine-lib bug report how inserting a sleep(1) call before the
snd_pcm_open call "fixes" the issue.

IMHO a possible fix for this issue would be to make the call to
snd_pcm_close block until the buffers are flushed and the underlaying pcm
is closed when the pcm being closed is dmix and the closing client is the
last active client.

----------------------------------------------------------------------
 perex - 01-02-06 10:21 
----------------------------------------------------------------------
Well, the dmix resource manager keeps the device allocated for a while (up
to 0.5sec). This has nothing related to audio bufferring. It would be
better to check for -EBUSY error code and keep trying to reopen audio
device about one or two seconds in xine-lib before giving up.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 21:14 Xero           New Issue                                    
06-11-05 21:14 Xero           File Added: asoundrc                         
06-11-05 21:14 Xero           Note Added: 0004994                          
06-15-05 15:03 tiwai          Note Added: 0005030                          
06-15-05 22:31 Xero           Note Added: 0005046                          
06-15-05 23:55 Xero           Note Added: 0005049                          
06-22-05 18:22 tiwai          Note Added: 0005142                          
06-22-05 19:01 Xero           Note Added: 0005144                          
06-23-05 02:47 Xero           Note Added: 0005162                          
06-26-05 22:08 Xero           Note Added: 0005267                          
06-27-05 16:22 tiwai          Note Added: 0005275                          
06-27-05 22:05 Xero           Note Added: 0005288                          
06-27-05 22:41 Xero           Note Added: 0005289                          
08-01-05 23:43 skandalfo      Note Added: 0005597                          
08-01-05 23:50 Xero           Note Added: 0005598                          
08-15-05 14:59 perex          Status                   new => assigned     
08-15-05 14:59 perex          Assigned To               => perex           
08-15-05 15:03 perex          Category                 0_general => 1_pcm_d -
direct PCM plugins (dmix+)
08-18-05 12:00 perex          Note Added: 0005842                          
08-18-05 13:06 perex          Note Added: 0005845                          
08-18-05 13:10 perex          Status                   assigned => feedback
08-18-05 18:31 Xero           Note Added: 0005850                          
09-15-05 21:02 skandalfo      Note Added: 0006222                          
09-15-05 21:07 skandalfo      File Added: xine-bugged-output.txt                
   
12-30-05 23:15 rlrevell       Note Added: 0007281                          
12-31-05 20:38 skandalfo      Note Added: 0007358                          
12-31-05 21:32 rlrevell       Note Added: 0007359                          
01-01-06 07:15 skandalfo      Note Added: 0007362                          
01-01-06 08:11 rlrevell       Note Added: 0007363                          
01-01-06 13:20 skandalfo      Note Added: 0007365                          
01-02-06 10:21 perex          Note Added: 0007370                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
