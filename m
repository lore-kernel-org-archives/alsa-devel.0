From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Wed, 24 May 2006 17:15:54 +0200
Message-ID: <20060524151554.GB12022@harddisk-recovery.nl>
References: <20060419144008.GD24807@harddisk-recovery.com> <1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de> <1148401671.12529.59.camel@mindpipe> <20060524145800.GA2621@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from abra2.bitwizard.nl (dtp.xs4all.nl [80.126.206.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DD2B3179
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 17:15:56 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060524145800.GA2621@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 24, 2006 at 04:58:00PM +0200, Asbj=F8rn S=E6b=F8 wrote:
> On Tue, May 23, 2006 at 12:27:50PM -0400, Lee Revell wrote:
> > Asbj=F8rn, please provide lsmod and dmesg output.
>=20
> Here you are, lsmod, dmesg and lspci (for good measure)
>=20
> Note that the vxpocket must be hotplugged to be recognised. =20
> Cold-plugging it (having it already in the computer when booting) is no=
t=20
> sufficient.

[...]

> dmesg:
> ------
> Linux version 2.6.16.11-vanilla (root@dhcp91) (gcc version 4.0.3 (Debia=
n 4.0.3-1)) #1 PREEMPT Sat Apr 29 10:13:31 CEST 2006

Could you try to recreate the problems with a more recent kernel?
(2.6.16.18, 2.6.17-rc4, or the latest -git). git-whatchanged shows
there were 189 changes in drivers/pcmcia/ since 2.6.11, so it might
very well be possible that the dependency on ISA and the cold plugging
are already solved.


Erik

--=20
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
