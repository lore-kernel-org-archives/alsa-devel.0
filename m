From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: Remove unused num_dai field from
	CODEC
Date: Wed, 7 May 2014 10:22:02 +0100
Message-ID: <20140507092202.GG22111@sirena.org.uk>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
 <1399361981-18518-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5968423072967948999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0483E26109C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:22:20 +0200 (CEST)
In-Reply-To: <1399361981-18518-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============5968423072967948999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ApAmD002LHtYGJ+H"
Content-Disposition: inline


--ApAmD002LHtYGJ+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 09:39:39AM +0200, Lars-Peter Clausen wrote:
> Commit d191bd8de8 ("ASoC: snd_soc_codec includes snd_soc_component") removed the
> last user of the num_dai field. Also remove the field itself.

Applied, thanks.

--ApAmD002LHtYGJ+H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTafs3AAoJELSic+t+oim9HYcP/1W5xoMFt3MUQImFKQtMcFar
4yJ3t1Kf1Z+riukcD2eh+wgI3YNlqHLGzQg4wowILKEWLD/DoK6oWINeGWOkUCMu
70Rg8kqzcsQ3wLwM8vVOEWYA79WhWRQIr+/2FjbxLQRKT56YDoVzXX63rVq58Xas
w2ybBa/52awidMKJW2mPd6kU/ug0AKQyKb2uDzIeoFZ2thZTcOelR8dKxokWLpVJ
XSN+A2RuB1Iir5Il2wSkOErpvgB33eYox4i/DjmPKCMZUOER8ajUlXICLLiaFEA/
f4jElfZi1nW9kU89jjcDyG/G6PgxKlADZs2bPxCgepDB+ff7H/vfmou+5luXc8Ct
ZRFkMM3KuDP2+rdFY8VZY5teAEzTo7dc5yth9AStTVzG7e50v7yJ+oHlpe/vtW3p
/2KvbvG+EwXz/x1cBjb1sq1IbI+n4xaS8573HkczdtWBr7TECRnYM4+YPiyPUR3U
bwLiCvdryrkh5gbA8hECAfR4lY5VEiq6t6U7I4mYF4nQ7UNE83CSRnS4Rh8MsSwt
jgQEEqkUfEK+km5T5kVkdHiULUPeV0tGjuyhEaDtvDW39QHYacP9Uoit7I7inpUn
CeCr+pwC2hLA2cXKRW5pzRml8oQTjq9FIJc14EnPQ0OEv7bV3OK12iTBS1WmlHmE
S2lUc8pRqXt6K5Ew53YA
=Stab
-----END PGP SIGNATURE-----

--ApAmD002LHtYGJ+H--

--===============5968423072967948999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5968423072967948999==--
