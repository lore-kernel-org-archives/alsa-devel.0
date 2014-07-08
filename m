From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Tue, 8 Jul 2014 10:02:32 +0200
Message-ID: <20140708080232.GQ30458@sirena.org.uk>
References: <20140706070800.GA2927@himangi-Dell>
 <20140707144832.GL30458@sirena.org.uk>
 <alpine.DEB.2.10.1407071655171.4757@hadrien>
 <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
 <alpine.DEB.2.10.1407071721270.4757@hadrien>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5854399690467305105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C61A260309
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 10:05:48 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1407071721270.4757@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Himangi Saraogi <himangi774@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5854399690467305105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2014 at 05:23:39PM +0200, Julia Lawall wrote:

> There is documentation about what kinds of devm functions exist, but it is
> too bad that there is no documentation about where they can be used.
> Often there are several levels of function pointers involved, so it can be
> hard to figure out whether they can be used just by looking at the code.
> I have only taken the strategy of using them in kinds of functions where
> someone else has alreadyy figured out that they can be used.

It should be fairly clear given what they do I'd have thought - the
devm_ functions tie the deallocation of a resource to the unbinding of
a driver from a device so they can only be used to replace things that
get cleaned up in a device model unbind path.  There's not usually a
great deal of indirection going on in those.

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTu6WUAAoJELSic+t+oim95awP/jjOLSCVkX3YiKWWl7qzeCSV
cDIMQM8qaRoi6u8f2LVRYugp+kvCa3IZScM7L5nVywcS1mHgWxtVexuoQQbJ9UtY
X5TjJA/SNzA2kyIFFcSK66+PmOoldszq+Yjefs7OHui8ecA3o4k60AJeA1IL8Nk/
zit7PhMrJYeYgsTZ0pGX/MVV8ow0a3ayglXyvqGeGoK/2J44v1p6+MjPwcd2QQwl
I9RHyPbMTUreFsLPDelQfHhHD0BoAF5qb/EDvmdQVpiWZ6PyJIR0WloLZepOiIoP
DJ/FjhQozqa+s9qCA8GTXAAE1isRGvz9tHNJWL0s0tObHAHpwW2lqOXeKo1BRuxh
6vVPBTfUYfN4+/ZGZ0ExNwmI6YRecG9tpWe2KX7uZjjocAI0NCHvlBzibXgKtwUd
B8hXsIOjHXruESQmbZrfH4M8VPoc/BBqJ6xGGkq/Skg9EWvdIDgHofjU84ggBljD
vygIgzRslvd3QoKA/oEBna+k91lJvdJt2GbhUw1Y3uYnhNpfv2UNSLnYGlbCyszF
YEQj7yLXUM7kG82t+t8Eg/HBaA5coGFu9sNkZ9Muj4tUylgCLPZdpgbcjVVtLndd
F+rFzAa/o3gMpNaevo5ka239PEEweDyXL+ERr7CV/Sbdx67yi/AvvNXIeWsT0fU1
AIPRF/WSmpV9hoRwOZYL
=Ccns
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--

--===============5854399690467305105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5854399690467305105==--
