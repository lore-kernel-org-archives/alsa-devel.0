From: "thewade" <pdman@aproximation.org>
Subject: Re: Change of iomem types
Date: Thu, 16 Sep 2004 13:27:56 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409161927.i8GJRuCm004059@sanctuary.aproximation.org>
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

This sounds like it may fix my hdsploader/AMD64 problem.
I tried last night to patch 2.6.8.1 using the 2.6.9-rc2 patch
but patch -p2 < patch-2.6.9-rc2 wouldnt work. It wouldnt strip the 
a/ or b/ before the file path, so I edited the patch file and fixed 
all the paths: s/ a\\// linux\\// and s/ b\\// linux\\//

How can I get this new fix: kernel.org has the latest patch as
2.6.9-rc2 2004-09-13?

btw, I couldnt get the patched 2.6.9-rc2 kernel to boot. Because of the
above patch modification?

Thanks for the help, and thanks for the work Takashi!
-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
