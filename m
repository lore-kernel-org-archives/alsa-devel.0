From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_da7219_max98357a: Map
 BTN_0 to KEY_PLAYPAUSE
Date: Wed, 27 Jun 2018 23:13:37 -0700
Message-ID: <20180628061337.GA128601@decatoncale.mtv.corp.google.com>
References: <1530166267-13731-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7927609082063300927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C10A826799F
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 08:13:42 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so1995868pgv.12
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 23:13:42 -0700 (PDT)
In-Reply-To: <1530166267-13731-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mac.chiang@intel.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, bleung@chromium.org, pierre-louis.bossart@linux.intel.com, bleung@google.com
List-Id: alsa-devel@alsa-project.org


--===============7927609082063300927==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mac,

On Thu, Jun 28, 2018 at 02:11:07PM +0800, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
>=20
> On kbl_rt5663_max98927, commit 38a5882e4292
>     ("ASoC: Intel: kbl_rt5663_max98927: Map BTN_0 to KEY_PLAYPAUSE")
>     This key pair mapping to play/pause when playing Youtube
>=20
> The Android 3.5mm Headset jack specification mentions that BTN_0 should
> be mapped to KEY_MEDIA, but this is less logical than KEY_PLAYPAUSE,
> which has much broader userspace support.
>=20
> For example, the Chrome OS userspace now supports KEY_PLAYPAUSE to toggle
> play/pause of videos and audio, but does not handle KEY_MEDIA.
>=20
> Furthermore, Android itself now supports KEY_PLAYPAUSE equivalently, as t=
he
> new USB headset spec requires KEY_PLAYPAUSE for BTN_0.
> https://source.android.com/devices/accessories/headset/usb-headset-spec
>=20
> The same fix is required on Chrome kbl_da7219_max98357a.
>=20
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAls0fJEACgkQHwn1ewov
5lgEfw//SQLOT1/b+27ny8SlUNDezalGxxGyejghwm3tlBiahLYvxmiJpmYbIzqF
bc0uRsFJY5/qHKWhZcqbSl1KjBXgbUEU6gFYiinmla0Z56h23MVh7cmXULkU/bw5
UYGIUyS+4Dt/lBfFFdOW3r9i4rQZ6EOcsyaiDhzm58fnDoJk11nmMWi+1hFkWN1b
rlmJq9O+zXagnris5d8+5HNvH66v+0mHmHRe79txdaF5UIca2rAShjME7nb/mFyQ
MKRCMI8CXr/A50eFNhqXdvsoi0gvz8+5ItzYU/KbZeubYb+O0A+NRu+qZ2+RO5fy
hv2kbXS3rd+LAdT+wJa39ISI3fipBAMbcMvQ2MWLjWSKKq20mUCRdG8CWI02sb3c
bswCb1A10l0VbC4Jji6rhjyUM3VhbRtZfJ6q0FfxE80cnHEzPXD4npgOJcZihsVV
UYrvsLNDihRIWzVn/rZBZFInTfuhnO+0HrAQOcmVKkYGkoWgof/+U3RRRfdoZWxm
6vUDPuIOXikvlYo7a+L2SaY3akeYM/Xz8VjsJufss6rU2u01MyXkjNmO8G1hUHpz
Xmq/0mo6yX7mxKdocUyVIZ2EGcKE2P3cBWzwyJTm0ijSEnroqK3c5lwjh2QnYbYM
HyFc7BrQwBFC7De8w+SHAH6zQSAP3RkfEqMWLa4hN/Ck5Cj3GfI=
=oolH
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--===============7927609082063300927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7927609082063300927==--
