From: Andoru <andoru.blah@gmail.com>
Subject: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Sun, 20 Apr 2014 15:04:48 +0000 (UTC)
Message-ID: <loom.20140420T165832-72@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id EA0E5261A57
 for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2014 17:05:01 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WbtIi-0000gB-0z
 for alsa-devel@alsa-project.org; Sun, 20 Apr 2014 17:05:00 +0200
Received: from cl-86-125-139-41.cablelink.mures.rdsnet.ro ([86.125.139.41])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2014 17:05:00 +0200
Received: from andoru.blah by cl-86-125-139-41.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2014 17:05:00 +0200
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
http://news.gmane.org/find-root.php?message_id=loom.20140406T010044%2d863%40post.gmane.org]

Since I didn't get any answer again, I decided to try and build the latest
ALSA snapshots myself (alsa-driver-1.0.25.3584.gb044d;
alsa-firmware-1.0.27.2.gf21a8; alsa-lib-1.0.27.2; alsa-oss-1.0.25.2.g39df1;
alsa-plugins-1.0.27.10.gb5917; alsa-utils-1.0.27.2.22.gb7ed4) and purge the
Debian ALSA packages to see if I could do something at compile time or if it
would fix the problems, but they're still there. The OS still slows down to
a crawl at random times and I still have the issue with the volume control
plus other quirks I mentioned in the previous threads...
