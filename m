From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Tue, 20 Oct 2015 08:59:44 +0530
Message-ID: <20151020032944.GY27370@localhost>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
 <1444741706.2926.16.camel@intel.com>
 <20151020001536.GW32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6147976821318354952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 72EB2265E0C
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 05:26:32 +0200 (CEST)
In-Reply-To: <20151020001536.GW32054@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Patches Audio <patches.audio@intel.com>, "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "ykk@rock-chips.com" <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org


--===============6147976821318354952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 01:15:36AM +0100, Mark Brown wrote:
> On Tue, Oct 13, 2015 at 01:08:27PM +0000, Koul, Vinod wrote:
>=20
> > Apart from comments from Russell I didn't get any other comments.
>=20
> There were mails from the LKP bot saying this didn't build...

That was due to dependency on patches Takashi applied which add the
read/write helpers.
Also I did miss one patch to add codec point in hdac device, will send that
one as well in next rev. Have also fixed the patch 4 to use info frame
handlers rather than earlier open code

Will send updated series later today which has been tested with latest
Takashi patches for auto loading these devices

Thanks
--=20
~Vinod

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJbUoAAoJEHwUBw8lI4NH2qAQAM1UVRItfDyl+/wB/XAyd4JY
aLyFG4d5J0KFHJiw1LK54B3jmKyCXTL+9uFCykcTAsbNtqndGzURJmC3UjjLbWo+
42bBFiNxrgKU94jqCg4Kl78jEb9mvTMGvZcK6vclzwv0k+jo1zcVV5FCS15oRLXo
jiZBGyoojzz6/WpadhHntkbZgK+y5FM/OJJ/nuKOqubIi/XvWNL/RXpblzFmfOey
lDaU+zxHz2Sg4TUn0N7aipwXr69u3yNRmZ5hhhXRD5BJuBPmh8WyvBRW1OSTi9kT
XIZgX8DGVyE9ceigt4Dx5B0DXYjtarpRf39EVphq/B28KIDec+Mn9yIbCMJHgyXX
cEK83wKUwfwL2ny2u7HBxIIZUj3p4zHOg17ONwQ8GIeAPc2NauYA/djM6Qk9U4Q5
nutnPqOUgbUQHVOt0gVR2tiZ2oBoyYNfy0r+o3rgL0INYMM5PIcx9EybUGaPh9Aj
QUHAQ98lWtQD/K/E0fxmufyuONrBLVNs6bBpPJvNZRqOHN/jZVVNPiqiqRHie5yF
dfHu8Kipaiuyyng86QodwAaOkwA3onBD7Og2vUDXx1dkH4mWtOmIemAPR+be2w2e
lg5d71x9XT2mRlhIGjdtjEkt9tanm9gO86YxxEtQQE+NSpNQOyyRImklG194UvvY
iR4fk/ou/TdfpwLOqv5E
=ZmJ9
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

--===============6147976821318354952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6147976821318354952==--
