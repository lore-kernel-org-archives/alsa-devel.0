From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Date: Sun, 7 Nov 2004 22:48:54 +0100
Message-ID: <200411072248.54627.rjw__10507.1676931859$1099865142$gmane$org@sisk.pl>
References: <200411062014.08202.rjw@sisk.pl> <20041107143858.GF1176@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.digitalservice.pl (grendel.digitalservice.pl [217.67.200.140])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 4BEEA1F9
	for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2004 22:50:03 +0100 (MET)
Received: from mail.digitalservice.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 21170-07 for <alsa-devel@alsa-project.org>;
 Sun,  7 Nov 2004 22:57:15 +0100 (CET)
In-Reply-To: <20041107143858.GF1176@elf.ucw.cz>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 07 of November 2004 15:38, Pavel Machek wrote:
> Hi!
> 
> > I'm having some troubles with swsusp on 2.6.10-rc1-mm3 (Athlon 64-based 
laptop 
> > w/ NForce3 chipset), although I don't think that swsusp itself is to
> > blame.
> 
> Did it work ok on other kernels?

On 2.6.10-rc1 it works even without pci=routeirq.  On 2.6.10-rc1-mm2 it did 
after I had used pci=routeirq, but I have tried it only once.

> Does it work when you rmmod intel8x0 before suspend?

Yes, it does, except for the pci=routeirq, which seems to be mandatory.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
