From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 03/11] ASoC: Intel: sst - add pcm ops handling
Date: Wed, 27 Aug 2014 21:29:14 +0100
Message-ID: <20140827202914.GX17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1610655915439988826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 319A426587C
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:29:32 +0200 (CEST)
In-Reply-To: <1408625450-32315-4-git-send-email-subhransu.s.prusty@intel.com>
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


--===============1610655915439988826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wpFWvLGqObExcNe+"
Content-Disposition: inline


--wpFWvLGqObExcNe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:42PM +0530, Subhransu S. Prusty wrote:

> +int sst_stream_pause(int str_id)
> +{
> +	return -EPERM;
> +}
> +
> +int sst_stream_pause_release(int str_id)
> +{
> +	return -EPERM;
> +}

Shouldn't this be equivalent to just not specifying the operations?

--wpFWvLGqObExcNe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/j+XAAoJELSic+t+oim9aSMP/1faHVXFbcgQq5CNfHirqs+/
5Z2oHf9gErlIxU9kNT75KWjx1nNKuuPKbK36nSWBZBmo9PzC9LBvLotNVf7S0jjw
khIgyLg3tndsFEMCSV7PZc51Qja2t7AdJqldtKuVVolUN8rS8weN1hefYSS3Vq+7
mDnMD4IRRYx49qlkxAy4L37c6Yv33o+1VztXRjHcgT0FHB+dyp+J7NF0ygqfXhET
tf71qT0D5UVfFNT4vbo9Oho7tFB3yfID7W473wK6JljPTSFLGf+u3J9v/IUxvpYE
Mxo4lGM65P4TFm38r1mpY0mMqnJJTuq9uOHggRQHHZMs3TyCy2ERwCJVxQHx2ckS
Z625nG/AqrYVE9DTTnMhNjSrNBCcUZlAn8w/20WfRkvb3Q3W/59utKl8Po62Mc65
khiZDaBVYoWzVI2t9gJsPKn9KqFReduN601uYxnrerDv6kCrQdmaQZ5cdcAb7Dz3
ZHyXt9HuHTPbzN5ZiC8Z3hVDp0NVK7Mx4l1sT0LZLJwCw9WycxeGdX1wyO/EJgDA
FIbD9UteeLwpaPUK6scIGlmVtUluQ4zMEPo4KnrddQtg//mEkCacJ2o5JgVp0TE0
VkuxbTheXWivd0BhfQ//3SgVYu1M8wF6sQgvfgN8K7DsEiX+lp7JnsasjOKFHq5o
FAGT1Kr9cmjasgWlGtmA
=Vo/U
-----END PGP SIGNATURE-----

--wpFWvLGqObExcNe+--

--===============1610655915439988826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1610655915439988826==--
