From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: snd_card_new() and snd_magic
Date: Sat, 18 Sep 2004 16:12:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040918151205.GA31441@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just figured out I can't use the last parameter on snd_card_new()
if I want to use the snd_magic stuff. But that leaves me with some
questions:

1) Why can't/won't snd_card_new() call snd_magic_kcalloc()?
2) Why would a driver NOT want to support snd_magic? Seems to me it's
completely benign if you turn off the kernel option.

A bit confused, but getting there...
-- 
Martin


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
