From: Pavel Roskin <proski@gnu.org>
Subject: Re: integration of via668 and via8233 drivers
Date: Thu, 5 Sep 2002 11:49:29 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209051147150.13013-100000@marabou.research.att.com>
References: <s5hsn0ola3a.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsn0ola3a.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > The emu10k1 ALSA driver has been working fine on the same machine.  The
> > VIA audio is integrated.  The via686 driver worked with the internal audio
> > before I installed SB Live, which must have been some time in March of
> > this year.
> 
> hmm, this recalls some posts on l-k ml in the last year.
> it might be a hardware problem, namely, VIA motherboards.
> is your motherboard KT266A?

No, it's KT-133.

> this should be irrelevant.  it changed the code around ac97 codec
> reset.  if it fails, you'll hear nothing.

Ok, there are not many revisions of the driver, so I hope to locate the
breakage quite fast.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
