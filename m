From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa and locking
Date: Fri, 19 May 2006 19:09:46 +0200
Message-ID: <1148058586.6228.30.camel@johannes.berg>
References: <1148055062.6228.19.camel@johannes.berg>
	 <s5hd5eavvcj.wl%tiwai@suse.de> <1148057163.6228.26.camel@johannes.berg>
	 <s5hac9ene36.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pBnlv3hHKI4Z4wzydUY3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hac9ene36.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-pBnlv3hHKI4Z4wzydUY3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 19:01 +0200, Takashi Iwai wrote:
>=20
> Yes.  open/close are protected via open_mutex in the PCM core level for
> avoiding open races, but otherwise it's responsibility of the driver.=20

Ok, thanks. I'll look at it then (probably needs spin-locks since I need
those in the atomic parts too)

johannes

--=-pBnlv3hHKI4Z4wzydUY3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3716Vg1VMiehFYAQI0pBAAoxtERdCq6wmOTif2+WQMov5fnxJ8c0nd
iDHJSJv+YoLGscJzPyTO9aWkGdT3uqbMBb4Hl1+kglPQdNHfOPqlFe6HgdvvW+Am
TQOXfKyfVxikSek8odsJ+LM+aU85pY6ACxnCY4YnplbB2bCGEbC6TEg/eIp+EJOi
+R7DhgV6lkLD/qWyLMHL61Peo6kWRzC78NnhHH1eB7Y9KQGIoSD85xjermDRkSuA
FBrh1pXJQZjRrytZDDSd/IyTKddpMKqxpuIeXOF2PZCogcRDVqBfUp2wr01zoOkd
uTNSNHF5G5kbgPS2FFmIAa0FL7rgoHaGdZA6sFSn32LhCT+7LUjMwBdGrU3tzhwT
eekmXLxe5gl3FMTCWBe5mJVWJixDPrtEjuR89CYaXsDxpncyQAWPcEg5iqrj4k9f
9JuzHQp+Igb4Rx5g8P62gV0GxywCOgJ/gmLD+DKvH3DCxPUbuFvaX5m7ARvx0JzI
jy9nGjZNoealQrMD1xj92tu1cVDvb0yXyeO442aS5TcfyJpsOoC0/3CAWYqNfiv6
G4eXiiOSO3W3RQcUR/sMajvJdIgnI94WNo6GIfHUgqHQcmPBrD6mKpNoWrXrBqr3
hdx5sJwaRo3M4u7fKI6tY/36UdIXFQ8bMzF+NBEcwHvM00niyNWIeAfn+ToQfPsD
S4QhVNIW0PM=
=WnVH
-----END PGP SIGNATURE-----

--=-pBnlv3hHKI4Z4wzydUY3--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
