From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ac97: Support multi-platform AC'97
Date: Wed, 26 Jun 2013 15:57:55 +0100
Message-ID: <20130626145755.GQ27646@sirena.org.uk>
References: <1372247296-17108-1-git-send-email-broonie@kernel.org>
 <3333302.d3tySHZuq0@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2496378210394697866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B71F2654F7
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 16:57:59 +0200 (CEST)
In-Reply-To: <3333302.d3tySHZuq0@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2496378210394697866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtzgsd50XOpelISN"
Content-Disposition: inline


--Jtzgsd50XOpelISN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 02:40:16PM +0200, Arnd Bergmann wrote:

> The idea is to turn the ac97 ops into a pointer that is passed around
> the structures that actually use it. See below for how far I got with
> this.

We already have a perfectly good way of doing this called a bus - if we
get this working properly we may as well just get the bus thing working
properly.

--Jtzgsd50XOpelISN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRywFwAAoJELSic+t+oim95UQP/iYxXBHAR+2uVv2FwfQjQQiL
Nk+aBTRGbq7IlL5LOC/yGUEiyymQ3ictzYfMnatv4QBru88fbWYtv6P3ItKq5QQ6
aZ6oa7aOajY4XHDyVrtnn2pOk4M3D5ootw7IsOx1Ey1iQvB+kc3TGbFc/nZWR9EN
w+LEGo7UdGp6W1AbLfDurNvaTUnagq51f5DFBq+2lQH/qeZfe4tzJqz+UfC7RlcH
PqeqVSannTL99UUdFhHxuIG9MonBLmZktD3xCQ4UMV6xHUkh4ar2FS4e/30fdDI4
pxDqDJ0M+47a36GmRpfNvBN1XCahwmS5v/ZK7ZK5RMIoRvPPV/REDxhIJ737iuYN
BYKNWWNAXxZGAtZAZdoUdJzui+oxXz/mMXgAEh5MhUIMEjdpgCv6LG0aZO2lrTKw
X6gj5H1yc+MepFOhuUgBH6AGbZLZMOSGA+nK67oXQc4NECi7MhmbvhAB+OBF6Hjr
ogf371giSpZhlATl0CzzA3ZBSQq7FemNDV0sOvkiGULluid3ZaF4SZC4ql2pdyTg
Wo6wTQ5sHg5wGOaq+IcBGZ3NDX/E0bF0y4TKvVPNW5CgbLMDbF2iizCp5cVn/tPA
kNyGAuakUDIIVhlg2AAuIJ85W8KZ+sAhLC8k2mzIQ3e6N2tzIJQlZhgCn3KiFJ+L
4KLITn6NR9BjSCNm0up0
=eOOU
-----END PGP SIGNATURE-----

--Jtzgsd50XOpelISN--

--===============2496378210394697866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2496378210394697866==--
