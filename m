From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices
	shouldn't depend on ISA
Date: Tue, 23 May 2006 12:27:50 -0400
Message-ID: <1148401671.12529.59.camel@mindpipe>
References: <20060419144008.GD24807@harddisk-recovery.com>
	 <1148357665.12529.17.camel@mindpipe>  <s5hbqtoyj5w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id BE2E615C
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 18:28:00 +0200 (MEST)
In-Reply-To: <s5hbqtoyj5w.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Erik Mouw <erik@harddisk-recovery.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-23 at 15:17 +0200, Takashi Iwai wrote:
> At Tue, 23 May 2006 00:14:24 -0400,
> Lee Revell wrote:
> >=20
> > On Wed, 2006-04-19 at 16:40 +0200, Erik Mouw wrote:
> > > The ALSA drivers for PCMCIA devices depend on ISA, but modern
> > > laptops can have PCMCIA support without ISA. This patch removes
> > > the dependency.
> > >=20
> >=20
> > I am pretty sure I found a case where the VXPocket driver failed
> > silently if CONFIG_ISAPNP is not set.  According to Takashi-san it is=
 a
> > PCMCIA bug not an ALSA bug.  It was a P4 laptop several years old.  I
> > don't have access to it right now but can get it.
> >=20
> > What additional information do you need to debug it?
>=20
> The combination of actually used drivers (PCMCIA bridge, etc)?
>=20

Asbj=F8rn, please provide lsmod and dmesg output.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
