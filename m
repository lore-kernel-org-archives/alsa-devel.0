From: Chris Ruvolo <chris+lkml@ruvolo.net>
Subject: alsa sbawe fails w/o isapnp (was: garbage in /proc/ioports and oops)
Date: Mon, 28 Jul 2003 09:20:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030728162018.GA24886@ruvolo.net>
References: <20030718011101.GD15716@ruvolo.net> <20030717211533.77c0f943.akpm@osdl.org> <20030718150429.GE15716@ruvolo.net> <20030727163812.75b98b02.akpm@osdl.org> <20030727224357.GA27040@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030727224357.GA27040@neo.rr.com>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2003 at 10:43:57PM +0000, Adam Belay wrote:
> > The fix would be to run release_region() either at the end of
> > snd_sb16_probe() or on module unload.
> >=20
> > Adam or Jaroslav, could you please take care of this?
>=20
> I believe this will fix it.  Testing would be appreciated.

Adam,

Yes, this looks good.  The module loads and fails cleanly.  /proc/ioports is
then readable.  Thanks for this fix.

However, this doesn't fix the loading of the module without in-kernel isapn=
p.

# modprobe --verbose snd-sbawe
insmod /lib/modules/2.6.0-test1/kernel/sound/isa/sb/snd-sbawe.ko
sbawe: fatal error - EMU-8000 synthesizer not detected at 0x620
Sound Blaster 16 soundcard not found or device busy
In case, if you have non-AWE card, try snd-sb16 module
FATAL: Error inserting snd_sbawe (/lib/modules/2.6.0-test1/kernel/sound/isa=
/sb/snd-sbawe.ko): No such device

Specifying the parameters (port, irq, awe_port, etc.) doesn't seem to help.
In-kernel isapnp has been working though.

Thanks
-Chris

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/JU1CKO6EG1hc77ERAsyVAJ9v4WWEYl8eTTMknmKGC6+1eyNBZQCfTrJS
/SGqjZN25HGvOp2W55Ndnu0=
=4dS7
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
