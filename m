From: <darknessdescends@tutanota.com>
Subject: Bug report: Sound skipping/stuttering every 5-20
	minutes
Date: Mon, 16 May 2016 20:33:38 +0100 (BST)
Message-ID: <KHv2nVK--3-0@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
 by alsa0.perex.cz (Postfix) with ESMTP id EB64C2625FE
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 21:33:42 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by w1.tutanota.de (Postfix) with ESMTP id A0F26FA7C93
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 19:33:42 +0000 (UTC)
Received: from w1.tutanota.de ([127.0.0.1])
 by localhost (w1.tutanota.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y76INCbWHO6Z for <alsa-devel@alsa-project.org>;
 Mon, 16 May 2016 19:33:38 +0000 (UTC)
Received: from w1.tutanota.de (unknown [127.0.0.1])
 by w1.tutanota.de (Postfix) with ESMTP id 82CEFFA84F4
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 19:33:38 +0000 (UTC)
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


My sound skips/stutters for about half a second (certainly no more than 1 
second) on average every 5-20 minutes. I initially had no sound on this 
computer with Ubuntu 14.04, which is probably because Ubuntu 14.04 has an 
outdated version of Alsa. I then tested with a live disc of Ubuntu 16.04 
(before official release date), which did give me sound. At this point, I 
installed the the latest version of Alsa onto Ubuntu 14.04 from here (because 
16.04 wasn't officially released at the time and I didn't want to take 
chances with an unstable system):




https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS




Sound immediately worked with the latest version of Alsa's driver (March 24, 
2016 at the time) on Ubuntu 14.04. However, it came with a cost: this 
stuttering problem. I then retested with the live disc of Ubuntu 16.04 (this 
time after the official release date), which also produced sound but with the 
exact same stuttering problem.




I found that on Ubuntu 14.04, the stuttering problem remains unfixed since 
the March 24, 2016 release of the Alsa daily driver until at least the 
version I have installed in this bug report.




These facts strongly suggest an Alsa problem:
1. The problem does not occur at all on Windows, thus ruling out the 
possibility of a hardware problem.
2. I had no sound at all before installing the Alsa daily drivers, but did 
have stuttering sound after installing them.
3. The problem persists on Ubuntu 16.04, which suggests the problem is 
specific to the driver rather than the operating system.
4. The problem occurs whether playing a locally stored media file with a 
media player installed on my computer or watching an online video, thus 
ruling out the possibility that the problem is due to a single browser or 
plugin issue.
5. Is my hardware too new? Probably not. Here are the results of running 
"grep "Codec:" /proc/asound/card*/codec*":




/proc/asound/card0/codec#0:Codec: Realtek ALC891
/proc/asound/card1/codec#0:Codec: Nvidia Generic




The fact that my card is identified by vendor and chip name rather than ID as 
specified at https://wiki.ubuntu.com/Audio/HDAGeneric suggests that my 
hardware is supported. By the way, I'm using the Realtek, not the Nvidia 
HDMI.




I've tried disabling all unnecessary channels under alsamixer, but that 
didn't fix the problem. I tried all 3 potential fixes at 
https://wiki.ubuntu.com/Audio/PositionReporting, but none worked either. I 
commented my /etc/modprobe.d/alsa-base.conf and /etc/pulse/default.pa files 
appropriately to show what I tried (I know at least alsa-base.conf is 
uploaded).




I really appreciate the effort you developers put in to supporting sound on 
Linux. I hope my bug report will help fix this problem for a lot of users on 
Skylake systems.




More information and attached files can be found here (I filed a bug report 
with Ubuntu before I found out about Alsa's developer mailing list): 
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1580744
