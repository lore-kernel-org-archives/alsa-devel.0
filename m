From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual
	switch controls
Date: Fri, 11 Jan 2013 12:19:12 +0000
Message-ID: <20130111121912.GY20956@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
	<1357833977-3682-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0291323875638160421=="
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1357833977-3682-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
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


--===============0291323875638160421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Content-Disposition: inline


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 05:06:11PM +0100, Lars-Peter Clausen wrote:

> More specific this will be used by the ADAU1361 driver where the hardware has
> a mute control for each of the DAC output paths, but we have to make sure that
> the path is muted whenever the DAC is disabled. So the mute switches needs
> to be controlled by DAPM so it can disable them before disabling the DAC. On the
> other hand we still want to be to mute individual paths. This will be
> accomplished by using virtual switch controls.

This doesn't sound like it does quite what you want - it means you don't
actually end up with a mute control, only a power control (which is also
going to affect everything else in the path).  I'd expect to see
something like this implemented by having a control that has a specified
value forced in the register while the control is enabled (kind of the
opposite of a supply).  This is a fairly common need for older parts
though it's unusual to see it on a new device.

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8AM5AAoJELSic+t+oim9cQwQAJPdlukbDycY4jsBz0aH0fvr
NogEvvtvZvJPE6XbFhiw/JqRBxp2Rj3WiuiSOz29en2kRXtxgdRcwCeNo6GCW51W
hm30MA50CeK/1Ijfy9pWYBI4zSb7PrfqBa6l+uG1Dbgk+xETx5maSXp1q4Y45110
2WMo5A81y3+/YTFSvDmYMhthECw6izg1ZJyqqJ9O7HVisZLsg/1C3ZgQ8iKo1qO3
tyyZ9C+xyb4ZtoWRaCqoIsMGlhCmYe2JmutxkAgw7ajGUtcYiiwsNWx9o23hoAY2
5cF0GID6FMdJ/eOnK0kDHVZoyFD19aPUoyU97HjVEcpnesNTWSboVcRAAIUVpt7o
rE/0zAtpQCNR0xKzRlWEygR9EfmXMAXm3/x9L7Fp5WADFNLMYCxRSCSPNKHhGJwi
w1wfETHU1mcyYOaydF+6p4Ix8YtFtzkE+rBFg07zJUQBanJAOH/Bd4gLeYfosRiM
cZn/mBfTiiPrzWWqvY6cmCT7+yRoGb4zsbMvijEfDdvm8eGcOA6KusMp1f3G6ng9
OJRgNfpGNl+tyLMh0Ku7BwBwCvIls1LvAq+6IV8dZH/2bKOwgehOJhjRD6ZmdpXp
B7hxC4UcB6STT0yh4zZ6+/qyIsl5Xdm5w/vk6VX7Z13iIzYfh6nIXu6OkGiCqwWq
YDIVimQpYKJvXDRsUcF3
=LEG8
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--

--===============0291323875638160421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============0291323875638160421==--
