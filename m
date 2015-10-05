From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix the runtime error in the
	booting
Date: Mon, 5 Oct 2015 10:58:27 +0100
Message-ID: <20151005095827.GL12635@sirena.org.uk>
References: <1443763829-9359-1-git-send-email-oder_chiou@realtek.com>
 <20151002101141.GO12635@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F9A57E@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7257523031888185412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E6426044B
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 11:58:47 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F9A57E@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, "flubba86@gmail.com" <flubba86@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7257523031888185412==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwX5Nmi7feudBrEr"
Content-Disposition: inline


--wwX5Nmi7feudBrEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 04:09:58AM +0000, Oder Chiou wrote:

> > This isn't obvious and seems likely to break - why is this ever being
> > modified and how is that safe?

> The table was used for the cache function of the index table, so it would be
> changed the value in the index register writing. The breaking is in that the
> variable of type "const" is changing. And the wrong modification was
> committed by "c418a84a8c8f98b1a0f30cd68d0cdf40d77aed01". The modifications of
> the commit are correct in the conventional case, but it will be breaking in
> case of rt286 and rt298.

I'm sorry but this isn't clarifying anything at all for me.  You are
simply stating that this is safe but not explaning why - you need to
explain why.  If nothing else if a driver is modifying global static
data that's bad practice, the driver should be copying the data into
somewhere driver private and then modifying that.

Please also remember to include human readable descriptions of commits
so that any humans reading your mail can do so directly.

--wwX5Nmi7feudBrEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEknDAAoJECTWi3JdVIfQvD0H/3TPwhdBjSyqoOldMpr1eUof
v8GnDURkO8SiGEWO2Re1oL3+XTqAGnpo57hcxnDqt8E57jla5aIF6li7jExhzayd
i3MriLGbr0q65+xjo5eZP5w20mLTjqA1fxm62hJ2AscbdTq4zWWcDhTTufrpCn/0
UrDHxjjhUKAqFovo8DPc6OcXulOfkK8bUhzceQ2B+CNSTVWe7z2VeI5ilaCyKf/B
HBoyvmmBhOpQ+NuqKMTaTBuEws6XqPedwrQFX5aNwQGhWfH/Dke7eH1yomd4hW9I
anLjQh3navat5gUTOBqhZLv0c37xXzPfqHDSIBqMKJ9ibyDluSujUrGijreJAZM=
=e9E3
-----END PGP SIGNATURE-----

--wwX5Nmi7feudBrEr--

--===============7257523031888185412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7257523031888185412==--
