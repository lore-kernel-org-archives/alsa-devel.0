From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: Samsung: Disable build on
	multiplatform
Date: Fri, 24 Jan 2014 12:05:08 +0000
Message-ID: <20140124120508.GV11727@sirena.org.uk>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
 <1390560804-31135-3-git-send-email-sachin.kamat@linaro.org>
 <20140124113204.GT11727@sirena.org.uk>
 <CAK9yfHxGquh+gVW4E6_=4Qax_HLxdPtF9paJW6GO7OiXObeMNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8706882357536576174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2B5C2616F1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 13:05:13 +0100 (CET)
In-Reply-To: <CAK9yfHxGquh+gVW4E6_=4Qax_HLxdPtF9paJW6GO7OiXObeMNg@mail.gmail.com>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8706882357536576174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MLcyhLwX/7AHNQNx"
Content-Disposition: inline


--MLcyhLwX/7AHNQNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 05:25:09PM +0530, Sachin Kamat wrote:
> On 24 January 2014 17:02, Mark Brown <broonie@kernel.org> wrote:

> > No, the thing to do here is fix the multiplatform build.

> Yes this is only masking the build error temporarily until the code
> becomes multi-platform aware.
> Since legacy code is involved in this, I am not aware if it is going
> to happen sooner than later.

We're just waiting for the s3c24xx DMA driver to be deployed, it's
merged.  In the meantime you should fix the build so those platforms
that can be multiplatform are buildable there.

--MLcyhLwX/7AHNQNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4lbwAAoJELSic+t+oim9lKkP/3UHlWUUSbfPYoDebkU6HwAe
dZcza1tuELo4XQT5LUUasxt5epzJtiDkIMw8yCN84QooLSriCLU9CYigOo2GwmzL
M1eA/DOBrIn4UOIFZSO77sgjiNIWxw/FS7F32G+d+yzP3YAr8oZYOJL2hpL2MiDx
0/+ATHk8OAzwZ8nstimbxP30MwiinyXeefOUWHNLeHkiZ3H0wmXam1RkxrikBQM0
AJiApgk9p67t8qVbiEjxk7ubfm32KOqJsyAipoRhRumWRboKJNgKSkf9JPAZpKb5
3eETTrheXimgrnIh74C/hMUtSh7nZ6fgC5VARdB9Wb7Q5l1NqcOjPVfK8JvY9Gz/
cNzwywp2TEyYl6FLzrIAw8n9r4g3m7aghP16PwHfyVRCZRrOkWFxytrlnWgveeMa
SCDwOSXsS9OdyRMdFZWchmZqyLhw8qYtiD2jWzSmuVx3IopglQG7XVgeNUxPBfwr
qdU7hYoaPOhpICUWKrdEnn6q+Ecno0ni9Hcrhk1yHvBvIFG4F+JD0TIkH3avU2rG
WhrHe2abeWXc+uMCD8EKveqMJxe/VgQPnC2cbP1b8lcNJBeWePL3A8FTUS+2dwF/
IW83ah8swAnDx2GOYoa0GGdM5u25lDvbkxc1InsbzipcFhh6RK+IAnixC0yuZdT2
1ryCOIuQ4Wr8C9+81MbL
=5Doa
-----END PGP SIGNATURE-----

--MLcyhLwX/7AHNQNx--

--===============8706882357536576174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8706882357536576174==--
