From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: exit() -> _exit() in pcm_direct.c
Date: Wed, 30 Jul 2003 19:20:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307301918500.9821-100000@pnote.perex-int.cz>
References: <200307302021.37432.s.k.v@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307302021.37432.s.k.v@mail.ru>
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

On Wed, 30 Jul 2003, Konstantin Stepaniuk wrote:

> Hello.
> 
> My program call snd_pcm_open() with "plug:dmix" in thread.
> Function snd_pcm_direct_server_create() hangs on waitpid() if exit() is used, 
> and server_job process keeps alive after program exit.
> This trivial patch chages exit() to _exit() in file pcm_direct.c. In this case 
> all works ok for me.

I'm sorry, but I still don't see a reason (I'd like to know, why the 
process hangs). Could you explain the behaviour or send me a simple test 
code to debug this thing?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
