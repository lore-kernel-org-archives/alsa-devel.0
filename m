From: Delusion's Master <delusion_master@hotmail.com>
Subject: Error patching file pcm_native.c
Date: Tue, 22 Sep 2009 14:39:36 +0200
Message-ID: <COL119-W10102D20FE7215072170378FDC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s1.col0.hotmail.com (col0-omc3-s1.col0.hotmail.com
	[65.55.34.139]) by alsa0.perex.cz (Postfix) with ESMTP id 819B11037EA
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 14:39:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

first of all I apologize in case you receive multiple copies of this message, but I forgot to specify a subject in the original mail.

I have a problem compiling the latest alsa driver snapshots. Specifically, it's a problem when patching pcm_native.c:

[..]
copying file alsa-kernel/core/info.c
patching file info.c
copying file alsa-kernel/core/pcm.c
patching file pcm.c
Hunk #3 succeeded at 739 (offset 2 lines).
Hunk #5 succeeded at 954 (offset 2 lines).
Hunk #7 succeeded at 1045 (offset 2 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #4 succeeded at 1544 (offset -25 lines).
Hunk #5 succeeded at 2827 (offset 12 lines).
Hunk #6 succeeded at 2878 (offset 10 lines).
Hunk #7 FAILED at 2906.
Hunk #8 FAILED at 2922.
Hunk #9 succeeded at 2915 (offset -23 lines).
Hunk #10 succeeded at 3036 (offset 10 lines).
Hunk #11 succeeded at 3027 (offset -23 lines).
Hunk #12 succeeded at 3074 (offset 10 lines).
Hunk #13 succeeded at 3098 (offset -23 lines).
Hunk #14 succeeded at 3143 (offset 10 lines).
Hunk #15 succeeded at 3124 (offset -23 lines).
Hunk #16 succeeded at 3214 (offset 10 lines).
Hunk #17 succeeded at 3208 (offset -23 lines).
Hunk #18 succeeded at 3271 (offset 10 lines).
Hunk #19 succeeded at 3304 (offset -23 lines).
Hunk #20 succeeded at 3386 (offset 10 lines).
Hunk #21 succeeded at 3411 (offset -23 lines).
Hunk #22 succeeded at 3456 (offset 10 lines).
Hunk #23 succeeded at 3450 (offset -23 lines).
Hunk #24 succeeded at 3525 (offset 10 lines).
Hunk #25 succeeded at 3644 (offset -23 lines).
2 out of 25 hunks FAILED -- saving rejects to file pcm_native.c.rej
make[2]: *** [pcm_native.c] Error 1


It's
some days I get this, but I waited to report this since I thought it
could be a temporary problem. My OS is Fedora 11 x86_64. Previous
snapshots didn't give me this problem, but I can't say which one broke
the compilation, since I usually try updated snapshots only at kernel
updates.

I searched for this error and the only relevant report I could find is this one:

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April/016420.html

a report from last April.

What could the problem be?
Thanks
 		 	   		   		 	   		  
_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Spaces. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
