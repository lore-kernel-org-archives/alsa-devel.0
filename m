From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001789]: aoss skype is blocking.
Date: Sat, 28 Jan 2006 04:24:33 +0100
Message-ID: <efebf04b26e8c0fed76b7d1e5d002d45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36CEF1B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 04:24:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1789> 
======================================================================
Reported By:                nono31
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1789
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-28-2006 03:15 CET
Last Modified:              01-28-2006 04:24 CET
======================================================================
Summary:                    aoss skype is blocking.
Description: 
I'm using a Shuttle SN25P, which is an nForce4 motherboard with onboard
ice1724.

I use 1.0.11rc2 card's config file to have mutilple apps playing at the
same time.
This works great :-)
I have xmms, mplayer using alsa, aoss mplayer using oss working at the
same time.

The only problem I have is with skype: it still blocks my sound dev!

no way I can use other sound app when I am using skype... (so no way I can
hear gaim notification)...
======================================================================

----------------------------------------------------------------------
 nono31 - 01-28-06 04:16 
----------------------------------------------------------------------
So. I've investigate deeper my problem.

Seems that skype is not blocking, but the way I was running skype because
of my chroot is not good. 

my chroot start script (do_chroot) is :
#!/bin/zsh
ARGS=""
for i in "$@" ; do
        ARGS="$ARGS '$i'"
done
exec dchroot -c ia32 -d -q "`basename $0`" "$ARGS"

I've a "ln -s do_chroot skype" 

I do: aoss skype and  skype is blocking my dev.

when i tried strace aoss skype. skype did not start.

I've entered into my chroot envirronment the classic way, ran aoss skype.

And then this is magic: I have ringing sound that does not block! 
But I don't have any sound at all in the call: I can't hear the other one
talking. And he can't hear me neither...

skype (without aoss) in chrooted environment works fine (less the blocking
thing).
I tried 2 mplayers in chrooted environment using oss with aoss, and worked
fine.


I attached the strace file.
I attached my asound.conf file

----------------------------------------------------------------------
 rlrevell - 01-28-06 04:24 
----------------------------------------------------------------------
OK, there is already an open bug for aoss/skype issues, see #1228.

This is hard to diagnose as we don't have the source for skype.  You could
ask them to fix it (by supporting ALSA).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-06 03:15 nono31         New Issue                                    
01-28-06 03:22 rlrevell       Note Added: 0007820                          
01-28-06 04:15 nono31         File Added: strace_aoss_skype.bz2                 
  
01-28-06 04:15 nono31         File Added: asound.conf                      
01-28-06 04:16 nono31         Note Added: 0007821                          
01-28-06 04:24 rlrevell       Note Added: 0007823                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
