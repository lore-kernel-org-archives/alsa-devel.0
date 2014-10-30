From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix block is enabled multiple
	times issue
Date: Thu, 30 Oct 2014 13:41:32 +0000
Message-ID: <20141030134132.GX18557@sirena.org.uk>
References: <1414675312-7667-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4590773677534318121=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0222A260508
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 14:41:57 +0100 (CET)
In-Reply-To: <1414675312-7667-1-git-send-email-yang.jie@intel.com>
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


--===============4590773677534318121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ua8iSVM1QPEF/ktp"
Content-Disposition: inline


--Ua8iSVM1QPEF/ktp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:21:52PM +0800, Jie Yang wrote:
> During FW parsing and loading, block_list_prepare() may
> be called for each raw data block copying and this may
> made the hsw_block_enable() called mutiple times, which
> increase block->users many times. The result of this is
> hsw_block_disable() can't power gated the related block
> when trying to free the blocks during suspend, and the
> power gating status also confused.

Applied, thanks.

--Ua8iSVM1QPEF/ktp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUkALAAoJECTWi3JdVIfQaksH/jk+8zn6yLt7dJDWaO8gri7m
u5SFY6wT16bkz8BhWd4FUG/9LO43++DA/7mLb3KgDikgs9WU6rxn6fTxsAcGt7Yx
/ltzsa2Kv13o+ylcjRxXmXOJAa5jFjXHuvl8Z5MJWsqpk/AclyZKzy/NGIqsOpbu
bbwlwykbJABTSvZ6M4LpcLsvzLGvd9Ytj1wzdTnWLBy4VevP5t0hh9FtckcwdDqW
D69rOE7cBm5QfwJbqqm9eAFeTiEln4Roz1q4UTqlWFeyZFTx7BbefC6w6wy8INQv
4d9Zso8PzXpT5iaB1Wc/srmBrm4UTS/GCM9p5PzAXTOuCObKdC50YCztaXHbVYE=
=qRaZ
-----END PGP SIGNATURE-----

--Ua8iSVM1QPEF/ktp--

--===============4590773677534318121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4590773677534318121==--
