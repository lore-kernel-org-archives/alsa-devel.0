From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: ak5702: add support for ak5702
 -- 4ch ADC
Date: Mon, 26 Nov 2012 16:36:29 +0000
Message-ID: <20121126163628.GP9411@opensource.wolfsonmicro.com>
References: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
 <20121029160450.GB4511@opensource.wolfsonmicro.com>
 <CAFsPKCUXU6OYWQNGy8VOuG-Z=tB81CVbfQtbhq35N2gf4PkX2w@mail.gmail.com>
 <20121029181734.GI4511@opensource.wolfsonmicro.com>
 <CAFsPKCVmLx_zqQVspNCjeGL-i8nJoyu7t11CB4PUjk4oKwJv_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4293603493175537887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94BBB2650F3
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 17:36:31 +0100 (CET)
In-Reply-To: <CAFsPKCVmLx_zqQVspNCjeGL-i8nJoyu7t11CB4PUjk4oKwJv_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paolo Doz <paolo.doz@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4293603493175537887==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l7GkBbkEatsaRqBf"
Content-Disposition: inline


--l7GkBbkEatsaRqBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:14:58PM +0100, Paolo Doz wrote:

> 8 bit register (ie ADC A)
> bit 0 -> select left1 or left2
> bit 1 -> select right1 or right2

> bit2/3/4 other settings

> bit5 -> if 1 select left5 otherwise select (left1 or left2) depending on bit0
> bit6 -> if 1 select right5 otherwise select (right1 or rigth2) depending on bit1

> Is there any SOC_ENUM that can be used to represent this situation? I
> mean something like "Left1, Left2, Left5" ?

> At the moment I have one SOC_ENUM to select "Left1, Left2" and another
> for "Left1/2, Left5"

That's pretty special and creative, you'd have to open code it otherwise
the structure you've got sounds about as good as it gets.

--l7GkBbkEatsaRqBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQs5peAAoJELSic+t+oim9Om0P/2B/C/5sK7+xz+Pbu3RnQFaS
+EMbrRcChhVu6adP+n1dslu4Z4kKJK2wU8dM5rGNux/3pbHaTvxce/lvLlBglf1V
ih0KXgttB403Q8EKvFiRmgBn2jgZ/1c1mwKy2Ur0vXZc6WkzAZ9wQ6f23poNVObR
OHPj2dmcQVPgJ6WSb7EsMFeuzgH0LcYy3DPFzowX02ncfbZ1DvlXZeNQfWqn2PGE
nvwLJ3u9rsw7W3oFVUb8g518hTdBum/SR7+70cnc5H4yYT1p1NyB2EiW+BELdrio
/+tI2khzaXg8NNGginumX6SfQ72y4S/tbtw4c5hCB6WcuuAJW+UlhHdXiypcAkNM
FFDZbgZF1n0K1HGLaOG/AORKFOAfcT8uTAyT5LJBW7k048dhcHwhL9PVLcvFhYTl
KMtE+ra8+jV7WbJYbcHTk9maWLd12V/EIZpYJ+td+pObwuQFjq2z0e0fxCPcdPK7
Y8598aF6bbXod8dIQPETyHfs5FjRE5CuSz60RCXzT2P/nBPSfUTr05j1ALd6DQ3/
Nqf3WKo50zhkOCamay3lgifKFyG8s+/zRixp5eY1qm8nbsX322yNsb6fUjjNGHaY
BlCVlbD2NPifSkwH3XxrGO5OOrDPG6lJXaomEQLoaePR7GC2BUMDm/e0AIKQLZ8Y
a13Ah0nPAJSfsV2KTpN2
=Up2j
-----END PGP SIGNATURE-----

--l7GkBbkEatsaRqBf--

--===============4293603493175537887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4293603493175537887==--
