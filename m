From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ALSA: hda - Defer probe when loading patch
	firmware
Date: Thu, 9 Aug 2012 09:57:16 +0200
Message-ID: <20120809075716.GB24808@avionic-0098.mockup.avionic-design.de>
References: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de>
 <s5hhascft86.wl%tiwai@suse.de>
 <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de>
 <s5hd330frn1.wl%tiwai@suse.de>
 <20120809073642.GA24695@avionic-0098.mockup.avionic-design.de>
 <s5h7gt8fr47.wl%tiwai@suse.de> <s5h393wfqqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7053701492377776949=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id E161E266124
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 09:27:35 +0200 (CEST)
In-Reply-To: <s5h393wfqqm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============7053701492377776949==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 09:50:57AM +0200, Takashi Iwai wrote:
> At Thu, 09 Aug 2012 09:42:48 +0200,
> Takashi Iwai wrote:
> >=20
> > At Thu, 9 Aug 2012 09:36:42 +0200,
> > Thierry Reding wrote:
> > >=20
> > > On Thu, Aug 09, 2012 at 09:31:30AM +0200, Takashi Iwai wrote:
> > > > At Thu, 9 Aug 2012 09:08:13 +0200,
> > > > Thierry Reding wrote:
> > > > >=20
> > > > > On Thu, Aug 09, 2012 at 08:57:13AM +0200, Takashi Iwai wrote:
> > > > > > At Thu,  9 Aug 2012 08:45:23 +0200,
> > > > > > Thierry Reding wrote:
> > > > > > >=20
> > > > > > > Recent changes to the firmware loading helpers cause drivers =
to stall
> > > > > > > when firmware is loaded during the module_init() call. The sn=
d-hda-intel
> > > > > > > module requests firmware if the patch=3D parameter is used to=
 load a patch
> > > > > > > file. This patch works around the problem by deferring the pr=
obe in such
> > > > > > > cases, which will cause the module to load successfully and t=
he driver
> > > > > > > binding to the device outside the module_init() call.
> > > > > >=20
> > > > > > Is the "recent" change meant 3.6 kernel, or in linux-next?
> > > > > >=20
> > > > > > In anyway, I don't understand why such a change was allowed.  M=
ost
> > > > > > drivers do call request_firmware() at the device probing time.
> > > > > > If this really has to be resolved in the driver side, it must b=
e a bug
> > > > > > in the firmware loader core code.
> > > > >=20
> > > > > A good explanation of the problem and subsequent discussion can b=
e found
> > > > > here:
> > > > >=20
> > > > > 	http://article.gmane.org/gmane.linux.drivers.video-input-infrast=
ructure/49975
> > > >=20
> > > > Yeah, but it doesn't justify this ugly module option.
> > > > It's a simple bug.  Papering over it with this option doesn't fix
> > > > anything.
> > >=20
> > > It's not an option, all it does is defer probing if and only if the
> > > patch parameter was specified to make sure the firmware load won't
> > > stall. I realize that this may not be an optimal solution, but at lea=
st
> > > it fixes the problem with no fallout.
> >=20
> > Ah sorry, I misread the patch.
> >=20
> > Then it shouldn't be checked at that point.  Since 3.5 kernel, the
> > probing code was already split for vga_switcheroo support.  The point
> > you added is the second stage.
>=20
> ... and the patch won't work properly if there are multiple HD-audio=20
> controllers.  Hmm.

Right... the deferred probe would mess up the matching done by the
static dev variable. So maybe a proper implementation that uses
asynchronous firmware loading is inevitable.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI21cAAoJEN0jrNd/PrOhAGYQAJIjDX5M4B/2cnixCCPv+tOi
UOf5KCQjRPoMS1fKZJzD8t7UVP+TidIPh66ElNgUu3tz9GksAPO3Pmsfsw9kbigc
eXugF3v1WGBUlQ1xRYYbPRoVIP5dd2/sCXQ31WdGy0XsKgemoh+Jzt0a1IJxnzkH
0K/mzgDon0dmILF0M6wZ1A2W3k7aB7PHZ25bOvcUJ4Hb4Hmt2Qkl4/Wflv/WgbUM
9+p24Jm1bU3U6nub0/EvCHqi7rUp+iTcBmzoNzDPQAgJAJ8XAth/d8tmX3UVz7eg
hYAfWA+zX7GIZ61E63rIy+7QWXj/NOeexPqVpGtEW3puUSLIKogtgOhqZ0SrQUEU
5YXqhuGaigNwYu6Im+0MigqazM9am5ZtF1Lgv0xADcWe9z7/UR8VE0vV5SpIlOBV
yeCDlOJifsexoDYo024wnYUi0DdRanTeAGz13SADkC686uz2dRj2CPObQTYrexxA
t4gdgd6eCvKW2ydZ0JxuPMzqlghjv5KqfmOpMeMLr69HH//WVCt4owE16xnh/YC+
QfB1aG4athb88LjKC4mcg9vZ5oZD2G+BOd7kdCKZuWYWoL0ixInWAhZi9QUGviI9
6H7+AM06Z3DCDD6mar7iaca4iJyQA475c9JHS7wZFS/ANCuSfj2oOX5DGnAaK/El
eebILoVGhiSrgFukuOnh
=SbLW
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============7053701492377776949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7053701492377776949==--
