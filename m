From: Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: Possible ALSA loopback bug?
Date: Mon, 21 Jan 2019 15:38:19 -0600
Message-ID: <5C463BCB.2030907@raptorengineering.com>
References: <5C4519A3.2050200@raptorengineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by alsa0.perex.cz (Postfix) with ESMTP id BF6DB2667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 22:38:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id A7FDED20DF2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 15:38:20 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BgwNGgZmqgGO for <alsa-devel@alsa-project.org>;
 Mon, 21 Jan 2019 15:38:19 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 7B02AD210B7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 15:38:19 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id A6GJcLtBY2PF for <alsa-devel@alsa-project.org>;
 Mon, 21 Jan 2019 15:38:19 -0600 (CST)
Received: from [192.168.3.54] (apollo.starlink.edu [192.168.3.54])
 by mail.rptsys.com (Postfix) with ESMTP id 4CF04D20DF2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 15:38:19 -0600 (CST)
In-Reply-To: <5C4519A3.2050200@raptorengineering.com>
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

On 01/20/2019 07:00 PM, Timothy Pearson wrote:
> I've been running a dedicated machine with ALSA loopback, feeding
> darkice on the capture side and (currently) using mplayer to provide
> audio on the playback side.  I've seen sporadic hangs for a couple of
> years on this setup, but recently with the switch to mplayer I have
> additional information that points more to ALSA than the other applications.
> 
> When the audio hangs, mplayer prints a continuous stream of:
> "Audio device got stuck!"
> 
> The only way to "unstick" the audio stream is to terminate and restart
> mplayer.  Restarting darkice does not fix the stuck stream.  There is no
> pulseaudio on this sytem.
> 
> What would be the next steps to debug this setup?  It's shown up on two
> entirely different installs at this point (Ubuntu 14.04 and Debian 9).
> 
> Thanks!

A bit of additional information:  before audio output ceases entirely,
the messages start printing and the audio becomes very choppy.  The
system has no processes stuck at 100% CPU or any other visible signs of
duress during this time.

Suggestions on debug are welcome!

-- 
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
https://www.raptorengineering.com
