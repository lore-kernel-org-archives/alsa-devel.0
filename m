From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: via82xx: unreliable audio, strange mixer behavior
Date: Mon, 24 Nov 2008 15:03:06 -0500
Message-ID: <20081124200306.GA14292@storm.local.network>
References: <20081120170409.GG17813@storm.local.network>
	<s5hk5ax8f3l.wl%tiwai@suse.de>
	<20081121120823.GD3899@storm.local.network>
	<s5hfxll8cj0.wl%tiwai@suse.de>
	<20081121163256.GE3899@storm.local.network>
	<s5h4p21kpcu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4382401342590355104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.webfaction.com (mail3.webfaction.com [70.85.44.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D85C24444
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 21:03:16 +0100 (CET)
In-Reply-To: <s5h4p21kpcu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4382401342590355104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 21, 2008 at 05:36:49PM +0100, Takashi Iwai wrote:
> At Fri, 21 Nov 2008 11:32:56 -0500,
> Forest Bond wrote:
> >=20
> > On Fri, Nov 21, 2008 at 01:54:43PM +0100, Takashi Iwai wrote:
> > > At Fri, 21 Nov 2008 07:08:23 -0500,
> > > Forest Bond wrote:
> > > > On Fri, Nov 21, 2008 at 12:59:10PM +0100, Takashi Iwai wrote:
> > > > > At Thu, 20 Nov 2008 12:04:09 -0500,
> > > > > Forest Bond wrote:
> > > > >>=20
> > > > >> Hi,
> > > > >>=20
> > > > >> I'm using snd-via82xx on an Ubuntu 8.04 system.  alsa-info.sh ou=
tput is here:
> > > > >>=20
> > > > >> http://www.alsa-project.org/db/?f=3D1c3d5570e7b57d4d2f79b964a323=
dd7b4efd7e78
> > > > >>=20
> > > > >> Here are the symptoms:
> > > > >>=20
> > > > >> Audio goes away after a semi-random interval.  Sometimes it retu=
rns after
> > > > >> `modprobe -r snd-via82xx' followed by `modprobe snd-via82xx', bu=
t sometimes it
> > > > >> seems to take a full reboot.
> > > > >>=20
> > > > >> This looks similar to:
> > > > >>=20
> > > > >> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3D3194
> > > > >>=20
> > > > >> Some folks think that this kind of issue is triggered by audio v=
olume being
> > > > >> above a certain level.  I'm not entirely sure if this is true, b=
ut I think it
> > > > >> is.  One time, I apparently triggered the issue by unplugging an=
d replugging the
> > > > >> audio cable from the mainboard during playback.
> > > > >>=20
> > > > >> Audio can be heard even when the PCM volume level is 0 (as told =
by alsamixer).
> > > > >> The volume does get louder when I turn up that mixer control, bu=
t it never goes
> > > > >> away entirely when I turn the volume to zero.  Mute works as exp=
ected.
> > > > >=20
> > > > > The volume 0 doesn't always mean the mute on several hardwares.
> > > > > So this can be irrelevant if it happens always.
> > > > >=20
> > > > > I vaguely remember about the low-power mode of some codec chips.
> > > > > Which codec chip does your system have?  Please run alsa-info.sh =
with
> > > > > --no-upload option, and attach the output file.
> > > >=20
> > > > The output would be the same as what was already uploaded, right?  =
I've attached
> > > > that output here for your convenience.
> > >=20
> > > Thanks, it's always better to post the content than a URL.
> > >=20
> > > Any chance to try the later version of alsa-driver?
> > > Yours looks pretty old.
> >=20
> > I can try this a bit later today.  I'll report the results ASAP.
>=20
> BTW, try the one from the URL below instead of 1.0.18a.
> This contains the newest  alsa-driver snapshot:
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driv=
er-snapshot.tar.gz

Brief testing indicates that 1.0.18a seems to fix the issue, actually.  Sor=
ry, I
forgot that you had asked me to test the snapshot.

Would it be helpful for you for me to try the snapshot as well (maybe to ch=
eck
for a regression)?  Any idea as to what change may have fixed this?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJKwh6RO4fQQdv5AwRAjD8AJ0c7nSSkMpPTkKNqU05DFh56CDXCACfX0Tr
O7tkdeef2JHgRyRgk8jp/AE=
=lbfB
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

--===============4382401342590355104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4382401342590355104==--
