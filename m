From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: reopen with "plug:dmix" failure
Date: Tue, 15 Jul 2003 21:15:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307152108390.27533-100000@pnote.perex-int.cz>
References: <200307151409.21657.s.k.v@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307151409.21657.s.k.v@mail.ru>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Konstantin Stepaniuk <s.k.v@mail.ru>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Jul 2003, Konstantin Stepaniuk wrote:

> Dear Jaroslav Kysela.
> 
> I wrote some example which illustrates problem described in previous message. 
> Also I want you to make some fixes in your library which can avoid this 
> problem. First of all I discommented lines 325-326 in file pcm_direct.c 
> (because even after application stopped server still process and device 
> /dev/snd/pcmC0D0p locked). After that I added one line, which unlink 
> temporary file /tmp/alsa-dmix*.

Your fixes does not solve the real problem and causes another deadlock.

I have tried to solve the problem. Could you try the current CVS code?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
