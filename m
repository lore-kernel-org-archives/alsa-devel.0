From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices
	shouldn't depend on ISA
Date: Wed, 24 May 2006 17:02:18 -0400
Message-ID: <1148504539.22215.11.camel@mindpipe>
References: <20060419144008.GD24807@harddisk-recovery.com>
	 <1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de>
	 <1148401671.12529.59.camel@mindpipe> <20060524145800.GA2621@stud.ntnu.no>
	 <20060524204653.GA11570@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id BD6A012A
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 23:02:30 +0200 (MEST)
In-Reply-To: <20060524204653.GA11570@dominikbrodowski.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Takashi Iwai <tiwai@suse.de>, Erik Mouw <erik@harddisk-recovery.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-05-24 at 22:46 +0200, Dominik Brodowski wrote:
> Hi,
>=20
> On Wed, May 24, 2006 at 04:58:00PM +0200, Asbj=F8rn S=E6b=F8 wrote:
> > Note that the vxpocket must be hotplugged to be recognised. =20
> > Cold-plugging it (having it already in the computer when booting) is =
not=20
> > sufficient.
>=20
> Seems the driver needs a firmware which it cannot find:
>=20

This hotplug/coldplug issue is a relatively minor problem.  The real
problem is that it would not work at all (completely silent failure, did
not even try to load firmware, no messages from driver) without
CONFIG_ISAPNP.

Lee




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
