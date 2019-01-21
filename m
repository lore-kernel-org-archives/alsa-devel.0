From: Timothy Pearson <tpearson@raptorengineering.com>
Subject: Possible ALSA loopback bug?
Date: Sun, 20 Jan 2019 19:00:19 -0600
Message-ID: <5C4519A3.2050200@raptorengineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CA22673F8
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 02:00:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 34AC6D212E0
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 19:00:20 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id QUgR0nlxwgSf for <alsa-devel@alsa-project.org>;
 Sun, 20 Jan 2019 19:00:19 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id B6E1CD213DA
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 19:00:19 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IDn052ByW6kS for <alsa-devel@alsa-project.org>;
 Sun, 20 Jan 2019 19:00:19 -0600 (CST)
Received: from [192.168.3.54] (apollo.starlink.edu [192.168.3.54])
 by mail.rptsys.com (Postfix) with ESMTP id 7AB7ED212FD
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 19:00:19 -0600 (CST)
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

I've been running a dedicated machine with ALSA loopback, feeding
darkice on the capture side and (currently) using mplayer to provide
audio on the playback side.  I've seen sporadic hangs for a couple of
years on this setup, but recently with the switch to mplayer I have
additional information that points more to ALSA than the other applications.

When the audio hangs, mplayer prints a continuous stream of:
"Audio device got stuck!"

The only way to "unstick" the audio stream is to terminate and restart
mplayer.  Restarting darkice does not fix the stuck stream.  There is no
pulseaudio on this sytem.

What would be the next steps to debug this setup?  It's shown up on two
entirely different installs at this point (Ubuntu 14.04 and Debian 9).

Thanks!

-- 
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
https://www.raptorengineering.com
