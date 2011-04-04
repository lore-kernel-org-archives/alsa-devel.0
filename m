From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH 4/4 v2] alsa-lib: fixed coverity reported
 issues under "USE_AFTER_FREE" checker.
Date: Mon, 04 Apr 2011 10:05:48 +0200
Message-ID: <1301904348.3970.14.camel@mattotaupa>
References: <1301902076-32126-1-git-send-email-sudarshan.bisht@nokia.com>
	<1301902076-32126-4-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0700333510489156611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D98B10381C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 10:05:51 +0200 (CEST)
Received: from f053044031.adsl.alicedsl.de ([78.53.44.31]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q6enG-0004YW-D6
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 08:05:50 +0000
In-Reply-To: <1301902076-32126-4-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0700333510489156611==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zMTQtRcoOVkhwHk8Td1f"


--=-zMTQtRcoOVkhwHk8Td1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 04.04.2011, 10:27 +0300 schrieb sudarshan.bisht@nokia.com:
> From: Sudarshan <sudarshan.bisht@nokia.com>

Please use your first name and name. You can set that up using the
following command.

        git config user.name "Sudarshan Bisht" # If the order is
        correct.

> ---
>  modules/mixer/simple/python.c |    1 +
>  src/control/control_hw.c      |    1 +
>  src/mixer/mixer.c             |    1 -
>  src/mixer/simple_abst.c       |    2 ++
>  4 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/modules/mixer/simple/python.c b/modules/mixer/simple/python.=
c
> index c822c52..784d9a0 100644
> --- a/modules/mixer/simple/python.c
> +++ b/modules/mixer/simple/python.c
> @@ -663,6 +663,7 @@ pymixer_attach_hctl(struct pymixer *pymixer, PyObject=
 *args)
>  		return NULL;
>  	err =3D snd_mixer_attach_hctl(pymixer->mixer, hctl);
>  	if (err < 0) {
> +		snd_hctl_close(hctl);
>  		PyErr_Format(PyExc_RuntimeError, "Cannot attach hctl: %s", snd_strerro=
r(err));
>  		return NULL;
>  	}
> diff --git a/src/control/control_hw.c b/src/control/control_hw.c
> index cf258b4..16c4987 100644
> --- a/src/control/control_hw.c
> +++ b/src/control/control_hw.c
> @@ -414,6 +414,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *n=
ame, int card, int mode)
>  	if (err < 0) {
>  		close(fd);
>  		free(hw);
> +		return err;
>  	}
>  	ctl->ops =3D &snd_ctl_hw_ops;
>  	ctl->private_data =3D hw;
> diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
> index 85d843f..5e5789a 100644
> --- a/src/mixer/mixer.c
> +++ b/src/mixer/mixer.c
> @@ -228,7 +228,6 @@ int snd_mixer_attach_hctl(snd_mixer_t *mixer, snd_hct=
l_t *hctl)
>  		return -ENOMEM;
>  	err =3D snd_hctl_nonblock(hctl, 1);
>  	if (err < 0) {
> -		snd_hctl_close(hctl);
>  		free(slave);
>  		return err;
>  	}
> diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
> index 9e9aaf5..127d8d2 100644
> --- a/src/mixer/simple_abst.c
> +++ b/src/mixer/simple_abst.c
> @@ -336,6 +336,8 @@ int snd_mixer_simple_basic_register(snd_mixer_t *mixe=
r,
>  		err =3D find_module(class, top);
>  	if (err >=3D 0)
>  		err =3D snd_mixer_attach_hctl(mixer, priv->hctl);
> +		if(err < 0)=20

Missing space after `if` and trailing space at the end. You can use `git
diff --check` for that.

> +			 goto __error;	=09
>  	if (err >=3D 0) {
>  		priv->attach_flag =3D 1;
>  		err =3D snd_mixer_class_register(class, mixer);

Additionally I would use a different commit summary what is done and
write what you have now there into the commit message.


Thanks,

Paul

--=-zMTQtRcoOVkhwHk8Td1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2Ze88ACgkQPX1aK2wOHViImQCggVZrDFo0YC5XRRg1KFxUDouS
1HQAnRdRjH+x8qkM6OetRw2FgaRQqXDe
=l0+K
-----END PGP SIGNATURE-----

--=-zMTQtRcoOVkhwHk8Td1f--


--===============0700333510489156611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0700333510489156611==--
