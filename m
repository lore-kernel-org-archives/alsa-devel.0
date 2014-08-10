From: Mark Brown <broonie@kernel.org>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Sun, 10 Aug 2014 11:54:05 +0100
Message-ID: <20140810105405.GW17528@sirena.org.uk>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2390615996350804945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94310261ADA
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 12:54:22 +0200 (CEST)
In-Reply-To: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============2390615996350804945==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBrPGgLb5TVuC51A"
Content-Disposition: inline


--gBrPGgLb5TVuC51A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 09, 2014 at 08:08:45PM -0400, jonsmirl@gmail.com wrote:

> The problem is in asoc_simple_card_sub_parse_of()
> in the else case..

> } else {
> clk = of_clk_get(node, 0);
> if (!IS_ERR(clk))
> dai->sysclk = clk_get_rate(clk);
> }

> This is picking up the input clocks to the devices.  On the cpu-dai
> you want to pick up the ouput mclk (my first input clock is an 80Mhz
> bus clock).  My IIS output clock is: clock-output-names = "mclk0";

> Setting clocks="" doesn't work either, it also picks up the input clock.

I'm sorry but I'm having an awfully hard time working out what you are
trying to say in this mail.  When you say things like "you want to pick
up the ouput mclk" it's really not clear what any of that means - why do
you want to pick it and what is it being picked for?

> But then simple goes and tries to set both system clocks - my 80Mhz
> bus clock and the 22.5 true sysclk. And my cpu-dai barfs when it is
> passed a 80Mhz sysclk.

Naturally...  this does suggest you're doing something wrong but like I
say I really don't understand what's going on.  What does your system
look like, what are you trying to get it to do and how are you going
about that?

--gBrPGgLb5TVuC51A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT509KAAoJELSic+t+oim9uYoP/1PMm/Uavfs1j6Zd7Ui+Dw0M
PzxB3iB8PcwQ4jvTuZvstj1Osw1QeFMLcnHHtUyq8ONwxNb/LJydB5jZphh/RgfU
bfplMIpNqNytkLUZZ+o4ahEKClu7C/ZTJoRSfMdUSgOxBOEgu5N/1uSg/idAYY03
dAqmNirdOiQ2HXsbs1nl9x7593wxKPqTVvALA3E59isH2KaLCCPZKR6c5vIw+bCP
wdkvGN7s9eihmmu/g93wJC+iffc/gNMFoKvGltc2fO7Ow5mxlCMAqqTPg43WpPju
jUEZcLK+65ueJh6ZhIW1N85QiskNDJG/FYEkZrj7JvIMw/4nGHSXANbK+wIK4Fc8
rtn1oezSqEPzIEQ9pnnYg9YDdy3mR/iiQToRgaidP17cPd+tsWTpRbFaT7O3UH6C
M3eIkRfjj4dCSQwitz0DGVRoBkO5oYYeS8CFF/MyDj2lrwlwwI4+wM4RfGlGTk3e
lWyyIp3jZf3X+QSZbCkKuz3WE9Ric5u3bHf/ESSd4ik+mJ9zrRR0CZpy6yt3Tu1t
a2LU1y3tBzIk2ziwsT1i2UxZl0SswgJoK7TvN7cYCZNlvjNmAPW+VA5uh41dNzhg
I1fvoiJoQHdaGlJIhM7ezTBsjqS3Mk8WUNp4GoHG1hCtUNgsY+7ZTp/w+nF0tbwJ
kMmMW4rB6dtcqiuacwq6
=4y5T
-----END PGP SIGNATURE-----

--gBrPGgLb5TVuC51A--

--===============2390615996350804945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2390615996350804945==--
