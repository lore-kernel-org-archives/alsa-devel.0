From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: dell-*: Add interface
 for switchable graphics status query
Date: Thu, 8 Mar 2018 17:38:37 +0100
Message-ID: <20180308163837.myfmnowz5ogto52w@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-2-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2578405435568653213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 798DE2673F5
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 17:38:40 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id 188so479239wme.1
 for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2018 08:38:40 -0800 (PST)
In-Reply-To: <20180308091023.9061-2-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, tiwai@suse.com, platform-driver-x86@vger.kernel.org, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2578405435568653213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qk6dsxcavtjhuczj"
Content-Disposition: inline


--qk6dsxcavtjhuczj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 March 2018 17:10:22 Kai-Heng Feng wrote:
> +int dell_switchable_gfx_enabled(bool *enabled);

What about following API?

bool dell_switchable_gfx_is_enabled(void);

Are you really interested in errors? Then what about?

int dell_switchable_gfx_is_enabled(void);

with e.g.
  < 0 - error
  =3D 0 - disabled
  > 0 - enabled

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qk6dsxcavtjhuczj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqFnBgAKCRCL8Mk9A+RD
Uv37AKDH/cgvznJjDKcmEdMbu1ruHksJogCfV+C3N7NwJFZfaToBx9dNPNj7ze4=
=lj6p
-----END PGP SIGNATURE-----

--qk6dsxcavtjhuczj--

--===============2578405435568653213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2578405435568653213==--
