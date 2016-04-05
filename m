From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] conf: topology: Generate Private
 data binary blobs
Date: Tue, 5 Apr 2016 14:24:16 -0700
Message-ID: <20160405212416.GL1924@sirena.org.uk>
References: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
 <1459833605-11223-3-git-send-email-vinod.koul@intel.com>
 <s5h8u0s9sep.wl-tiwai@suse.de> <1459867127.3136.39.camel@intel.com>
 <s5hh9fgm7vy.wl-tiwai@suse.de> <1459871538.3136.42.camel@intel.com>
 <s5h60vwm46f.wl-tiwai@suse.de> <1459872533.3136.49.camel@intel.com>
 <s5hinzvyfxz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4114230307975965495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 297C6265041
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 23:24:30 +0200 (CEST)
In-Reply-To: <s5hinzvyfxz.wl-tiwai@suse.de>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nc,
 Shreyas" <shreyas.nc@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4114230307975965495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Content-Disposition: inline


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 10:10:48PM +0200, Takashi Iwai wrote:

> OK.  But now I noticed another pitfall.
> The topology firmware is endian-sensitive, and the code to generate is
> so, too.  Thus it can't work for big-endian architectures.

The firmware side of this needs to be fixed at the ABI level I think,
that's definitely an oversight - thanks for spotting it!  We have
platforms which can switch at boot time between big and little endian so
an unfixed endinanness is not going to be usable there.

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBCz/AAoJECTWi3JdVIfQh28H/3V96ty0mIK/jTuXDFTGpMZr
0JWKct/9Vn1zQeWDWvcPHRmty4BhdTuarGiPrRlYdoA0MlWty871uKWWX36N7cE6
qPI6ZFehgcf4WoXLxCRQqAFCa4Y1ExF1urj/W+W7/dPxNsqZPmb1TnSa21SnyjuC
Iv1gLoiurwtsyqwlUUVyOF31IoIx/siP8CZcfKfcAzNWXXIR4ewBa3YKbegf+G0A
0xaqbxSWAlqG7qmhK5cKDz9aiE/l2GzjpjqHqWWyeuVYagUyu/tbFNyzm43pjH6G
AWH1COaO13Pcn4+NPr99dtdIXePHbHQJPjOrvXN1xay5kJzX+E9UYMt1+bzg2BA=
=8DvY
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--

--===============4114230307975965495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4114230307975965495==--
