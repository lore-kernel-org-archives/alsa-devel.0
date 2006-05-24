From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Wed, 24 May 2006 22:48:15 +0200
Message-ID: <20060524204815.GB11570@dominikbrodowski.de>
References: <20060419144008.GD24807@harddisk-recovery.com> <1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de> <1148401671.12529.59.camel@mindpipe> <20060524145800.GA2621@stud.ntnu.no> <20060524151554.GB12022@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40C6E171
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 22:52:52 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060524151554.GB12022@harddisk-recovery.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 24, 2006 at 05:15:54PM +0200, Erik Mouw wrote:
> > dmesg:
> > ------
> > Linux version 2.6.16.11-vanilla (root@dhcp91) (gcc version 4.0.3 (Debian 4.0.3-1)) #1 PREEMPT Sat Apr 29 10:13:31 CEST 2006
> 
> Could you try to recreate the problems with a more recent kernel?
> (2.6.16.18, 2.6.17-rc4, or the latest -git). git-whatchanged shows
> there were 189 changes in drivers/pcmcia/ since 2.6.11,

That's already 2.6._16_.11, and I don't think there are significant changes in
PCMCIA up to 2.6.16.18 ;-)


	Dominik


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
