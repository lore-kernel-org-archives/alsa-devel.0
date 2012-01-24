From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.4
Date: Tue, 24 Jan 2012 20:46:16 +0000
Message-ID: <20120124204615.GE1135@opensource.wolfsonmicro.com>
References: <20120124201157.GB1135@opensource.wolfsonmicro.com>
	<s5h39b4n8lw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0771332478770605136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14E04103B1E
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 21:46:18 +0100 (CET)
In-Reply-To: <s5h39b4n8lw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0771332478770605136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2012 at 09:33:47PM +0100, Takashi Iwai wrote:

> Yeah, my git is still 1.7.8.x and it doesn't seem to work well with

Oh, well.  I think it's the tag rather than the signed bit.

> the singed tag, so I pulled for-3.x branches now.

Trust me, you don't want to hear my singing :)

> I'm going to upgrade in this week sometime later.

I wouldn't worry, it's still not a full release I believe and it's not
exactly crtitical.  The only reason I'm trying it right now is because
I was setting up my new GPG smartcard Debian has packages already (but
do let me know when you have upgraded and I'll try again).

Actually, looking again I can generate a tag with the same name as the
branch quite happily - if I do that when requesting pulls then
everything should transparently do the right thing, older versions of
git will pick up the branch rather than the tag and newer ones will
prefer the tag and so get the signature goodness.  He said hopefully :)

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHxiQAAoJEBus8iNuMP3dkuQP/09ytBLrh52nFjzoSttHRWEA
4McPw2/QXu1XB54XqB0o8+iK7JiOaoJ1uqkFXVdRsPdYD8pP51hmIRBcRqlWteQJ
vR48Qd+0l0AwCPkuJb8XhUnF1ErlMyYyPBHRDE1egOmpiEhv+5wpVtKXnRvFNVFJ
iXWelcMGBKQcq/Edh2GnJj9ZvNxELIw7SZnqFd07+BtLf2KF4zxl+nR1v4Z6eR7d
FTxbXPQ58vPPAG54+1j11VV9AygNw8ER/WpCY7CO7/2fwBG2wxN9eIpPCrSjq4Kh
2GPTxQRk9+hOuo6nOp0sEf7UT4DbHJkAyriQvFfd3yBAxs/rwLRPM2PVkz+yMh1k
fUH7JzDoVAxcWFVOq3UJKHPOM+eTDJF1H/zRqJ0dXsv223hupSYLl+XXSHebIcsB
luyZewtZ28lEd4FEDyojOjnDmfuLR7F5clNyHfMtor5XMuA5tfSwvzjiZM3S+UJj
cCdnq3Qij/KKJBzQ1/Xs4wfXEQdiIiWiakB7ez/oqturDQh6Mpog/Dy08/bActLL
pW3i5Qyy2qE+ziaRO836mp3Lhe0V59aVwMx3/zcApZj7OQFB+febd2E1BHLhxDjL
RWkKYz7gRIyyHNdjL3NdnsBVlev55u7AO6MVoF0Q6bD+mAYp4urXN8tuFUJkyaQO
AXtIzEETKnDhVGYiJVEv
=oG33
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--

--===============0771332478770605136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0771332478770605136==--
