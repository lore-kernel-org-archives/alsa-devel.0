From: andoru <andoru.blah@gmail.com>
Subject: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Fri, 4 Apr 2014 16:15:35 +0000 (UTC)
Message-ID: <loom.20140404T175952-945@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 283132657F3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 18:15:52 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WW6mT-0002A4-AY
 for alsa-devel@alsa-project.org; Fri, 04 Apr 2014 18:15:49 +0200
Received: from cl-86-125-143-132.cablelink.mures.rdsnet.ro ([86.125.143.132])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 18:15:49 +0200
Received: from andoru.blah by cl-86-125-143-132.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 18:15:49 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Continued from here: http://article.gmane.org/gmane.linux.alsa.devel/121379

After a few days now I finally got VLC to log everything that happens, and
finally the bug reappeared, and unlike previously thought, it happens when I
watch a video as well.
But unfortunately VLC didn't give anything specific that happened at the
time, just some vague ALSA errors about broken pipes (at line 394) : 
http://pastebin.com/NgZiG9yX

At the time I added the video to VLC's queue I was doing something in the
background (which I don't remember now unfortunately), but this has happened
even when listening to something without doing anything in the background,
and not having any background-running apps except Transmission.

Also interestingly lately I've heard a few crackles/pops when listening to
stuff, followed by a second or so of silence then back to normal when I
would run CPU intensive stuff. At those points I thought the bug would be
invoked again, but it didn't happen so.

I still have the crackling problem, not able to change the PCM channel
volume and screeching on audio that has clipped portions or very high
frequency waves.

Can anyone give me any instructions on what I could do to further diagnose
this problem?
And more importantly, as I stated in the linked post above, how could I shut
down the sound daemon/server/whatever so I could bring back the OS to
stability without restarting.
