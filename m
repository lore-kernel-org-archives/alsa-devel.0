From: Andoru <andoru.blah@gmail.com>
Subject: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Mon, 28 Apr 2014 21:28:42 +0000 (UTC)
Message-ID: <loom.20140428T232433-313@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3CA260864
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 23:28:56 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Wet6e-000846-1c
 for alsa-devel@alsa-project.org; Mon, 28 Apr 2014 23:28:56 +0200
Received: from cl-86-125-141-31.cablelink.mures.rdsnet.ro ([86.125.141.31])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 23:28:56 +0200
Received: from andoru.blah by cl-86-125-141-31.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 23:28:56 +0200
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

[Continued from here:
http://thread.gmane.org/gmane.linux.alsa.devel/122028/focus=122354 ]

> It's way too old.  Better to build the latest kernel.

The latest kernel available for my distro, or the latest kernel available
"from Linus"? I've already tried the former.

> You need to figure out the condition reproducing the issue.

For all I know (I'm not that knowledgeable on those things, mind you) this
happens completely at random. There hasn't been any pattern when the PC
would become unusable, and the OS unresponsive.

> For example, application may apply some strange buffer size and period
> size the hardware chip doesn't like. If so, changing the buffer size
> and/or period size may reduce the problem.

I'm not aware of any feature to change the buffer size in any of the
programs that cause the lock-ups.

> Meanwhile, you can try the patch below, too, which aligns the period

That patch is for kernel sources or for the above snapshots I mentioned? Or
perhaps there are more recent ALSA source codes?
