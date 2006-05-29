From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices
	shouldn't depend on ISA
Date: Mon, 29 May 2006 11:28:12 +0200
Message-ID: <20060529092812.GC14419@harddisk-recovery.nl>
References: <20060419144008.GD24807@harddisk-recovery.com>
	<1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de>
	<1148401671.12529.59.camel@mindpipe>
	<20060524145800.GA2621@stud.ntnu.no>
	<20060524151554.GB12022@harddisk-recovery.nl>
	<20060524204815.GB11570@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from abra2.bitwizard.nl (dtp.xs4all.nl [80.126.206.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DA0F016B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 11:28:13 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060524204815.GB11570@dominikbrodowski.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Asbj?rn S?b? <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 24, 2006 at 10:48:15PM +0200, Dominik Brodowski wrote:
> On Wed, May 24, 2006 at 05:15:54PM +0200, Erik Mouw wrote:
> > > dmesg:
> > > ------
> > > Linux version 2.6.16.11-vanilla (root@dhcp91) (gcc version 4.0.3 (Debian 4.0.3-1)) #1 PREEMPT Sat Apr 29 10:13:31 CEST 2006
> > 
> > Could you try to recreate the problems with a more recent kernel?
> > (2.6.16.18, 2.6.17-rc4, or the latest -git). git-whatchanged shows
> > there were 189 changes in drivers/pcmcia/ since 2.6.11,
> 
> That's already 2.6._16_.11, and I don't think there are significant changes in
> PCMCIA up to 2.6.16.18 ;-)

Woops, you're right, didn't see the 16.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
