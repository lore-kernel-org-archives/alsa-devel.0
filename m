From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Date: Sun, 7 Nov 2004 15:38:58 +0100
Message-ID: <20041107143858.GF1176__36177.6801445105$1099839010$gmane$org@elf.ucw.cz>
References: <200411062014.08202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amd.ucw.cz (gprs214-134.eurotel.cz [160.218.214.134])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 76E00294
	for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2004 15:39:07 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <200411062014.08202.rjw@sisk.pl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

> I'm having some troubles with swsusp on 2.6.10-rc1-mm3 (Athlon 64-based laptop 
> w/ NForce3 chipset), although I don't think that swsusp itself is to
> blame.

Did it work ok on other kernels? Does it work when you rmmod intel8x0
before suspend?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
