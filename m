From: Martin Langer <martin-langer@gmx.de>
Subject: Re: National Semiconductor Corporation Open Source License
Date: Mon, 3 Mar 2003 12:23:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030303112332.GC465@tuba.home>
References: <20030301182634.GA465@tuba.home> <s5hptp8logd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptp8logd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 03, 2003 at 11:44:02AM +0100, Takashi Iwai wrote:
> At Sat, 1 Mar 2003 19:26:34 +0100,
> Martin Langer wrote:
> > 
> > 
> > Hi,
> > 
> > the ALSA-0.5 Geode Driver (geode.c) on
> > http://www.gctglobal.com/Download/alsa-geode.tar.gz 
> > which still waits for a port to 0.9 has the following license, which is not
> > GPL. Is it really possible to include such a license into the alsa package?
> > (I see the big problem in the export laws because the kernel is under GPL
> > without an export rule)
> 
> not all kernel sources are under GPL.
> 
> > I won't use this code, but I'm definitely no license expert. Or is it possible
> > to use a different license for a port (IMHO it's more than a modification, but
> > I don't know the definition of a lawyer in this case)
> > 
> > On the other hand I found another older file in the tgz called geode_BAK.c
> > without a license text. Same license, no license or GPL for that file?
> > 
> > Or can a port use a dual license (GPL/NSC OSL)?
> 
> Dual BSD/GPL are used in many drivers.
> 
> 	% grep -r 'MODULE_LICENSE("Dual BSD/GPL")' linux
> 	linux/fs/nls/nls_cp1250.c:MODULE_LICENSE("Dual BSD/GPL");
> 	linux/fs/nls/nls_cp1251.c:MODULE_LICENSE("Dual BSD/GPL");
> 	linux/fs/nls/nls_cp1255.c:MODULE_LICENSE("Dual BSD/GPL");
> 	linux/fs/nls/nls_big5.c:MODULE_LICENSE("Dual BSD/GPL");
> 	linux/fs/nls/nls_sjis.c:MODULE_LICENSE("Dual BSD/GPL");
> 	...
> 
> but, this driver code is terrible.  it's aceesing the PCI registers
> directly without the linux PCI API, and use the fixed irq, etc.

Right. My first attempt was without an fixed IRQ and it ends with:
ALSA cs5530.c:445: unable to grab IRQ 0

But the usage of fixed IRQ 5 in my code seems to work. Ok, I will have a
look into the manual, maybe I find some hints.


martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
