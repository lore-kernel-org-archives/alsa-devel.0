From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: do apps need to care for xfer_align ???
Date: Tue, 10 Sep 2002 07:49:01 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020910144901.26770.qmail@web11504.mail.yahoo.com>
References: <Pine.LNX.4.33.0209092106200.882-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11504.mail.yahoo.com (web11504.mail.yahoo.com [216.136.172.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA27770
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 16:49:08 +0200
In-Reply-To: <Pine.LNX.4.33.0209092106200.882-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav,

I am working on a conferencing application, and need to deal with audio packets
of various sizes (in sample).

> > It's software only limit for read/write transfers. The direct transfers
> > (mmap) don't take care about this limit. The idea is to avoid using very
> > small transfer chunks which are inefficient. Application might change
> > this value from 1 (no control) to buffer_size (in samples), but values
> > bigger than period_size hasn't any sense anyway.

The application writer who chooses to send audio in chunks of any size then
must (and can) also set xfer_align to 1. Which is what I would do to avoid
having:
 1) audio systematically dropped at the end of each chunk, and
 2) writei() return a value different from the number of frames passed to it
(which is usually treated as an error)

> The physical size of xfer_align * frame_size_in_bits must be multiple by 8,
> of course. Adding bit copying in the kernel or library will cause a lot of 
> overhead.

Agreed.
To me, this only means that period_size must be a multiple of min_align. Any
number of samples given to write1() in alsa-kernel/core/pcm_lib.c should be
supported already by the current code, except for the xfer_align check at the
top of the function.

> I've added this function to library:
> 
> snd_pcm_sframes_t snd_pcm_hw_params_get_min_align(const snd_pcm_hw_params_t
> *params)

That certainly is helpful, thank you.

Regards,
Guilhem.


__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
