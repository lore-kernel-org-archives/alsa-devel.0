From: Paul Davis <pbd@op.net>
Subject: OSS compatibility w/multichannel cards
Date: Sat, 6 Jul 2002 12:33:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207061633.g66GXK922995@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03222
	for <alsa-devel@alsa-project.org>; Sat, 6 Jul 2002 18:32:31 +0200
Received: from unknown (HELO op.net) ([209.92.230.69]) (envelope-sender <pbd@op.net>)
          by newmx2.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 6 Jul 2002 16:32:15 -0000
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

it appears that the ice1712 driver, at least for some midiman cards,
can provide OSS compatibility "out of the box". this seems hard, since
the h/w has 10 channels, and alsa-driver/alsa-kernel doesn't do
channel conversion or mapping. similarly, there seems only to be
support for 32 bit samples (storage format). yet OSS apps using 2
channels and 16 bit samples work with this card.

since this doesn't work for the Hammerfall and H-DSP drivers, and
since i don't understand how it could work given that ALSA doesn't do
this kind of stuff in the kernel, i am wondering how this is
happening.

jaroslav or takashi - can you fill me in? there is some expectation
that OSS emulation work for the Hammerfall drivers as well, even
without LD_PRELOAD, and i can't understand how it could be possible.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Got root? We do.
http://thinkgeek.com/sf
