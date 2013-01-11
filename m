From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual
	switch controls
Date: Fri, 11 Jan 2013 16:24:03 +0000
Message-ID: <20130111162403.GA16472@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
	<1357833977-3682-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7496409977923463235=="
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


--===============7496409977923463235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 05:06:11PM +0100, Lars-Peter Clausen wrote:
> Virtual switches are similar to virtual MUX controls. It does not have a
> representation in the actual hardware but allows to control the DAPM routing by
> enabling or disabling a input path into the mixer. This is useful if we want to
> present a way to the user to for example mute a path despite the absence of a
> separate mute control in hardware.

So, following IRC discussion it seems like the main issue here is that
the changelog is the main issue here - this is actually for moving the
writes done when controlling a DAPM mixer input rather than adding new
widgets to control power on/off of paths.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8DwqAAoJELSic+t+oim9QrQP/A+CskIrnJR4dABtGLw65e//
mCCqHpK6rZtmtXfxzzXmxlZphNjtcbLO5cxpQ6YnAjoBBm3nJ7rrWxCpaYgC1AJW
DETHGGa+5ZFsr0tEJlD+tSAq5i+U69TZqA704lhiGuQtqE5Kd2SdlRmaonrpn9a2
kwgHGXW2v3/I9bL13q5K4dY39BRN+3yXT1sMZyO6nUpKoCqxC2TjOYwpnGrOPQDw
AiYN0d0lJucxDbGXWVEYxvS76d7w647MxN31YqdELltJaV9VXf0Nbt6pXGE7lyj5
FFxfTdM3nwfZUvqmbMNDv0v0CTAU4pjxwKujuQa8zvb8m3N3J8MwiSaHvhDuuuwv
HVVDNDzkAmlGOx+rHYZMB6OaStZa+7MEB0WlnJG0vJUm+KJ5W+rFEXhDD7/atgqY
7xdznlxaGHp71NYcaU/UCeuaA37yN+ce9RvVZAWZIoaaBIxjJpEKy/VMXh3lRL0y
3ZqcqXBzVviI8rJHw2JIZStzpzVlD94EQMx8IW6/j7SW3fA3fRlQ4BPMcwog0wUs
FfBUY9p/7O6a+6pLimqWRyGvwGWAPdYNYhDg6laWblpLTPmwb2BD354BpY5H6wkB
N8RFFOTyGlfzspayZv5tEf8R+NT2l+WO3XevzwtSJC5hd22E6hCEKBHgbtuUR4UX
/npSINf/7p1Teqr+XlWi
=hpCC
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============7496409977923463235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============7496409977923463235==--
