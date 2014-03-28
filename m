From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: Use the platform data for
 DMIC settings
Date: Fri, 28 Mar 2014 23:46:59 +0000
Message-ID: <20140328234659.GA21628@sirena.org.uk>
References: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
 <53359DDD.7090900@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2819535919652130647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EC6C264EF1
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 11:46:23 +0100 (CET)
In-Reply-To: <53359DDD.7090900@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2819535919652130647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 10:05:49AM -0600, Stephen Warren wrote:
> On 03/27/2014 08:46 PM, Oder Chiou wrote:

> > The patch uses the platform data for DMIC settings.

> Shouldn't this also support parsing the same information from device tree?

The driver has no DT support at all at the minute but if it's being used
on platforms using DT (which of course it is now I think about it - I
just looked for the DT support when reviewing) then yes it should.

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNgnsAAoJELSic+t+oim92bgP/it/z+hnJCtiIB9ZPBPmKOZ9
YCHRJHNhYDnOv/behRKH6NpMaBop4kcHd0QoI77TxJX67oL/F+++aLHCyfz8OAj1
2xpTS5I2BHQBqsBGhbsaqgETHppE3lgQtCAFwOHXhtrsJJDmKWuscHzio3U/g2tA
ytYhkjChqlmCbOw6t5AzZJd4wKXadQZuaE/63nuRDQIjxB2dyMNPnvOXPpTRDZ2b
8pV05NJicj5+A0qIkNsJ28PFFaV0HtbGJ72Ns6dzfd9J7T8q5nE/cig0ECWFa1yU
l86usJaAn26Q0CXir+LV3SdLQLdTANbtWDajF5JGpCN8ov+5GRuQfOLZoBsfdMDX
tYHjGxvYJB5wHmc6+veQhsCTSYcvQhtuXnZlEsO7mKb0Rgn26J/gNuUkRnrnq9Tg
epLEPYE1pfGAVWI+ROjFLTDDDfYgmmeMt4TZK3dI1b/n4rTNpRc6mRwEFwKhe2kh
Gn1ABQGLqSRBRlzlbhuBoicPjq7UVADVezjuyWOoOgLCa0qPwtIVhwMzN71YX6PF
Xja+eLu4m3TOKkLoooJHs4/nnfDY+1gSuFldzX86Hx6cWZ9XPlqqqIEesF5GS779
frJ5TDu0XYnmCCrQHNQMysD7jwXU80Hh6bZplCQnx4O4l8aVZU3NnHfjf030PBPM
JGJ++SCzSFKmdmW+/3nO
=4gAV
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--===============2819535919652130647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2819535919652130647==--
