From: Dennis Veatch <dveatch@woh.rr.com>
Subject: 0.9.7c, cs4236b and kernel oops
Date: Tue, 14 Oct 2003 21:24:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310142124.56447.dveatch@woh.rr.com>
Reply-To: dveatch@woh.rr.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a Dell GX1 with a cs4236b integrated sound card. Running kernel 
version 2.4.20. I have tried recompiling the kernel any number of ways making 
the sound stuff modules and part of the kernel all with the same results. I 
have wiped out /lib/modules and /usr/src/linux entirely, re-downloaded all 
the kernel stuff and still had the same results. If I use the 0.9.6 version 
of alsa-driver there are no problems.

During boot up it does show the cs4236b being detected correctly. I can 
install Mandrake 9.1 on this box and there is not kernel oops.

If I comment out the alsa line in /etc/modules.conf the system will boot. Then 
if I modprobe soundcore, things are still fine. If I try modprobing the 
snd-cs4236, boom, kernel oops.

Up until alsa-driver version 0.9.6 the sound card worked fine. No problems.  
So I am reasonable sure this has nothing to do with the kernel.

Since versions 0.9.7a, b and c any attempt to load the cs4236 stuff causes a 
kernel oops. Below is some of the oops.

I have looked over the alsa web site and googled on this issue only to find 
some what dated information that leads me to believe this was an issue at one 
time but was supposed to have been corrected by now.
_______________________________________________________
Staring sound driver: snd-cs4236 Unable to handle kernel NULL point 
dereference at virtual address 00000060
printing eip:
f887752b
*pde = 00000000
Oops: 0000
.
.
.
.
.
.

and ends with;

<0>Kernel panis: Aiee, killing interrupt handler!
In interrupt handler - not syncing
-- 
Registered Linux user 193414
http://counter.li.org

"Trying"? My contribution was much closer to a "feeble wave in the general 
direction of something that might lead you one step closer to a solution 
if you squint really hard and do all of the work."



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
