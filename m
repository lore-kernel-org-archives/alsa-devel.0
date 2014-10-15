From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 1/6] ASoC: Intel: mrfld: add the gain
	controls
Date: Wed, 15 Oct 2014 12:49:47 +0200
Message-ID: <20141015104947.GC27755@sirena.org.uk>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7676964533516126171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AC5426040E
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 12:50:15 +0200 (CEST)
In-Reply-To: <1413356701-8535-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7676964533516126171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lWUKcCAfRi3dzL43"
Content-Disposition: inline


--lWUKcCAfRi3dzL43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 15, 2014 at 12:34:56PM +0530, Vinod Koul wrote:

> +static const struct snd_kcontrol_new sst_gain_controls[] = {
> +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),
> +	SST_GAIN("media1_in", SST_PATH_INDEX_MEDIA1_IN, SST_TASK_MMX, 0, &sst_gains[1]),

> +
> +/* the SST_GAIN macro above will create three alsa controls for each
> + * instance invoked, gain, mute and ramp duration, which use the same gain
> + * cell sst_gain to keep track of data
> + *
> + * To calculate number of gain cell instances we need to device by 3 in
> + * below caulcation for gain cell memory.
> + * This gets rid of static number and issues while adding new controls
> + */
> +static struct sst_gain_value sst_gains[ARRAY_SIZE(sst_gain_controls)/3];

The use of ARRAY_SIZE() is nice here but I'm a bit confused about the
divide by 3 - there's an entry in sst_gains referenced for each element
in sst_gain_controls.

--lWUKcCAfRi3dzL43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPlFLAAoJECTWi3JdVIfQyFQH/ib/zD/xtp/F5V82k8mGZ9KA
k9xMit4MXQfybeacTqsaXQ33/6+l2rXEmm+LGbEQn5KE0oskwkQR07iRh6vv088p
4bX0upCIsgwdAqISffLRuhH/nnjpPOgi3jgXoZjgYU9FnMdedbCxlMOAZD5bSYI/
KHlsDXVtM/lvMenoawcx+en+W4AeJvtA/GLgNmeeUi2jrXi8JXxLhNT2YsbiR4BL
MpOtw2jxmTN+ay9CeukdyHKgnZK4AeiCkA2m6Tj9AhEvpYW90/3Q+2igiQzUEXCj
dNqQHLtn4vjjkHzzqOYJ3YxcuvAB1uPnQTJwGW5+72T8a0t6hfZraAHgINADoYk=
=sTQv
-----END PGP SIGNATURE-----

--lWUKcCAfRi3dzL43--

--===============7676964533516126171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7676964533516126171==--
