From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 5 Aug 2004 21:41:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408052132460.23417@denise.shiny.it>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B230E200
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 21:41:56 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
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



On Wed, 4 Aug 2004, Jaroslav Kysela wrote:

> 	the 1.0.6rc1 ALSA packages are available for testing.

cvscompile complains:

checking for which soundcards to compile driver for... configure: error:
Unsupported soundcard powermac

Even though configure --help shows it in the list.

My driver for the Echoaudio cards works fine after the required changes.
It's not heavily tested since I completed the port half hour ago but it
seems ok.

[Linux Jay 2.6.7 #3 SMP Thu Jul 29 20:51:56 CEST 2004 ppc unknown]


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
