From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic: add generic compound card
	with DT support
Date: Tue, 31 Dec 2013 11:59:27 +0000
Message-ID: <20131231115927.GK31886@sirena.org.uk>
References: <20131231113138.102044cf@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2323061004853512009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB8B261A0F
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 12:59:32 +0100 (CET)
In-Reply-To: <20131231113138.102044cf@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2323061004853512009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s6Wo+7iKhEdF4/RK"
Content-Disposition: inline


--s6Wo+7iKhEdF4/RK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 11:31:38AM +0100, Jean-Francois Moine wrote:

> This code was first developped on the generic simple card, but its
> recent DT extension cannot be easily extended again to support compound
> cards as the one in the Cubox.

It would have been useful to have provided that feedback at the time
rather than waiting until after it had been merged - it was in review
for long enough.  It would also be good to articulate the issues with
the binding rather than simply stating they exist, and to consider
adding a second binding to the existing generic card rather than adding
a totally new card.

Please also remember that all DT patches need to be reviewed by the DT
people, you've not CCed either them or the list.

> +  - front-end or back-end: present if the DAI link describes resp.
> +		a front-end CPU DAI or a back-end CODEC DAI

These are Linux-internal concepts which shouldn't appear in a DT binding
or at the very least need definition.  One thing to consider here is
that these things are all about the internals of a SoC and you'd
therefore expect that they would be defined separately from the card so
as to avoid having to replicate information in every card using a given
SoC.

--s6Wo+7iKhEdF4/RK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrGcAAoJELSic+t+oim9NtcQAIik0Lm39Fm2rP9B8nJABjMT
6o4893uefb8pmXUOEyExafaqFFUUs0hRRMQxzVD6CwAiQMnssE9wAl42phtERtoW
Rygvz9XHjWyEvUxkk7JUkplMdI5Vs1kMqvnc5XZEq7tEG6yCsQchbGwo8Xbk1qn5
LcqLCy/6EA7wmDv6BNHb0D3i8HXFOCkf37EYGjFVOjbZutn2MEAfV7th2rjra4lg
uWnWEwL+b8+ZFnYddPCRjFzG6j7XjSAnMSuMbOYRblJs4eKEcJvsUOWOVJHRBoi+
BiZP5rZf5QFpzd9/jsD2W4N75rB5QYwDHGuFcIWVDoIG+IfGP9pbU1/k6FG9aUkG
4kORL+tUk+ROS0aiZ+vKuesmF7/+pucMj2SRRkHXC8iMdUh3VHaKnQFdTJBEyYBD
9K3XpeAGd9yXvPiJEDMe+psf7H8fnYXG51FDsQbA8OOzeqo9S1jftVVsb3itLt79
D52FbL6hmtFKvf0aDPv2FkBHfjyVA+kf2X74S+hqQy6shZy3Atxw4iv1FXXtBO3n
8w9hUZQQdIHpJQSmLSja43fyOC4HXIogJVetXoRqcHVx/Um+n6CM/mk9dBxU+q02
aAYZ8RTuLkQaSLdfRlPlaKogG8LFdQ+a/nd/q63VCMdGQRck43bf9BQD4Gx38jbL
6xDKvq06JpDycUWNH3me
=Ewah
-----END PGP SIGNATURE-----

--s6Wo+7iKhEdF4/RK--

--===============2323061004853512009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2323061004853512009==--
