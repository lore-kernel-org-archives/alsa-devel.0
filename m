From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] set up an sync channel between audio and
 display driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 20:05:55 +0530
Message-ID: <20140520143555.GD21128@intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0512975866=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1400596147.32158.36.camel@intelbox>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Imre Deak <imre.deak@intel.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0512975866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 05:29:07PM +0300, Imre Deak wrote:
> On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
> > This RFC is based on previous discussion to set up a generic
> > communication channel between display and audio driver and
> > an internal design of Intel MCG/VPG HDMI audio driver. It's still an
> > initial draft and your advice would be appreciated
> > to improve the design.
> > =20
> > The basic idea is to create a new avsink module and let both drm and
> > alsa depend on it.
> > This new module provides a framework and APIs for synchronization
> > between the display and audio driver.=20
> > =20
> > 1. Display/Audio Client
> > =20
> > The avsink core provides APIs to create, register and lookup a
> > display/audio client.
> > A specific display driver (eg. i915) or audio driver (eg. HD-Audio
> > driver) can create a client, add some resources=20
> > objects (shared power wells, display outputs, and audio inputs,
> > register ops) to the client, and then register this=20
> > client to avisink core. The peer driver can look up a registered
> > client by a name or type, or both. If a client gives
> > a valid peer client name on registration, avsink core will bind the
> > two clients as peer for each other. And we=20
> > expect a display client and an audio client to be peers for each other
> > in a system.
>=20
> One problem we have at the moment is the order of calling the system
> suspend/resume handlers of the display driver wrt. that of the audio
> driver. Since the power well control is part of the display HW block, we
> need to run the display driver's resume handler first, initialize the
> HW, and only then let the audio driver's resume handler run. For similar
> reasons we have to call the audio suspend handler first and only then
> the display driver resume handler. Currently we solve this using the
> display driver's late/early suspend/resume hooks, but we'd need a more
> robust solution.
>=20
> This seems to be a similar issue to the load time ordering problem that
> you describe later. Having a real device for avsync that would be a
> child of the display device would solve the ordering issue in both
> cases. I admit I haven't looked into it if this is feasible, but I would
> like to see some solution to this as part of the plan.

If we are able create and mandate that HDMI display controller is parent and
audio is child device, then this wouldn't be an issue and PM frameowrk will
ensure parent is suspended last.

--=20
~Vinod

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTe2hLAAoJEHwUBw8lI4NHgWIP/2lZkdRrk05q00Mp38np48Qi
aRbX+8bbDabMfw/KCfGWWySz+9Php/ca1j8tIT0E8OIGhlLEiNaCVMSmJf5rjy77
i0mCX7WYmjtpUJAHKoGlvrZllrN9yggn34/eFv74FkO00Xe+10EbJZKOY4cuAb+F
hT62pb/o4taGb9YICfonudHHMU9iqi0z1PS7FUjYMaqUJJQuFAYMIdb2nsZNITkU
uN+1UyEM6zWB9oT8mD4qWELNGtmEzmbO9efKdyZcg46O9pXU2c/KtgflLRv9uSv4
AzTGXKCcAauI07OsacIudTpryUUXAz5UzRKzpiEI0KHBwCgKOfQSrcZfiQCHG27G
wKZwvogW8ASTX0UL/JU4r5XRPnH5cns+U0tJSlfo9+n4vnQmxxY9OC3OY60GJ7rv
KCMicfEmhEotbHovK/Ei7agcgU1k7DQkBuRfbRvHqfOWQpwfY2aLRQptS10dhrjZ
Wapfx+2bFf95as1GXXKT3AGf4lebXgiFPbeNyNCfExDWfd5DM864bU7/C/GbI05G
YO+0wyh6bDyR4eCvtCHIUKv6qgA4UzlJV8Y/gx57b+nB0J2IB4kDTWei7kEk4h3B
/40jE8nsIZCymcZS7iQnnIzeA2129PPN4yKpe625NfGnioqk2br7fJVNbUnV1duf
kAGrsPxkHDNqjl4onzGE
=aXdb
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--===============0512975866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0512975866==--
