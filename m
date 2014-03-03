From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: pxa: Pass correct DAPM context
 to {corgi, poodle, spitz}_ext_control
Date: Mon, 3 Mar 2014 10:04:43 +0800
Message-ID: <20140303020443.GU2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4970627177370028706=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF042654D5
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:35:43 +0100 (CET)
In-Reply-To: <1393685300-5307-1-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4970627177370028706==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Content-Disposition: inline


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:13PM +0100, Lars-Peter Clausen wrote:
> When calling {corgi,poodle,spitz}_ext_control() from the startup callback we
> pass the CODEC's DAPM context instead of the card's DAPM context. This is not a
> problem per se since all the DAPM functions in ext_control() fallback to widgets
> from other DAPM contexts, but passing the card's context is more consistent.

Applied, thanks.

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+M4AAoJELSic+t+oim9B6IP/ipAX+m+h+Wwt3nvmGkhluVV
a8meOtdIy8NVrVnSkYPkJwitjnBDp9TTmddX5P+eY0D07ea37i0VYOkCtzdegfeb
MAvpG8IaO3uiaOx+uGbArV6GY5xlARUwGWFLr4gS/YXyznfYEQfq+pVa/nsV3So4
wLcE51pUWvQAYBno3WGgwwH8whIjWi4WI+gSm7zWDffz21wGmQQjUWFc7noiImNn
SF64hTiWcXqXrs4ky02lYAs6YZohUYt/3BOu+adMFyben2s60qdQyNRbfydLGDUq
3cIFZioMi/ErGEY3+YMTg+hTU9W6yogiEywHOmJB3R0BHb1VZPIufvfEeZwtZuYM
ja5kJXBc6JEQeHMZwArErAs5mW3Y7wOHzne45cRtE7h0C2V/HI5nV5dn1xs0NRzY
xXslNCyMx5KBM/SRCvIiGFyW+NdPHTFe4luZUzlkHFixL9C3lM2AcAYuiJJ+Q1mN
OHYSZJfeUKH053Yj0IaaecyUQAVg5Ykokvt67U6S3DUf3/miyY6dkm558zz6zpLd
0uoyLuTjPNhbxY/OtCQb60NaHLd/UDY59tnw7OSUqi648CeLE3ncUnzf6SpUrcKX
416pn2PWkdSc3iwgZaDdTNhsotXyI20ivFY/1yPdVnzgHhOAE40at4MLTCMeS5If
jJvyiPAnmKPmgHOJUYsd
=BtEh
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--

--===============4970627177370028706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4970627177370028706==--
