From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to compile ?
Date: Sun, 2 Mar 2003 20:24:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303022021550.1253-100000@pnote.perex-int.cz>
References: <1046628444.1023.37.camel@Jay>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046628444.1023.37.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 2 Mar 2003, Giuliano Pochini wrote:

> I wrote a very minimal driver that does nothing and I put it
> in /pci directory. How do I compile it ?

alsa-driver or alsa-kernel ? I recommend using alsa-driver directory for 
tests.

1) update Makefile (see ALSA extra code section)
2) add module dependency definition to alsa-driver/utils/Modules.dep
3) check alsa-driver/acore/Makefile to add missing dependencies

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
