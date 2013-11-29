From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 14:17:55 +0000
Message-ID: <20131129141755.GA27568@sirena.org.uk>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
 <20131129110549.GQ27568@sirena.org.uk>
 <20131129102937.GG8834@intel.com>
 <20131129131153.GF10013@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3609011243014258205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BD85261721
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:18:02 +0100 (CET)
In-Reply-To: <20131129131153.GF10013@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3609011243014258205==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSfbCJd5UFatzzNC"
Content-Disposition: inline


--VSfbCJd5UFatzzNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 01:11:53PM +0000, Charles Keepax wrote:

> We haven't done a lot of investigation into the latency of this
> at this time but it is certainly something that is coming up in
> discussions and I would expect we will be starting to worry more
> about it in the near future. I will endeavour to share what
> results I can as we get into this more.

Given that you're working with devices that aren't memory mapped I'd
expect we'd have to be doing something appauling for it to register -
the costs of doing I/O really ought to dwarf anything else for them.

--VSfbCJd5UFatzzNC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKIQAAoJELSic+t+oim9xIwP/2HcFwWxM/hqcMWulEHwWxDu
BDDT9teNGYZG0U/JLkjBVSirrIoOxD75ftNIPouJ6SlOipsL/AlzwuG5F5ePYT6X
d2BNCc6NF74F2AJcSLAcX6ER1YJYtxAsbDeTcEJG3ViKx1up2mflQCG8dUk9vdg1
ez1gOWNvwuFr4fwmvkdAkDEQhkhFgxkzzNkAGwnmBA3y7N7gGvcVCgDkJZF/aYLT
CETCSzZuSsX19kmqNzNxK/mmkiPu/TNuof+W+XNW8LPZHMli73K2FgjCHSEC8Azr
9BJnJJuhBXVKDSMBG0R/oAGiMbtXKt9EiLOoah/fu8yxhZDejD4Ayt/AbtYAE7Fm
xJSTnv43FOrAGWxwEjZDct8GTLFBjWfXX4hYTYeJQIjqG7sMPQfKOVYsV3ywE7KQ
+bZIqMh6CbE6PjLNfbmuy8680RkhTM0RG27mfK1T1zSGchcJbFOaUxsQ8c4kES2x
Osu3f7kGObIl8IIfOErNldaZlZ7w7fsbwVhkdgeoVeewxz7f4xLasvz6Ovf30XJy
eZdx+DAUxmO0UrzXIujRVktRtlb0ScRjoEgn5wKkMRx3+W4gETJqQRTTP06BokA8
lsjln2Wo2JGqrZK9NGv2X1wFy/zCaSCBD43e+HRwT/VBs6JdjQkoYmVc1E187oHc
Y3ul2LcaYGjmK3PUJ2nL
=DREv
-----END PGP SIGNATURE-----

--VSfbCJd5UFatzzNC--

--===============3609011243014258205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3609011243014258205==--
