From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8750: Make VREF a VMID instead of
	OUTPUT widget
Date: Fri, 12 Dec 2014 13:35:37 +0000
Message-ID: <20141212133537.GM11764@sirena.org.uk>
References: <1418034191-28010-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3993608272590572690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3808265721
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 14:36:00 +0100 (CET)
In-Reply-To: <1418034191-28010-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3993608272590572690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1rn9AXKBSVzW9+3"
Content-Disposition: inline


--x1rn9AXKBSVzW9+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 11:23:11AM +0100, Lars-Peter Clausen wrote:
> Commit 04489eeb02a4 ("ALSA: wm8750: add missing VREF output") added the
> previously missing VREF widget. And while adding the widget as OUTPUT widget
> silences the error of the missing widget it should have rather been a VMID
> widget.

Applied, thanks.

--x1rn9AXKBSVzW9+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiu8pAAoJECTWi3JdVIfQfnQH/0HVObjIcmCrN6xlJpr3huIH
zQIRNqUwWpeBxpK6mzYrUyo2LfGVxn6fRecA2OenuxBxvHNtSir2NMEiBaFK03h/
HvBDIqkMbxvKFA5GJByP2yj/HhAnHFCKq8ISxZFeiRptR+rhDceA8lHPq1evhUMz
ep93MVFCgGMcUsK1kZge+LOZN80c3l4SVLEBB67GPQERLOTy1TCOf4FFS7Zwl0a1
6WMfpBZ/dGm5B9PdB4jsfTJZ2eIwpXhmMHcGy2ycAtDlddj3os2lH/nrrGaQmjwe
O/YY6onqvFHNyt8rny+l5CGkPNKCc1ph36pzJyFJTiZpG7cR+yAT8dBoedBdvbI=
=wFzp
-----END PGP SIGNATURE-----

--x1rn9AXKBSVzW9+3--

--===============3993608272590572690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3993608272590572690==--
