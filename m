From: Russell Neches <russell@ccs.neu.edu>
Subject: snd-nm256 crash
Date: 11 Aug 2002 22:08:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87bs88bzgq.fsf@zento.c-dart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amber.ccs.neu.edu (postfix@[129.10.116.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA26328
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 04:09:12 +0200
Received: from zento.c-dart.com (denali.ccs.neu.edu [129.10.116.200])
	by amber.ccs.neu.edu (Postfix) with ESMTP id 0671B1AA1B
	for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2002 22:08:55 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hey there --

I'm trying to get my laptop working with ALSA, but, sadly, my laptop
contains the lamentable NeoMagic 256AV chip. With ALSA 0.9.0beta12,
loading snd-nm256 causes the machine to lock up so tight that the soft
power switch stops working. 

I presume that if the module is included with ALSA that it has at
least "been known to work." I've tried 2.4.18 and 2.4.19 (both regular
old generic unpatched source tarballs from kernel.org), with identical
results. 

I'm converting all my various Linux boxen to ALSA, but this has been
the only one that's up and crashed. I'm new to the ALSA codebase, so
I'm not sure where to start. At the very least, I'd like to submit a
coherent bug report. Would anyone mind helping me understand what is
(and isn't) broken?

Thanks!

Russell





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
