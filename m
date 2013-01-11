From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual
	switch controls
Date: Fri, 11 Jan 2013 15:22:02 +0000
Message-ID: <20130111152202.GE20956@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
	<1357833977-3682-2-git-send-email-lars@metafoo.de>
	<20130111121912.GY20956@opensource.wolfsonmicro.com>
	<50F007DF.9000606@metafoo.de>
	<20130111124535.GZ20956@opensource.wolfsonmicro.com>
	<50F00BF1.6090702@metafoo.de>
	<20130111135754.GB20956@opensource.wolfsonmicro.com>
	<50F02A51.3010108@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1745427969663828214=="
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <50F02A51.3010108-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============1745427969663828214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8M+gQFKLhTGBxzRu"
Content-Disposition: inline


--8M+gQFKLhTGBxzRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 04:05:53PM +0100, Lars-Peter Clausen wrote:

> What do you mean by 'separate'? Maybe this is was causes the confusion. Do
> you mean a separate DAPM control, like DAPM_SWITCH? That's not what the
> patch does it creates a virtual kcontrol, which can be used to control a
> mixers input. It's the pendant to SOC_DAPM_ENUM_VIRT not to

The issue I'm seeing is that it sounds like this isn't joined up with
the mute control (as it's a virtual control).

> SND_SOC_DAPM_VIRT_MUX. I realize that the commit message may have been a bit
> ambiguous in that regard.

It's the virtual bit that's concerning me here so I don't think that's
really it.

--8M+gQFKLhTGBxzRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8C4AAAoJELSic+t+oim9KhIP/1uuac5pbfR7/p6zIP0G/yWI
Kck0lN5mOsP1Q+Va8b/We30wuIRK4aN4R5wvaSCQhBAs7KrhNjulO8BgoSpSb0FH
rI+8rWC2JUZzQamlWMTu94woerEVRmPZ9lD0pBy5h9qJgMsxB8Munfyrc8P3KRfX
appp6PJbXeecFpbk+Ac5su4iepgQ3szNizoOmlQQTzIMYSOCv1VS52tr3h534JnF
s/pWMVz9Cp57HToSboHO8qIl3W9qvgCxWzKmW16yO4Y2GF8ADxOShee4P7+KgkYK
2h2uB7LUBUNZ1yJIedota6Uwn/Vfb1F3nSmiPe9ldl8jfvYenNZmX1/J8JqhK9x+
gFQ4xE+1WxVlQl6y8abCa3gIkYjV33gjyY66NieQuygiudcjRUo5vNQKPxT8uQcV
6SZcni4xdJ3O3+kBR79Qlq2/g98eXvekIN3z64cUMRIrIbZXVBkqietHLUGR2UE/
doBaUZTD5meQpiJMeQDFvmV8xqgLuV+PX/hJALfOtgGpiBSUTYiChJmjCfeIcmc0
QV9sdvjmVa8FbVJ5pcME9wub09UI3fMdqLpRMk5HIGSrvMrF2JDZQNZjH+hGmBC+
dUUrK0LI+pZhaoqp3gW1g4TfsDU4PIEkLhQD3vZ8Pq9caM25094rULmkexm5XFEl
4Yaw90t4RM84801EvkuP
=vX6b
-----END PGP SIGNATURE-----

--8M+gQFKLhTGBxzRu--

--===============1745427969663828214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============1745427969663828214==--
