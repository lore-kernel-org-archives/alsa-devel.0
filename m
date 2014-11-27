From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Remove useless loopback
 volume control for Broadwell
Date: Thu, 27 Nov 2014 11:01:03 +0000
Message-ID: <20141127110103.GH7712@sirena.org.uk>
References: <1417068263-12026-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4919806280514016980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8563F265E28
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:02:56 +0100 (CET)
In-Reply-To: <1417068263-12026-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4919806280514016980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrBUKLANcJUwWlBH"
Content-Disposition: inline


--FrBUKLANcJUwWlBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 02:04:23PM +0800, Jie Yang wrote:
> On Broadwell, the ADSP FW don't support loopback record volume tuning,
> so here remove this control.

Applied, thanks.

--FrBUKLANcJUwWlBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwRuAAoJECTWi3JdVIfQN3sH+wexgLbiFUSAmTN+NoImvwQf
BXu2fBt0F1BHOhNPjF67Hk1xhMO+vTC2O+p66T0qkHyIHixWK47qDMZfFtuEyfIu
5R44LdY8Ww4XVojpcrtGvAsTX7WLk7Yn2eAvzDbyS9BKqkwE1sTTuVKkZdLRzK5Y
KVr4ZT63IpIB2vO2vAyrtXscrPI7kvLXwpTiXqn00Cw8ENY68WySOCEUSaR9K877
9HKIOog3hrGpGojF8XWgTiJhP7LbEeBLo0eGAJXyc2HhhnPn7vEUOYTGOJmfCAgc
ROge5W/2LXNELI8PUbcxGnU3GF757wNvRzEfQbtpTfT+XN1RS12w7EixKdzSDgE=
=lnhv
-----END PGP SIGNATURE-----

--FrBUKLANcJUwWlBH--

--===============4919806280514016980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4919806280514016980==--
