From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: do apps need to care for xfer_align ???
Date: Fri, 6 Sep 2002 12:49:26 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020906194926.38406.qmail@web11501.mail.yahoo.com>
References: <s5h4rd30yyb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11501.mail.yahoo.com (web11501.mail.yahoo.com [216.136.172.46])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA19704
	for <alsa-devel@alsa-project.org>; Fri, 6 Sep 2002 21:49:33 +0200
In-Reply-To: <s5h4rd30yyb.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

While trying to understand snd_pcm_lib_write1(), I found that
runtime->xfer_align is set to period_size in pcm_native.c, but wonder if it is
just a default?

Paul Davis' example (at http://www.op.net/~pbd/alsa-audio.html#playex) doesn't
check for a particular transfer size, and my card supports playout of less than
160 samples (i.e. the period size). Thus, I set to try playing out 512 bytes at
a time (i.e. 2048 samples of 2-bit ADPCM), which does NOT come to a multiple of
period size. The result is that only 1920 samples are played, and my app thinks
an error has occured.

Is it a general requirement for apps to send only audio in multiple of the
period size?

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
