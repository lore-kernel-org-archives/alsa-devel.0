From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Thu, 3 Oct 2013 14:37:29 +0100
Message-ID: <20131003133729.GR27287@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3521310121387549198=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 272832608D4
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 15:37:34 +0200 (CEST)
In-Reply-To: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3521310121387549198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Content-Disposition: inline


--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2013 at 03:33:56PM +0300, Jarkko Nikula wrote:

> For instance, matchine drivers could specify codec in DAI link by using:
> 	.codec_name = "INT33CA:00",
> instead of
> 	.codec_name = "rt5640.0-001c",

> Note that ACPI name is used just an alias during bind time and core
> continues to use device name. In fact, machine drivers could use either
> names.

This is making me wonder if we shouldn't be taking the stable names we
get from ACPI as the dev_name() instead of our internal ones on ACPI
systems (and possibly something similar on DT) rather than adding custom
code like this.

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTXMVAAoJELSic+t+oim9UbkP/1U2daEa0zoJGoB8j1X2Qlob
Kp1y2kttCYIrQafQrxPj0fVYkrKd8oiDA/AbVA+2l+orUk6SyWuV0leYXaXBVwYe
qKCUnjQc6VfetwfkLH2Q2mJI7sgAAbqxScM1Brz+oWObgBR9y70HkbXqI3bcP1Qo
v2R33h7WfY+T/5AZkDjvtSySp3uKw4FBhEzSHgftYKKh2ULYWp66TXn8YmFPwk29
OhQ/+Y+N8essH2307gI0OU7eCBhXpWlfuqRwfOmNitNVblNilSlRZn7yj2JJqkab
SHQir6tVUf5IlQrwcOEHVcQf9LY8AmCL4C4gw75G3y1x6G3mHcWnTbfoI7Z1Jq3G
TWLCTRMYEWrPx3/5/cyXqznD/LrTDHtERAcByIrau3Zyv0LvbR6I6aqW2/Mx1esR
o7Zz0N3VkAqUsCXPtT/UGVfz3GHxua3VozWeWzxDBFsVfTo2jz4N/MALELPTO0fK
fuTplwIRN+fPpXpO8+Zz1oAoLxiXrjvDp6BYO34Zaxsh7aZk5rPXGW8znDXK7u7c
klfdIEwzNvMd4dcZDIGmb6Vyqc3t2yJvRLTEC8OLwnr8p8dpYxQMEgfV3/qU5VAB
yRsZZGjUhOHfoxhMjbwI+E1onsNQaPxibMivHTUnlXe+tQ/w21FmbR6nFlV3A98x
fF7mv2VHTyUMieG7r7Zs
=Fjbx
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--

--===============3521310121387549198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3521310121387549198==--
