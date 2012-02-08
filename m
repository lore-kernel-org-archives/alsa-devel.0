From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 8 Feb 2012 13:57:20 +0000
Message-ID: <20120208135719.GD5943@opensource.wolfsonmicro.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6415470592112814181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4200D103E6D
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 14:57:21 +0100 (CET)
In-Reply-To: <4F327A21.8030805@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6415470592112814181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 02:35:29PM +0100, David Henningsson wrote:
> On 02/08/2012 12:46 PM, Mark Brown wrote:

> >Except for Mic where I don't mind either way I'd rather bring the HDA
> >names into (but note that the idea is to remove the HDA specific jack
> >controls - I think these names are used in other places though?).

> I'll let Takashi have the final say about the names. But note that
> for HDA these names will not be enough, e g, we might have one
> "Front Mic" and one "Rear Mic" and need to know which one is which.

Remember that once these are merged properly we'll be adding the jack
name on the front so the bare names will only exist for one or two
commits - doing so sensibly would mean changing the kctl API and doing
a refactor on that when the immediate goal is to make it private seems
like more trouble than it's worth.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMn84AAoJEBus8iNuMP3de4AQAJPp2l4PCvHKEW1xZsJl+cpf
ynQ/IhgIBk4H/g1RIrvOoqBe21UteNzs3iqUwsqeNogEsSJGlGFRjfvHgcU+wub2
3ag2hz3djiozTgZaBh5CoEoc9K0Bi2YfnMUKZ7vtXIE06UYchhdC2ZWqi8Y5/PcM
6fY9ZlE0QvPnAS9bb1SegLCI0ukhd8rdaWjVjUtqaa7F3oLe9nPVcOGR2IODHlf6
Skx2T4HAK0jaUAl6d7r8WOX0SEvNIEKzVdyXSXdWYDV1Zi2cJlBz4akO9emzF4Dp
AmOEWhday/0LuKBFinoaMlIGmwRemYPUw6CxlhcYtNc1VJbq8XWT1XT2qwwoRrAp
FjQ1th1CUgWVp/jNDE/bzs8Ki3aw7QTc2liaBCfEVUfpLcu7z2DsuxFaG0IJLNoX
RXc9RheuLucgKNEf3xSP5mV8DKAteLKsRYLPLwu5DJ6mWH5BxhBynZ9yIxdyYIPh
XajpLTy/JuBut6qB7cDHlB2CWbebBrTFSQvQhuSg28KqWaXFK8JSzYoU2TGrl7XT
bKbNJ6RxslOw4BKpcB/iOg3ixEGLbbZR4I1an4xAyiDKK3QClknLEs7nXuWu/JOz
eqWpRi1r1wfrZOH+K5cPnZBFNA4pvEwdNsUHznZHZ0WZSSjYpLBvrX77TO/gt7Fa
0CPIl0UoJEbI9QSQ4SHc
=PUQ1
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

--===============6415470592112814181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6415470592112814181==--
