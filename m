From: Dominique Dumont <domi.dumont@free.fr>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 05 Aug 2004 22:38:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87y8kt48xt.fsf@free.fr>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix4-1.free.fr (postfix4-1.free.fr [213.228.0.62])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DFB2B220
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 22:38:42 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz> (Jaroslav
 Kysela's message of "Wed, 4 Aug 2004 20:51:08 +0200 (CEST)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> 	the 1.0.6rc1 ALSA packages are available for testing.

Compiles fine with debian's kernel 2.6.7.

So far:
- PCM spdif on intel8x0 and nforce2 is working fine
- AC3 spdif on nforce2 (ALC650F) is still not working (No change wrt
  1.0.4. See bug 411 [1] for details)
- PCM spdif on emu10k1 (SBlive digital live 5.1) is severily distorted
  when playing musing. Speech is fine. (BTW, why has the spdif device
  changed from hw:0,3 to hw:0,2 ? )

HTH

[1] https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000411


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
