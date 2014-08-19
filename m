From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Tue, 19 Aug 2014 11:03:18 -0500
Message-ID: <20140819160318.GI24407@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
 <20140814102152.GA8028@vinod.koul@linux.intel.com>
 <20140814130708.GX17528@sirena.org.uk>
 <20140818042805.GA14041@vinod.koul@linux.intel.com>
 <20140818135633.GU14537@sirena.org.uk>
 <20140819042706.GA20885@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7937846658536469330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DAE3261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:03:33 +0200 (CEST)
In-Reply-To: <20140819042706.GA20885@vinod.koul@linux.intel.com>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7937846658536469330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 09:57:11AM +0530, Subhransu S. Prusty wrote:
> On Mon, Aug 18, 2014 at 08:56:33AM -0500, Mark Brown wrote:

> > The problem is that it looks like you are reading the value from the
> > control, treating it as a boolean and discarding it.

> Well the mixer input is on/off, so it should be treated as boolean. How will
> it have any other value.

OK, so you're trying to read a boolean value.  Perhaps what you need
here is some comments then - the way you fiddle about with the bitmasks
afterwards doesn't make it sufficient obvious.

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83VCAAoJELSic+t+oim9unUP/in/me9UaIHcd6f3imoBYnNG
v0OckkFNG7/5qwyvadhI7h9+xq9GzmDcWMi1jnAFAiR1QbF2YqQYhveJVwA/QZ2W
VExHgXTDVwD6BG85K0n8iH3bg/4muhbfK04Ufy4l1PZfmi+znWgBS0hFU8dt8n8f
zC4+j7PVZGO8rMYKRgovnzzdXWo0nw3EdTI5YiHnfGl3m/c705UnWD4B6wBej+kG
5+Jy1tyIVH+2ah7UfTOsu5D9kJC7W9gKD/WUiUvNXf6WHNoTpig4nM2WRXetKayz
PI5MvbbT8GSEJ7K1thq4yDqdkdsRcMtwtBgmmEBP8ggIy+G2qLBY9rxvBcI9DTfD
MrmGCHHEdPW3Y8cOhBLeucwx0dz5twpgN8jCQbmWGzCOrif4GG8EY5SDmI4Ag2AH
LSRYheq8JahUDJwyYDGiRCzT3+N1ftdi7Ow60KJizRoB3qN0NXYIKlSasaXF8tUX
raLcDQJm+RPk5rf+nKX51ARNwzyU+TwhSW5FnI2GPsQWED40WgSUgT0WhmSfz9/K
WechMD2+D7kSJLTySNbfiWwIsb4WRAP/X6Mw62VZSfbC359VvfkeM/XlUrsOuXgz
P4dDLE8O/wXMDcLFuk66w0JRZlQPE+SGQ/qwgAQJsExUiV4M6fv9xa2Lbw9lsb2D
g9QXU7KARSjJFkhamY72
=6rJv
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--

--===============7937846658536469330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7937846658536469330==--
