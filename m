From: "thewade" <pdman@aproximation.org>
Subject: Re: Change of iomem types
Date: Fri, 17 Sep 2004 19:35:35 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409180135.i8I1ZZoG007326@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

So, I swear I tried patch -p1 and it didnt work, but it did this time.

I patche kernel 2.6.8.1 with the rc2 patch and the bk3 patch to see if
the iomem fix by Takashi Iwai repaired my nonworking hdsp and Oops
causing hdsploader.

The kernel built fine, but on boot the kernel freezes at usb activation
if my USB mouse is pluged in. If I unplug it the kernel crashes on boot
at starting the loopback device.

Is there a patch I can run on my 2.6.8.1 kernel to fix the iomem stuff that doesnt mess with everything else?

When is the official release of 2.6.9 scheduled? Or 2.6.8.2?

Thanks again!
-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
