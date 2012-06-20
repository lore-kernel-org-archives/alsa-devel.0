From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] asoc: add sport driver for
	bf6xx soc
Date: Wed, 20 Jun 2012 11:25:55 +0100
Message-ID: <20120620102555.GI3978@opensource.wolfsonmicro.com>
References: <1340226031-19930-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3635259213465378414=="
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1340226031-19930-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3635259213465378414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2012 at 05:00:30PM -0400, Scott Jiang wrote:

Applied, thanks.  There is one minor fixup below - please send an
incremental patch for that.

> The SPORT(Serial Port) module on bf6xx soc has a totally different ip comparing to bf5xx
> soc. An individual SPORT module consists of two independently configurable SPORT halves
> with identical functionality. Each SPORT half can be configured for either transmitter
> or receiver.

Please take more care with the formatting of your changelogs, they
should be wrapped to within 80 columns and the subject line should
correspond to the subsystem style.  I reflowed.

> +static irqreturn_t sport_err_irq(int irq, void *dev_id)
> +{
> +	struct sport_device *sport = dev_id;
> +	struct device *dev = &sport->pdev->dev;
> +
> +	if (sport->tx_regs->spctl & SPORT_CTL_DERRPRI)
> +		dev_dbg(dev, "sport error: TUVF\n");
> +	if (sport->rx_regs->spctl & SPORT_CTL_DERRPRI)
> +		dev_dbg(dev, "sport error: ROVF\n");

These should be dev_err() not dev_dbg() - they're errors.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4aUsAAoJEBus8iNuMP3dsd4P/26LELHC+xYp6kGQUtIjQDGo
Su87Fk44wUGqZM6uEbWVIb/1FTrovGwVZefaW0h5FgR7cciwbFL3o+CBlPrtOGz7
FCStcBGODUTvg9uTtaOWHfOd7faDhWWo6/TFr8Gty1YBnYHZH4SfbVzk6sAlBVWO
t+8MM7Fn9b2wNgdELHVtGIf+D7PGchDyoWxszHtMskwuauiut1fHM7cM6PyE2bIu
Eehrpw0/VR/7z0kcgOGk93nvxalQ1TzIKBCwCddT55qX7lQ8mSwkyiNrJ8NRmwmc
FTxhm6fr4TIgy8ehlEI8YDggAJts8syKbfqihYV9XqK39qAhfKv9RC435nTGV5RU
QajXPzhCigqUyjHXe6cQXurnD4r7RVmD3h4/yyU/0mKYQnaoqo5UBJKpC908Asxj
XqYPX/ekiM01dd8cFDQ+QK88LK7mu4nv2CdUbTrRYZnN1HlE9MQEMiFv3JuaEGxD
EQAPqvDZtMq8wX0mJn3duDhbfCFoKb4w4EpN/DZyvj/H3JCsu7hqTnvy+ooXGGoX
cVND7LoD8+7qg/IH8DLT5FiTYPLhdId6+C8ccRFNVZnD9jDAvnrY/TqpgPYuY/kz
kFbd8rrgW7IDTmlNXje2oszyJN4jPmXLbyjdpArKEPKH/Ii9FBxmnYpHmBWsMAwc
VeshnoLSVWfxQQkceUJ5
=A2CI
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--

--===============3635259213465378414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============3635259213465378414==--
