From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: do apps need to care for xfer_align ???
Date: Mon, 9 Sep 2002 10:43:57 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020909174357.84502.qmail@web11505.mail.yahoo.com>
References: <Pine.LNX.4.21.0209091638060.10104-100000@gate.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11505.mail.yahoo.com (web11505.mail.yahoo.com [216.136.172.37])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id TAA10137
	for <alsa-devel@alsa-project.org>; Mon, 9 Sep 2002 19:44:04 +0200
In-Reply-To: <Pine.LNX.4.21.0209091638060.10104-100000@gate.perex.cz>
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

> It's software only limit for read/write transfers. The direct transfers
> (mmap) don't take care about this limit. The idea is to avoid using very
> small transfer chunks which are inefficient. Application might change
> this value from 1 (no control) to buffer_size (in samples), but values
> bigger than period_size hasn't any sense anyway.
> 
> The default value for xfer_align is period_size.

Since 'xfer_align' must be equal or greater than 'min_align', how can we get
this value through the library?

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
