From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 03/14] ASoC: hdac_hdmi: Use list to add
 pins and converters
Date: Fri, 8 Jan 2016 19:24:46 +0530
Message-ID: <20160108135446.GM11778@localhost>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160108133251.GP6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0593882214041969733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6436626040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:51:22 +0100 (CET)
In-Reply-To: <20160108133251.GP6588@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0593882214041969733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 01:32:51PM +0000, Mark Brown wrote:
> On Wed, Dec 09, 2015 at 09:46:10PM +0530, Subhransu S. Prusty wrote:
>=20
> > Future platforms may have a different set of pins/converters.
> > So use lists to add pins and converters based on enumeration.
>=20
> > Also it may be required to connect any converter to any pin
> > dynamically as per different use cases (for example DP is
> > connected to pin 6 on skylake board). So this will help in
> > dynamically select and route.
>=20
> This sounds like it's supposed to be supporting multiple outputs but...
>=20
> > +	/*
> > +	 * Currently on board only 1 pin and 1 converter is enabled for
> > +	 * simplification, more will be added eventually
> > +	 * So using fixed map for dai_id:pin:cvt
> > +	 */
> > +	cvt =3D list_first_entry(&hdmi->cvt_list, struct hdac_hdmi_cvt, head);
> > +	pin =3D list_first_entry(&hdmi->pin_list, struct hdac_hdmi_pin, head);
>=20
> ...it looks like we still only support one random pin and one random
> convertor?  How do we know if we got the right ones?  I *think* this
> mostly ends up doing the same thing as the previous version but if
> that's the case why are we doing it?

Hi Mark,

This is the start of conversion to have multiple outputs supported. This
patch only converts to use list so that multiple pins can be used

Actual code to add support for three skl pins is in this series as explained
in the cover letter

>=20
> As I've said before one of the reasons it sometimes takes a long time to
> review these things is that there's a lot of big patch serieses getting
> sent which aren't that well explained.
>=20
> > -	snd_hdac_codec_write(&edev->hdac, pin_nid, 0,
> > +	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
>=20
> Huge portions of this patch are a simple refactoring like this, it'd be
> good to have split those out as a separate patch so the actual content
> is more visible.

Yes this patch is only refactoring to use list for pins

Thanks
--=20
~Vinod

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWj7+mAAoJEHwUBw8lI4NH7BAP/j16JM8uysw76qoy/51UlKGP
rtdCe91GWUjUgY5RpH9JeuS5WKz285fJQWLUm8e/2YhwRNzc8oZhNc4HboBmPU16
AgmR+HkXqvdpeacqeiPbejKThqQFRqMo0XcC4ji05JddNmiMZ+uu1E3+34D+Dm05
NYMfKcVwovWRrDGE6o1JkP4zBfgMMhork2rTfUz077gJzptuxDIO2HK+n5UwqAbE
uKXi2oesRzNo4X79udt0mgQpyJ6NfQWoGMMrH1KC521954+10CwxbM2TfTCtquu1
+sbMIlX8SBlCbc2uDSxYeIijhvrHPP+YNpUzJjE8VmyHKvTEgYAjk2+zjlTGHTud
XZXbXpDhCc0VbjWxA6QNhgn/+HVbxMZX2HGQM5S44mQDAjnKMfaKyQKEBjaaTmQn
SuC0NhwMS+WFhyZmJ1su6ArPcJJukC0iYknbFtSK8uOXC9MuB6BlL878rZSUUUSY
GpNPlKEJzWvCQgwh1QybB4LT81sY2mFnvELekOz+XU0cyB12wKKOHrYntcY15Zv/
5x9AQyQell6Wi2E2olQ1sMS67Ii8yWiGvtFScw+rYMrwYpQRwcNaOgWfuFPIqwUC
KihfvbbQMaWOWfGDT7jdZVMdt6aM9uh9tG95YYTHG39ka7cF3KHUMktlB89JqZyW
qDm4sa1KOVjeSI2HiO34
=0wbN
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

--===============0593882214041969733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0593882214041969733==--
