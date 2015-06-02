From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 15:30:42 +0100
Message-ID: <20150602143042.GS14071@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <s5h4mmv9r7m.wl-tiwai@suse.de>
 <20150602104516.GH14071@sirena.org.uk>
 <s5htwuqe60j.wl-tiwai@suse.de>
 <20150602110732.GO14071@sirena.org.uk>
 <20150602123943.GP3140@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0369559072749845990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3C84265080
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 16:30:53 +0200 (CEST)
In-Reply-To: <20150602123943.GP3140@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0369559072749845990==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aQ0PHH3iiKbaMI5N"
Content-Disposition: inline


--aQ0PHH3iiKbaMI5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 06:09:43PM +0530, Vinod Koul wrote:

> This is fairly *common* in drivers to use wrappers for hw accesses and yes
> for overall HDA we can perhaps optimize these as Takashi pointed out but
> hardly a worrying aspect/sign

It's not the fact that there are wrappers that is worrying, it's the
contents of the wrappers combined with the interfaces.  The interfaces
make the wrappers complete noops yet the driver has to manually go
through and rewrap everything.

--aQ0PHH3iiKbaMI5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbb4SAAoJECTWi3JdVIfQAKwH/26vC53keSYaKU7HhuREcnBY
mrG5phy3/1gdYXfar0daVxxu3GLHCGeOIuPDecCaNzXdQ5BxC5no4v31B8Ot9gfJ
SuFeYSRk43F+50tZ59CzZquwyDCINFQFUukFyh5K8iSOMhmjkIL84zipiKVRqxTs
8JVv15/53ryl9JIe4m6XB+a5IF9hf7TxgcuQWtG254snrBaGR5iaWFVvZbl1o7Ox
tAmjgm5ZHXqGOLfSoXVox7NYucGJjpM0nJYuwZ7fKH47apltBa6SO6m14Gsu/9BU
XDdEUSI7rw1EQsaXTQn4GJ81ag33oHYqLs8hNnHOtdUprsMvXjMKjdCPfnJmuEo=
=Q2ay
-----END PGP SIGNATURE-----

--aQ0PHH3iiKbaMI5N--

--===============0369559072749845990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0369559072749845990==--
