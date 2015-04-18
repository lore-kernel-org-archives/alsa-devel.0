From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: wm_adsp: Add basic support for
 rev 1 firmware file format
Date: Sat, 18 Apr 2015 18:26:03 +0100
Message-ID: <20150418172603.GB26185@sirena.org.uk>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1428928085-20250-11-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7451428344970285178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DD592617BB
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 19:26:10 +0200 (CEST)
In-Reply-To: <1428928085-20250-11-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7451428344970285178==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JyUo+2rKuw1VKSUr"
Content-Disposition: inline


--JyUo+2rKuw1VKSUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 01:28:02PM +0100, Charles Keepax wrote:
> Revision one of the file format includes new algorithm and coefficient
> blocks which provide additional information about the controls exported
> by the firmware. This patch updates the processing to handle this.

Applied up to here, thanks.

--JyUo+2rKuw1VKSUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpOqAAoJECTWi3JdVIfQLxsH/j4ExSbtLtu0D4KqqFIW6BUI
MAv/muz6sJOZChoDC1H05Jtz2S27jBABMXgQZ7jawH9c+mEo6eOULhTcn0usAIwA
875sdaV+Q/+0LZLcU14jnxD/FVabMxKloBYee0a3yE8tZrSMhXOeCOT/lq7ToNcG
jC4QsjaqAxOf0QJC4vuMJoMwi6kCfvk+V2fGNgJVSAtOreUy8fERknvxXXM3VT2q
61CseSyaswrO5PXaxqwAabNcs6OJr/cc8P4MHbhZiQuadl+Q8l6bX+DtMiys9iIB
bOeISQZ1TJ/TOCnyC7QlHNBE6ZeK6O/Cn0rYaTU9/CMdOfzlsP9fVbiIr0LuV2I=
=4KTb
-----END PGP SIGNATURE-----

--JyUo+2rKuw1VKSUr--

--===============7451428344970285178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7451428344970285178==--
