From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: spin_lock_irqwhat ?
Date: Thu, 13 May 2004 20:57:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040513205751.6b61e53c.pochini@shiny.it>
References: <s5h3c68hbvc.wl@alsa2.suse.de>
	<XFMail.20040510165124.pochini@shiny.it>
	<s5hfza8fhfi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfza8fhfi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org


On Mon, 10 May 2004 17:08:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> prepare and trigger callbacks are already in irq-disabled.
> i.e. you need only spin_lock() in them.

Does it mean that ALSA acquires the lock only when it calls PCM callbacks,
that is trigger(), etc., are atomic only wrt other PCM functions ?


hdsp.c and rme9652.x use spin_*lock_irq() inside prepare().


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
