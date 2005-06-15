From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001184]: xmms/beep "couldn't open audio" on song change
Date: Wed, 15 Jun 2005 23:55:15 +0200
Message-ID: <d8deb0dce2fe5765e617bf93022a8b18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 92DE11F8
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 23:55:15 +0200 (MEST)
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
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1184
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-11-2005 21:14 CEST
Last Modified:              06-15-2005 23:55 CEST
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
 Xero - 06-15-05 22:31 
----------------------------------------------------------------------
I made a CVS alsa-lib ebuild and am now running cvs alsa-lib with the
ipc_gid audio option in the dmix.conf. However, since my local config file
overrides the default dmix config with !dmix I've added it to my .asoundrc
as well just in case. I will report back whether or not the problem still
occurs. It happens somewhat randomly, so it's not the easiest thing to
test for.

----------------------------------------------------------------------
 Xero - 06-15-05 23:55 
----------------------------------------------------------------------
ALSA lib pcm_direct.c:218:(make_local_socket) connect failed:
/tmp/alsa-dmix-27521-1118870832-290176: Connection refused
ALSA lib pcm_dmix.c:847:(snd_pcm_dmix_open) unable to connect client
ALSA lib pcm_direct.c:218:(make_local_socket) connect failed:
/tmp/alsa-dmix-27521-1118870832-290176: No such file or directory
ALSA lib pcm_dmix.c:847:(snd_pcm_dmix_open) unable to connect client

it happened again. I was just playing a track and chatting and it just
popped up the cannot connect. I had to restart beep before it started
working again. So the CVS change didn't do anything.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 21:14 Xero           New Issue                                    
06-11-05 21:14 Xero           File Added: asoundrc                         
06-11-05 21:14 Xero           Note Added: 0004994                          
06-15-05 15:03 tiwai          Note Added: 0005030                          
06-15-05 22:31 Xero           Note Added: 0005046                          
06-15-05 23:55 Xero           Note Added: 0005049                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
