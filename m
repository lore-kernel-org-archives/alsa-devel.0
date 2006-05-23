From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Tue, 23 May 2006 15:35:32 +0200
Message-ID: <20060523133531.GB17815@harddisk-recovery.nl>
References: <20060419144008.GD24807@harddisk-recovery.com> <1148357665.12529.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from abra2.bitwizard.nl (dtp.xs4all.nl [80.126.206.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D6B57162
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 15:35:33 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1148357665.12529.17.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, May 23, 2006 at 12:14:24AM -0400, Lee Revell wrote:
> On Wed, 2006-04-19 at 16:40 +0200, Erik Mouw wrote:
> > The ALSA drivers for PCMCIA devices depend on ISA, but modern
> > laptops can have PCMCIA support without ISA. This patch removes
> > the dependency.
> > 
> 
> I am pretty sure I found a case where the VXPocket driver failed
> silently if CONFIG_ISAPNP is not set.  According to Takashi-san it is a
> PCMCIA bug not an ALSA bug.  It was a P4 laptop several years old.  I
> don't have access to it right now but can get it.

IMHO a single failure is not a reason to disable a feature for the rest
of the world. If that would be the case, we could as well disable
libata cause it fails for certain SATA chipsets...


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
