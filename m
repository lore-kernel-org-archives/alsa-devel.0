From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: Samsung: Disable build on
	multiplatform
Date: Fri, 24 Jan 2014 11:32:04 +0000
Message-ID: <20140124113204.GT11727@sirena.org.uk>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
 <1390560804-31135-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2641134416397214486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9542261684
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 12:32:16 +0100 (CET)
In-Reply-To: <1390560804-31135-3-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2641134416397214486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wYXww9TlNKyqAMAe"
Content-Disposition: inline


--wYXww9TlNKyqAMAe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 04:23:24PM +0530, Sachin Kamat wrote:
> Samsung sound drivers use mach/dma.h which is not available
> on multiplatform. Hence disable audio support on multiplatform
> build for now. Without this patch we get the following build errors:

No, the thing to do here is fix the multiplatform build.

--wYXww9TlNKyqAMAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4k8xAAoJELSic+t+oim9fP8P/2jxYBjcmQHBRfQ40f6b+6wY
NPIuH/Kf1aCFWBX+YSSwGm/lqz5z2mWrUFii4W1EXfuA22merRJHEwuMsWe9ZLKe
9fW1W9C7p/lIUHQpQvAqqZAAvpxpJYMY01GfrkcYEiWIiNiNHNNO8+r9qFLqDlVW
l81Y2L8h83kr8jBUOyMDwc98X5YdnaS94kg0aWIjK4RqZn0HCp6AF4R5eVtY8kcj
9CSY57uaKMgY7r4fmspLZg2mLBdiVjrduFZW6lA2gw71SthTSyMIDjaIkdQbA5en
J57nSu03dTj5jBx2RYZfVq3niXABXikWrIWlXVUqd0er5nkCyn4sqkHHhb1Lg8Ev
W4CRKKIL8TBnsr51ss7lzetk4gOwH+qhpzeSTfy3dZrhBYOqH0gsOGT8dptDG3Kd
VLRJ4ItQPqfcfeajjw8dadQG/GLfEu65MHXyBOhC3JE2yhW0UPbMe2uDP5qruIYf
VRTGO44MKiCTITZjBwVu72UOpnYNhan+sXh5DNGZyKp5fc54G11d26tlrFJRgMaw
4E3eczOj8Yg2Qfum/Z6Tnf3/cw+MDCSKdNISj75pUIlQLQjM7FIDUTWQOEZAQB8H
0KGDL9cxsXzMwOKOJWg/tNxdJGqh48B4kDyiyyfYngNa29sbRMHlilzwJ5f4DWif
J4Cp4jUSR7SzaKhVMGEd
=XWhw
-----END PGP SIGNATURE-----

--wYXww9TlNKyqAMAe--

--===============2641134416397214486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2641134416397214486==--
