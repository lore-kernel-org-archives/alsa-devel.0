From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Tue, 5 Jul 2016 14:54:03 +0200
Message-ID: <20160705125403.GS6247@sirena.org.uk>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
 <20160628111520.GL17217@sirena.org.uk>
 <20160629040810.GN14022@subhransu-desktop>
 <20160629185023.GQ6247@sirena.org.uk>
 <20160630085907.GO14022@subhransu-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4718629905204431497=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6049B265312
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 14:54:28 +0200 (CEST)
In-Reply-To: <20160630085907.GO14022@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4718629905204431497==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wlyKXzxas35Msh2M"
Content-Disposition: inline


--wlyKXzxas35Msh2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 02:29:07PM +0530, Subhransu S. Prusty wrote:

> Each DMA channel can be mapped to a stream in HDA. Each stream is mapped
> uniquely with a stream tag. The stream is programmed in both host and
> codec. In host the DMA is programmed with this stream tag and based on this
> DMA picks data from host buffer and puts it onto the link. Similarly the
> codec converter is programmed with the same stream tag and codec receives
> packet from the link associated with the stream tag.

Are these arbatrary tags?  If so why not just pick tags that look like
normal TDM timeslots?

--wlyKXzxas35Msh2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe63qAAoJECTWi3JdVIfQxiAH/2myBERMunNsuj07Glyek4wk
dJIeiJBYgax1ILzwfz0v8FVx9vh1yCt9XBVAjQ4rXPVa/7FPD16TAhRNHqwm1R2d
XoNfDNTgjy1JcNBhyb3HC9py1o5Wu7jsm/OfE4bfjS2tvRhbhm3Wy0jxdEalGV/T
SiTte/X37L+OU8Zh7OcFd1pmeO8ZVeMOAD/3PTs+jSepKNykE+sR5i2hpQ7fRUyD
Kz3OgxOCL9NdxOp1So5v2idUCtoHfqkWAgmfyoJAXCFyCzNnQmz3tlsD74QafjLh
JSOg8Hu8Xh7EECpT4zC+rjbvhgAGBztKrzn11UvcoeMsaG72QMU/skxbFg4j4wQ=
=4POY
-----END PGP SIGNATURE-----

--wlyKXzxas35Msh2M--

--===============4718629905204431497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4718629905204431497==--
