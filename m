From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 07/12] ASoC: Intel: mfld-pcm: add control for
 powering up/down dsp
Date: Wed, 13 Aug 2014 21:04:46 +0100
Message-ID: <20140813200446.GQ17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-8-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4586954049454491824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5CBA265593
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:04:51 +0200 (CEST)
In-Reply-To: <1407145563-1303-8-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4586954049454491824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="unZN0Zy24D52umEt"
Content-Disposition: inline


--unZN0Zy24D52umEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 03:15:58PM +0530, Subhransu S. Prusty wrote:

> +static inline int power_up_sst(struct sst_runtime_stream *stream)
> +{
> +	return stream->ops->power(sst->dev, true);
> +}
> +
> +static inline int power_down_sst(struct sst_runtime_stream *stream)
> +{
> +	return stream->ops->power(sst->dev, false);
> +}

These return values are ignored.  Shouldn't we be syncing out control
values on power changes?

--unZN0Zy24D52umEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68TbAAoJELSic+t+oim92NcP+QErXr7iIzAuhwskJc2fB2sx
yUyNjbdxXM/F8A5/dx2kEosynbrbS+5s9cTUBtj7/T2igXJ5P61Ts2FKs3iFYbWa
+N9hrkIkoTsg+9fhbOZU4PAUP+DA0Z1XWXjRNLt5T9i+au49MmFqSvFmm80YgcxX
N9bu7AEMjmwBRivrRYXiGxOPNeZ4wpqmr/JFtz0ibUKvrrG7P54gMN73KPQ+Iy70
N0rVTqYnT1vVbc09cjgzT2HSLGg+ViMuTa2Qge0m9qsJ3oOwIk0hX5fL0nk/E6li
tfPckEwe4Pv04Z4tRaF0xiq7pJbafDUUPP/f/j8yu7b9mj2FqN2KRAFl4Wsu7vxl
nQ6xgAo3jrB0LAnBeBvDKYkqO73B0g1FcOHJeSwb0zrWSOhfj0bmj91x1xKtg18P
8mhOImohzgljtYsuAAQC9A1oXvd1AG05DOZO3zBrddIeIpuy+fZj4UpRryqwCjpp
/jqyGoy6FTAX4xnLZijJ3Hll9UsU5Vvcdo8JHQfnL1r7xwWj4IFqH1FdTbSuNEgn
6zYHwd6Vqo48c9cStBDinjsvP/sWd5Ybf+7rinmkxfl5+ek1pUl7K7rFpSuejKqa
K5rGig4wvEIylMgaZxh7rmJILikB0YUUqlklO/4kRBbJbmIhxtS35fAxc0gLzHQ9
FMXqSwkM0IPxv5sNKDwl
=FwZ+
-----END PGP SIGNATURE-----

--unZN0Zy24D52umEt--

--===============4586954049454491824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4586954049454491824==--
