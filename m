From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Unusual pcm contraint
Date: Mon, 28 Apr 2003 18:00:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304281800120.1603-100000@pnote.perex-int.cz>
References: <XFMail.20030428174738.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030428174738.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Apr 2003, Giuliano Pochini wrote:

> 
> My card can manage substreams of 1, 2, 4, 6, 8 channels. Pcm_open()
> returns min=1, max=8, but it's not entirely true because 3, 5 and 7
> channels are not allowed. In such cases wh_params() returns -EINVAL.
> Is it ok or is there a cleaner way ?

See: pci/intel8x0.c and look for channels6.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
