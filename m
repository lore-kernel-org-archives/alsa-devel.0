From: "thewade" <pdman@aproximation.org>
Subject: Re: Change of iomem types
Date: Tue, 21 Sep 2004 11:05:12 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409211705.i8LH5CYI029513@sanctuary.aproximation.org>
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

> Now I took a look at hdsp code and found an obvious bug which likely
> has hit you.  Could you try the attached patch?

Hurray!

My RME Hammerfall works on a 64 bit machine!

On boot the kernel doesnt see the cardbus, but running hdsploader
uploads the firmware, my little angry red light (host error warning
light) goes away and my card works!

Also, hdspmixer wont display, which is weird, but amixer can do
everything hdspmixer can do I guess. I get a segfault if i run as
non-root and apparent opperation, but no display, as root.

Thank you SO MUCH! Now I have to get PD and GEM set up. Thank you Grand
Master Takashi Iwai!

-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
