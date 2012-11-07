From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Split out the firmware file
 parsing from the boot.
Date: Wed, 7 Nov 2012 15:32:55 +0100
Message-ID: <20121107143253.GE20844@opensource.wolfsonmicro.com>
References: <1352292269-15021-1-git-send-email-sl@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4246213041512006627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11EFF26509C
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 15:32:59 +0100 (CET)
In-Reply-To: <1352292269-15021-1-git-send-email-sl@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Ling <sl@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4246213041512006627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 12:44:29PM +0000, Scott Ling wrote:
> Move the firmware load and record parsing functionality out into
> a separate function from the boot function.

This still doesn't apply.  What are you generating these against?  Code
for upstream should be generated against the current upstream...

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmnEOAAoJELSic+t+oim9hOsP/R67eB98Dnh85fxm+F8d6q5U
yDRweflA6ktZzj4lton6xbd8Zdnt68wH/sPcGNTxOA7P47bT4oQhVOfH8oSQalcm
yyJtq/+8cAQVZfG8+JII/6T19OOljQJ4VA7w7Cyy4ubJIa2ofHjS9Ru+XjgRiFX2
5wiMLiTt/0BKQ94DeONZiEek2do96AzwXgV4plucvrUk3we8vmXOIF0N2Un2Nixn
IBDn9kU4hnWZ0KEgA9bkz76MJObKumEH9XBK/dfaZEIWEbmbg1gvt5gBgVyrRMwL
IgjU5gyawfSI3vmirhifvIjH+8wCL/YqoJd4zKVrIO4aTr0ekwouRZfxwMhydKiV
bRRs8nr/txrPRE9sgUYJYakWU3s+6pAul+utd2MJWSgXtAaSF07RA/mfBY8fNcDS
pEr3p/o5fCvBQFn++Dhi2A2HLW076Tef0No/qzo1/Np/22U+4yDglIAwmrXGDci9
NVAdGnR7RGjDDMi3vYbjZX/DFfTArpqMpslZROlVO/Xys+Kcgkr0w2GrYGQB2jaU
VJj4d0LOpalkb2QuZF0qMw/KfpIwRlWnF5zgPKySqk1HuBn+CuJ6YRv89KhRK835
driInUGV+Ecr79U5dEnNHrm4IMRAm3OODmLbUJFdHpoDsDn7zYvnYMkPQH38yhnx
P82q7m2E2ahi2hfEWGtj
=8NiX
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

--===============4246213041512006627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4246213041512006627==--
