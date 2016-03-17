From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Do not traverse widget hooks
	to snd-soc-dummy
Date: Thu, 17 Mar 2016 11:25:14 +0000
Message-ID: <20160317112514.GE2566@sirena.org.uk>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
 <20160317095438.GD2566@sirena.org.uk>
 <1458211115.965.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4296685136995450790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 857C2260831
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 12:25:28 +0100 (CET)
In-Reply-To: <1458211115.965.13.camel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Pan, Harry" <harry.pan@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "gs0622@gmail.com" <gs0622@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4296685136995450790==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QQyEkJ+v1X6lF3FS"
Content-Disposition: inline


--QQyEkJ+v1X6lF3FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 10:38:36AM +0000, Pan, Harry wrote:

> Allow me to explain more detail that I saw during debug; since the
> commit 6e78108bda78 (ASoC: core: Don't probe the component which is
> dummy), an exception has been made that dummy component won't be probed,
> thus the 'card' passed into soc_probe_component() would not be assigned
> to this component. In the other hand, the component struct is initially
> created in snd_soc_register_platform() by kzalloc() of platform struct,
> its 'card' pointer is remaining an NULL pointer even the widget node
> being read.

> Perhaps another option is to refine soc_probe_component(), which I have
> not dive in.

Another approach might be to create a separate dummy component for each
card rather than trying to reuse the same one for all of them (which was
what the commit you mention was doing) - that way we don't need to worry
about it getting added to multiple cards which was the original problem
that was being looked at here.

--QQyEkJ+v1X6lF3FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6pQZAAoJECTWi3JdVIfQt/wH/iO1xD5ssPveBXHtNZG7b2WG
Db3zmW9Nb+5oPAwdUZyUHWG7DOtLrsXw486ML4Y2+TjxO2zZIWUycHrZVyVAVFvn
JYB8r2jjiD4/aLvYuogCpuhJKKHhd3teFkL5C0LcOv4qAVvIY+3Te7XpPly92DPx
5qX5rzZtsMrXPBSaOZYydRptiVS5Us1ZtcIqCtqUC4BseVgU9pHxvdut5MW47mB9
rLPUU4gACp9QqkBNN6sbgUKEgu5mpwvPRx/G5a5/XgHx9yBo67EHfU7+fMpCpgFT
+WeVDaisZxz9bbR+6zzDRKlzcj4iYDXHSwvzcn/jzIw+BwsiAWMKgMBfffaCa2c=
=ONYi
-----END PGP SIGNATURE-----

--QQyEkJ+v1X6lF3FS--

--===============4296685136995450790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4296685136995450790==--
