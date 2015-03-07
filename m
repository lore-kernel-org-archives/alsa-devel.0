From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/24 v2] ASoC: rsnd: move 2nd DMAC in rsnd
 driver and subnode dma-name support
Date: Sat, 7 Mar 2015 15:08:57 +0000
Message-ID: <20150307150857.GP28806@sirena.org.uk>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2169326913722886293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7E22605C7
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 16:09:02 +0100 (CET)
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Linux-SH <linux-sh@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2169326913722886293==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r/w8vo2lxBmCPGjQ"
Content-Disposition: inline


--r/w8vo2lxBmCPGjQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 20, 2015 at 10:21:10AM +0000, Kuninori Morimoto wrote:

> These patches add Audio DMAC peri peri implementation in rsnd driver.
> I will remove current DMAEngine side Audio DMAC peri peri implement
> if these are accepted.

I've applied all of these which I think is the intention but I'm a bit
confused since there's a random reply to the first patch where it's
replaced by a v3 marked as patch 1/28 but there's only 24 patches in
this version.  I'm hoping that's a typo, this is one of the reasons to
avoid trying to replace just a single patch in a series - it makes
things more complicated to follow.

--r/w8vo2lxBmCPGjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+xSIAAoJECTWi3JdVIfQxpkIAIUQ2VPwIG2Y7aM9Fd+6trCI
RdkamUaITj99Sv5aDAtQU2mpGMzmp1FVlgfm6AKuyRCTdoLAOJ4inA3MAp9M8xbP
VEs4HLyZXv7bibXq73swiTrMQ5HwvyDuUhiF6A0l9lbBsMzs1DnEu9zzIn4xUDNM
5ITl+/lhKgHm8l/GIP5Jx+czFX1ltqx3yg/7BJpaqZWlqet7ycl2AIdVDfVV67TW
nB/bvSu552WrD0NcGqgVbfmPdKqIrblXXkx6JzuWOJ29N7Ll0rUGqZcndbZEl2RB
oVK84u08SObZaZWZkgNhGST5ODh/vtadMaNJqjoZE09LBWGtYJ0kxNDcbRPJnvs=
=da4K
-----END PGP SIGNATURE-----

--r/w8vo2lxBmCPGjQ--

--===============2169326913722886293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2169326913722886293==--
