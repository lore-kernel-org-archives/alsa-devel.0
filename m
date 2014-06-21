From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/11] ASoC: Move name and id from
 CODEC/platform to component
Date: Sat, 21 Jun 2014 21:04:34 +0100
Message-ID: <20140621200434.GP5099@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0500269490902553668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D765F261B0A
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:05:01 +0200 (CEST)
In-Reply-To: <1402935191-18398-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0500269490902553668==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xu6B5v5yNovF5RLT"
Content-Disposition: inline


--xu6B5v5yNovF5RLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:02PM +0200, Lars-Peter Clausen wrote:
> The component struct already has a name and id field which are initialized to
> the same values as the same fields in the CODEC and platform structs. So remove
> them from the CODEC and platform structs and used the ones from the component
> struct instead.

Applied, thanks.

--xu6B5v5yNovF5RLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeVPAAoJELSic+t+oim9fR0P/RQNN8Zk5xzr4PjyqE1Sx/ut
A/Lw+HBVulMUYzTZp94OtNWxfLeMqlyo0ztrhGq7THfLZ8cicMIc5Y2pxC6AfhdA
kTw7oQ09un8f15u35JQB6UlAnEjvmZ8yUXXk7ERHCSJPMcpNBUVyrmpS+/w/aliD
d18TQaD14kZtJYqaqWQnj+hVM/RH+C/OevLpNKeiTialygtKen7NtzWvdr7BzyrU
MHdUtW+1u3szQ+1sQhURAlsveYWauHh0PDNIJSBXVJerhqfufLTX/u8JxDiiKrK1
wG/j3WcKxoUlMKbDFs9M6yRHx3Q9AWzl1hxrh/pEq1YWmLa8FcfGIWtP2JEJwuSj
DwyNHSa+SOD5dHrKn1uu5JrAQj5/QmUBPPv4mPidCgQv5aSnrUoAkn5RFelPIDIc
npOryM+9NPcSqz6BMs+AmY8lGgq+tM1Diil4ACJQAPUj1EoMscagrOrxbp4FttNr
rwafU9aVAzqap/ySWvBEhLycdoWMIulTyRxDYbG7A7VVPzEwWk2oHmSY1/YXuP8m
7lep++DCDpNYXw0xMUGm8AtEUTiurhbZShMysBi3vNOkBSSPlr3i0sbfT35XwGoP
NgaI5zdA7LzUFdQSYaibG0mcShprMo9AhOsmKWGKO8dSZtJ6rq4a6sxLYiQYoV7m
ZUCZKnUL9dZyW0MeZ2Kz
=UUla
-----END PGP SIGNATURE-----

--xu6B5v5yNovF5RLT--

--===============0500269490902553668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0500269490902553668==--
