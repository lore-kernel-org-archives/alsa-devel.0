From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: do apps need to care for xfer_align ???
Date: Mon, 9 Sep 2002 21:44:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209092106200.882-100000@pnote.perex-int.cz>
References: <20020909174357.84502.qmail@web11505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA11796
	for <alsa-devel@alsa-project.org>; Mon, 9 Sep 2002 21:46:28 +0200
In-Reply-To: <20020909174357.84502.qmail@web11505.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Sep 2002, Guilhem Tardy wrote:

> > It's software only limit for read/write transfers. The direct transfers
> > (mmap) don't take care about this limit. The idea is to avoid using very
> > small transfer chunks which are inefficient. Application might change
> > this value from 1 (no control) to buffer_size (in samples), but values
> > bigger than period_size hasn't any sense anyway.
> > 
> > The default value for xfer_align is period_size.
> 
> Since 'xfer_align' must be equal or greater than 'min_align', how can we get
> this value through the library?

The physical size of xfer_align * frame_size_in_bits must be multiple by 8,
of course. Adding bit copying in the kernel or library will cause a lot of 
overhead.

I've added this function to library:

snd_pcm_sframes_t snd_pcm_hw_params_get_min_align(const snd_pcm_hw_params_t *params)


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
