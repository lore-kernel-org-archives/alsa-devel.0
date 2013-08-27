From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] ASoC: tlv320aic32x4: Convert table
 based control and DAPM setup
Date: Tue, 27 Aug 2013 15:54:30 +0100
Message-ID: <20130827145430.GY10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-3-git-send-email-lars@metafoo.de>
 <20130827143558.GO10783@sirena.org.uk>
 <521CBA91.4020102@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1961998531862750964=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 014952652B9
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:54:39 +0200 (CEST)
In-Reply-To: <521CBA91.4020102@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org


--===============1961998531862750964==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XZLT0nNRngx3qG4/"
Content-Disposition: inline


--XZLT0nNRngx3qG4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 04:41:21PM +0200, Lars-Peter Clausen wrote:
> On 08/27/2013 04:35 PM, Mark Brown wrote:

> > Please don't submit a bunch of unrelated patches as a series, submit
> > them separately.

> The last patch in the series depends on all the other patches in this series
> (maybe except for the mark dirty fix).

Yes, it was mainly the mark_dirty change which shouldn't have any
overlap.

--XZLT0nNRngx3qG4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHL2jAAoJELSic+t+oim9WKMP/2o5yKLAqUUCNWlnc81ugiqx
6VTsFlHCRw3XrzIydbcwhpvlWiXAtAJtmaEytY9XxiIz4P5/1CMDdSP+Wv135sTk
+3UwdrclckiDkwOIH1LhvfG1Qo9QYZ+jIaap9geaDgEhfWNAonY9+o4XBSqZsyq3
f69ltHWF/EhkYI4vQEryguXXwXGF9eyxvqNUTIT/p+CwI/GZG8BieZ7yfwTG/3Gc
j4FtaqP85PK39+tHK5OFYD9aOG9nURPwFZnpUhBZs46HxUE91rxxRkVzTYTgEnJ3
TUCYnoKG3F220QNBTk8NcyyCNK/ioXts5VrCs8VoYaR/lquDP0yxQXZOiJHzQe7Y
rLD/hwkFsyHX3+srHGpdQ2WBccEdY8fhjd0EOD433ypXl5MiDkUdHcBVitYJKTKY
7j5WR/sr0qtsVJnD0XHg24h9ELhonNxMsfHCSFCtbodBbryscIHIPjZ1/fhnFUkB
86hwHLe1+wPrkwuhlV5e9GJv7TA1Ze9FxMOWPpzKpEXpXro9kwLdy7hLEh44BC+e
agDBmrg5HPOa0wSEHkja294fs5qpYPO/vWJqMPJxPJp5RAc8JifCVP9AuRQvtvP8
KniAGvMI5/3SoG7njlXwLkrIFYfqAoHqCHmaJ1GexQ/elg69tQEI1jFCzZ7G0OS+
hT9M6mKn/KfwRFvfQOIw
=0WXD
-----END PGP SIGNATURE-----

--XZLT0nNRngx3qG4/--

--===============1961998531862750964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1961998531862750964==--
