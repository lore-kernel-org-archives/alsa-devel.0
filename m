From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3 v2] Add I2S/ADV7511 audio support for ARC AXS10x boards
Date: Tue, 29 Mar 2016 10:00:22 -0700
Message-ID: <20160329170022.GT2350@sirena.org.uk>
References: <cover.1459174494.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586998572=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1459174494.git.joabreu@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============1586998572==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Content-Disposition: inline


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 28, 2016 at 03:36:08PM +0100, Jose Abreu wrote:
> ARC AXS10x platforms consist of a mainboard with several peripherals.
> One of those peripherals is an HDMI output port controlled by the ADV7511
> transmitter.

I'm going to tell you the same thing I tell everyone else working on
HDMI audio integration: you all need to talk to each other and review
each other's code and unless there is a very good reason for it there
should be at least some code sharing.  For example take a look at the
patches Jyri Sarha has been posting recently.  I don't have detailed
knowledge of HDMI and the range of hardware that's out there for it but
I am seeing a number of different people posting patch serieses that
look a lot like each other and like they should be sharing things.

Please also try to keep your CC lists reasonable, the set of people
you've copied on this stuff is enormous and I'm having trouble seeing
why a lot of tehm are included.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rSlAAoJECTWi3JdVIfQXQsH/0pi5Ojb/UhAHYic6/rLq4Kb
lA2i9o2ORv56bvd+Ye4oWAK4N9ToOgHFvX5DtJ0cbAsayWfcaE5Nr4ew1rV3faOp
qfZ5YVnlffmPeZsIRTFOtua1vvWgjjKCofy/0mLj7a4AhJEx7BdtC/yeh64RGz9Z
zFhb7CM0wzxR9lf4/xcQMuhdFeP7z/TFZpsBTl3f2xGFQG9e9W7NSLbx1gxz5ewg
3j84W1ewWM4De8N8b66Om6GW1/RozcCRT/j2wSPJGb+AScxtQDFg5WI5QPw5QwJT
zVO6F5FNxlHFYw94baCHK4e7nue1ZDSljo5gMejTuiDH2tyur0LRbbGkbYdUsBw=
=PYeA
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--

--===============1586998572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1586998572==--
