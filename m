From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/8] ASoC: atmel: machine driver for
 at91sam9x5-wm8731 boards
Date: Thu, 1 Aug 2013 10:53:38 +0100
Message-ID: <20130801095338.GK9858@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <51F7FBA8.6080400@wwwdotorg.org>
 <20130730204511.GX9858@sirena.org.uk> <51F8302D.406@wwwdotorg.org>
 <20130730225845.GB9858@sirena.org.uk>
 <51F98CBC.6000302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5503675945799607053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D28EF2616CB
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 11:53:44 +0200 (CEST)
In-Reply-To: <51F98CBC.6000302@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Richard Genoud <richard.genoud@gmail.com>, patches@opensource.wolfsonmicro.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5503675945799607053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fZWh67R7a8iXbUAa"
Content-Disposition: inline


--fZWh67R7a8iXbUAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 04:16:28PM -0600, Stephen Warren wrote:
> On 07/30/2013 04:58 PM, Mark Brown wrote:

> > You seem to be assuming that the strings are a bad thing.  I'm not
> > sure that this is the case modulo the tooling issues...

> I do tend to think that using strings is pretty evil...

Well, they do avoid the legibility issues that tend to plague device
tree - I don't really mind if they're in the property names (as with
regulator supply properties) or in the data but having something that is
directly legible is a substantial win.  Constants deal with this in the
source but they make runtime debugging more painful which isn't ideal.

--fZWh67R7a8iXbUAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+jAeAAoJELSic+t+oim94zkQAJ5lTteMeiZBwkZyS6hAsF7t
o+V3EHASmYxcw8dj+OgXRx2RlmSzN/eSPYk0S3TW1hxBvi93tJGrw417rjmrYN7M
sciDjwGaR7w79+/a1dZYkHMzVAdNf3krK8cCq2lh1rRhQD1H/+6BWsT+9ObrMbM3
Fy98Ed6h1IN7aKC+BKGl3PHQlCWDumz8dIEEjKIodARQvZWdLwzjzkgDrAUZoMeR
C82CfkPm+Se1PLuPLArqX/2vYZGHFHORHrJKWew8VYQ/cxQ7x/BIG4zHU9ejcWS/
0C+g6pmC85fCnzeOLNqKTxPPQe61XGukezYkVm+/m7vkr/YzrdsxcYOXadBHZjoG
FF0ryXyYh/CXUDDHo3sjOGTIYxliRgCxlAgWQIJura+gGIV5nwuqDQem1OAM/622
CaQ6Kfc/P4LZ/Qo5AlYB35DpeSfuUI9ILfapgxWtVqLOYcjyu3AR2waiV/e0Vc+4
pxmn/qKasaxvDLycZ8l/SsgoEbsO1iiyci42YGZuiWkcNlbu4FC1u6PchD9xEVoH
2mS4zR/qbqC2puhvLuuvu6mTFcezWtSjUf+3DNTqlt/WZtLAVg875xL2fFBY5Wym
L9qgyyrOhkB/wUa1Ie6TH1dXB/US6hiLmB5R1nrdSPUaqLnPnsV0ezDVRo3P0BJh
LmsQsRCwDgXriZXbgip2
=pB8f
-----END PGP SIGNATURE-----

--fZWh67R7a8iXbUAa--

--===============5503675945799607053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5503675945799607053==--
