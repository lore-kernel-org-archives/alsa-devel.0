From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix block is enabled multiple
	times issue
Date: Wed, 22 Oct 2014 10:26:01 +0100
Message-ID: <20141022092601.GI2344@sirena.org.uk>
References: <1413947278-3458-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0647928209584363106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4200C26060F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 11:26:13 +0200 (CEST)
In-Reply-To: <1413947278-3458-1-git-send-email-yang.jie@intel.com>
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


--===============0647928209584363106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2014 at 11:07:58AM +0800, Jie Yang wrote:
> During FW parsing and loading, block_list_prepare() may
> be called for each raw data block copying and this may
> made the hsw_block_enable() called mutiple times, which
> increase block->users many times. The result of this is
> hsw_block_disable() can't power gated the related block
> when trying to free the blocks during suspend, and the
> power gating status also confused.

This doesn't apply against either fix/intel or topic/intel, please
check and resend.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR3gpAAoJECTWi3JdVIfQcNkH/Ra8Zu1c59DK446RIdD/EzQv
BGmFylCA4KW0PCrAfJRlkEiqTmdGjZ3l4mmYiK/tWef55OP+AQ0gK9N2mO9w9v+z
7MRFA9wi2DHNnz5+Fa2af+TyUROJ/1HaQJn8DSFFtCzHpnHqXIR0LXZpehj+bn2K
U6lkUdDbq6gHFmz2C/MGCMZDCe/t9okFFBbNB6AQz0w87HA8xjKJJ6dfQtPdjNvl
9FlY6nBPg5jR3jMg1E2zafFgnBWY/CpiPkPDLH6+3XT5OFdTPAvBxexLC2OSta6M
0uU9OQNR7q4ZWUe6RrR+dgSskOcQOIpev+x/6WvVG0oPsTsbfBHfnJFFivD42V0=
=wvu8
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--

--===============0647928209584363106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0647928209584363106==--
