From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: .dimen order ?
Date: Mon, 24 Nov 2003 21:25:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311242123210.9896@pnote.perex-int.cz>
References: <20031124200810.5f4f55b2.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031124200810.5f4f55b2.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Nov 2003, Giuliano Pochini wrote:

> snd_ctl_elem_info_t.dimen contains the dimensions of the array of
> controls. AFAIK there are no drivers which use that feature (but mine)
> to look for examples. We have to agree about the order of them:
> 
> Array[d0][d1][d2][d3]
> 
> or
> 
> Array[d3][d2][d1][d0]
> 
> I used the first one. Is it ok ?

It doesn't matter. We need to define the meaning of dimensions at
a higher level anyway.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
