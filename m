From: Mark Brown <broonie@kernel.org>
Subject: Re: wm8960 sleep time is too long when system suspend
Date: Mon, 2 Nov 2015 11:16:26 +0000
Message-ID: <20151102111626.GC20228@sirena.org.uk>
References: <20151102084402.GA7603@shlinux2> <20151102091855.GO10520@ck-lbox>
 <20151102104921.GA4769@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170514415580706468=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C672614D3
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 12:16:33 +0100 (CET)
In-Reply-To: <20151102104921.GA4769@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8170514415580706468==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 06:49:23PM +0800, Zidan Wang wrote:

> Some customer can't accept such long system suspend time. It's better
> to spend less than 100ms for system suspend.  Codec suspend is a part
> of system suspend, so it should be less than 100ms, and as short as
> possible.

Users need to be realistic about the performance they can expect with
older devices.  Systems that need fast power on/off times should be
using ground referenced CODECs, fundamentally ramping VMID quickly is
incompatible with avoiding pops and clicks.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWN0YJAAoJECTWi3JdVIfQF5YH/27s0ijBtMp8a5oRESj939Gh
e+BRJTbiPxYfaLU9cF+TZJnpIhGovmvPhMK8UXkrH95H533bevUhJEvXKnTKzTGq
zY91PXbZ+WgzfzCTg1d6nwKxOxeIFVzoRXOIsxY+CQlDiDgojowDmv4bzMNxmZkr
EY5YVVtE/Msn+yGSJS4oOkPj90+g4wEbfuqFL10bM3QrGd4FuroIbCBlFvxxttog
/PZIEu/DxznEwu2iqH93L5LRqEww//GzXj3xGTAMo7KvNMqLazelwsjA+7winUPI
TBphzZojjW6MJ3TFrGAv8uZqkvUeX/Is9bYGJW4EYrfsORzg0h4NVKD7VMYPE1g=
=Cn2+
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--

--===============8170514415580706468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170514415580706468==--
