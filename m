From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: preallocate_pages_for_all
Date: Wed, 19 May 2004 19:58:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040519195838.31280666.pochini@shiny.it>
References: <20040515233759.0ea62c06.pochini@shiny.it>
	<Pine.LNX.4.58.0405161553300.1776@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405161553300.1776@pnote.perex-int.cz>
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

On Sun, 16 May 2004 15:55:29 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> > snd_pcm_lib_preallocate_pages_for_all() preallocates the buffers for the
> > first 4 substreams by default. Can I change that number from the driver ? I
> > would like to preallocate a buffer only for the first subdev, or maybe for
> > the first, the 3rd, the 5th...
>
> Then use snd_pcm_lib_preallocate_pages() function directly in your own loop.

Right. I didn't see that I could pass size = 0.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
