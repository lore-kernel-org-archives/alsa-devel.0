From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
 RT5642
Date: Sat, 26 Apr 2014 01:22:34 +0100
Message-ID: <20140426002234.GS12304@sirena.org.uk>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
 <535ADCD2.8050804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2374586216933922113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB1926007E
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 02:22:49 +0200 (CEST)
In-Reply-To: <535ADCD2.8050804@wwwdotorg.org>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jarkko.nikula@linux.intel.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2374586216933922113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gEDzVO9ewb2niHmf"
Content-Disposition: inline


--gEDzVO9ewb2niHmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 25, 2014 at 04:08:18PM -0600, Stephen Warren wrote:
> On 04/16/2014 08:24 PM, bardliao@realtek.com wrote:

> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

> Is this derived from Jarkko's patch? If so, shouldn't he be listed as
> the author, not you? If it wasn't, then presumably his S-o-b line
> shouldn't be in the patch description.

It was derived but edited; I did check with Jarkko that he was OK before
applying.

> I can see why this patch causes the driver to support the wrong chip.
> However, I can't imagine why that causes all the log spew at startup.
> Perhaps the driver is just broken on RT5639 at present (although I don't
> recall seeing any issues when booting on a board that actually had
> one...) Is part of the driver keying off this now incorrect ID register
> read, yet some other part of the driver registering widgets/routes based
> on which entry matched in struct i2c_device_id rt5640_i2c_id, hence
> they're falling out of sync due to this change? If so, that seems like
> another bug that needs fixing.

I'd be surprised if it weren't the latter.  Either way it needs fixing.

--gEDzVO9ewb2niHmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWvxGAAoJELSic+t+oim9hnAP/1GSlrpYjfxsT/1n/YOYqkPO
QZPxiGy28SbcnleRK4rMsIKAzzaNjNPyNI88KVCFwLxJ254GcHmmZClmDGgTcdqW
+5w+ufNI4oVpynZctJp6cXmTm4Ump9hrfieu258UlbNkW8ggnqNHOqnbOwsrjFQG
dLltaCJkHLlR1kZJQ63Quh0C0pYbdUkBcnx5UIo4fPe6GCmCnvOfktaSK03Er4Dy
LWmNzxQ8oR4XYhKlDidTqzsXxZYO7TectmovRhWBOVgr4ORis87Gbmm8bH+lfmm4
0FpoHZnvvLfD8Eusb1hLoQQ68r/4VJfouzKvR45lt/EvswqQuOrf0y18zoqUutl/
2zM4rUwLms4oq5KguXhqk/uKFioOrEa/Ft1bNOj5lubj58W3+7TgSSckmS6BX1H4
4/Un8khvjEyvRJgTckgbpXYgpGoanwJxpUVo2xm3JSTeWibTGUdIEMVZ4SNciuIS
dzIdjHXNdeg0UQ1yzE/YtJ6wbCtAfdtLBk3P0GwU/P3w9scfEbn8ypgZYCfO1xm7
W93clijbM64jEvBZAYrEmJIgHVNs8LGouwkQNYBejbNNqqpGe4z1guivq0YNB7Dm
5133gbjg0m3nDcBuIZjff+4KnPwopWhY88WQvyKaqHRdCN4lGKZ4TU6Yybo3qxYF
1AMXg+tLVIWWBbYcboiK
=jrn1
-----END PGP SIGNATURE-----

--gEDzVO9ewb2niHmf--

--===============2374586216933922113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2374586216933922113==--
