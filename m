From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: snd_pcm_hardware_t NOT pre-initialized
Date: Fri, 6 Sep 2002 09:58:22 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020906165822.8946.qmail@web11507.mail.yahoo.com>
References: <s5h8z2f1324.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA17260
	for <alsa-devel@alsa-project.org>; Fri, 6 Sep 2002 18:58:25 +0200
In-Reply-To: <s5h8z2f1324.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > snd_pcm_hardware_t is NOT pre-initialized, and drivers are responsible to
> > define ALL fields necessary. This is too bad, because it essentially means
> > that a new constraint (i.e. period_size_min + period_size_max) will need
> > to be supported by all drivers.
> 
> well, but drivers supporting G72x are very rare.
> then why bother to change the common code to affect every driver?

I sent a consolidated patch with the G.72x stuff of last week and the
constraint problem of today. Both matters are unrelated, and I apologize for
the inconvenience.

Please note that the G.72x stuff has no effect on existing drivers, and
therefore I would hope that it is accepted as well (rather than me maintaining
it separately).

> > I have tested successfully such a new constraint (patch in attachment), and
> > hope that you'll incorporate it in the cvs anyway.
> 
> it'd be better to add the constraint only if the period_size_min and
> max are non-zero, since most of drivers do NOT want to use this
> constraint.
> the similar should be applied to the period_bytes constraint if we
> add period_size constraint, because they may conflict with each
> other.

Agreed. I'll change that and send the patch (for the constraint stuff ONLY ;)
to you directly. Note this assumes that the compiler automatically sets
undefined members of the structure to zero.

Cheers!
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
