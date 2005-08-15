From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001184]: xmms/beep "couldn't open audio" on song change
Date: Mon, 15 Aug 2005 15:03:21 +0200
Message-ID: <060bc02ed75978692d2d33a802dd5bc6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84B501AA
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 15:03:21 +0200 (MEST)
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


The following issue has been UPDATED.
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
Status:                     assigned
======================================================================
Date Submitted:             06-11-2005 21:14 CEST
Last Modified:              08-15-2005 15:03 CEST
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
 Xero - 06-11-05 21:14 
----------------------------------------------------------------------
Oh, I forgot to mention, my card is an echo mia midi...if that matters.

----------------------------------------------------------------------
 tiwai - 06-15-05 15:03 
----------------------------------------------------------------------
Try the CVS version.  This might be fixed because of the recent change of
the default dmix config option.

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

----------------------------------------------------------------------
 tiwai - 06-22-05 18:22 
----------------------------------------------------------------------
Weird...  Could you check whether these socket files still exist if this
happens?  Also, check which process opens /dev/snd/pcmC0D0p (e.g. via
fuser or lsof).

----------------------------------------------------------------------
 Xero - 06-22-05 19:01 
----------------------------------------------------------------------
I know for a fact the socket still exists after this happens, infact it
usually ends up leaving a bunch of sockets because when it does happen
they don't seem to get deleted. I will check which process opens it as
soon as I get a chance, probably later today.

----------------------------------------------------------------------
 Xero - 06-23-05 02:47 
----------------------------------------------------------------------
here's lsof output

# lsof  /dev/snd/pcmC0D0p
COMMAND     PID USER   FD   TYPE DEVICE SIZE NODE NAME
beep-medi  5075 xero  mem    CHR 116,16      5808 /dev/snd/pcmC0D0p
beep-medi  5075 xero   27u   CHR 116,16      5808 /dev/snd/pcmC0D0p
beep-medi 32106 xero  mem    CHR 116,16      5808 /dev/snd/pcmC0D0p
beep-medi 32106 xero   27u   CHR 116,16      5808 /dev/snd/pcmC0D0p

----------------------------------------------------------------------
 Xero - 06-26-05 22:08 
----------------------------------------------------------------------
I think this tends to happen more under load. I'm starting to wonder if
this is relevant to the sound card driver. I also get distortion with dmix
sometimes as well when under load, pops, clicks, and occasionally the fade
in of metallic sounding distortion, I've posted in bug 0000881 about my
problems with that, though at this point I'm thinking these two things are
relevant to each other. This has become extremely annoying and I'm not too
sure what to do. Even when I don't use dmix beep will just tend to freeze
completely every once in a while, usually when under load as well.

----------------------------------------------------------------------
 tiwai - 06-27-05 16:22 
----------------------------------------------------------------------
The noises of dmix on a heavy CPU load is considerable, but this should
have nothing to do with the busy-state of socket.  The confliction of
socket means a different thing, e.g. the root takes the socket and sets it
as the permission 0600.  No certain clue yet, though.

----------------------------------------------------------------------
 Xero - 06-27-05 22:05 
----------------------------------------------------------------------
no, the socket remains the proper permission and owned by my user as well,
usually. I don't really ever run anything as root, especially audio stuff,
so I have no idea how that'd even happen. Let me wait for it to happen
again and I'll post a ls -l of the socket. All I have to do is wait for it
to happen a few times and there will be quite the collection of dead
sockts in there...

----------------------------------------------------------------------
 Xero - 06-27-05 22:41 
----------------------------------------------------------------------
hrm the socket actually did disappear this time when it happened, weird.
That means it may or may not always remove the socket, I'm curious if the
socket gets removed after i press play again when it first happens vs.
just shutting down beep right then. I'll report back on this later when I
have more of a clue. This is somewhat of a pain to reproduce as it only
really happens on song change...and then only sometimes.

----------------------------------------------------------------------
 skandalfo - 08-01-05 23:43 
----------------------------------------------------------------------
This seems to be hitting xine-lib too.

See:

https://sourceforge.net/tracker/index.php?func=detail&aid=1226595&group_id=9655&atid=109655

----------------------------------------------------------------------
 Xero - 08-01-05 23:50 
----------------------------------------------------------------------
I only notice this when using dmix...which I've not been using recently
seeing as this card has 4 virtual stereo channels and all these problems
got on my neves...it's enough to avoid having to use it...however I still
get random distortion every once in a while...I'm thinking that distortion
and this problem are caused by some sort of issue related to the card and
dma inaccuracies...though I'm really not sure...

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
