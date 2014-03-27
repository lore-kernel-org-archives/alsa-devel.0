From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for multi register mux
Date: Thu, 27 Mar 2014 01:29:13 +0000
Message-ID: <20140327012913.GC30768@sirena.org.uk>
References: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1528878034484665630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AD526517E
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 02:30:06 +0100 (CET)
In-Reply-To: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: Songhee Baek <sbaek@nvidia.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1528878034484665630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 05:02:35PM -0700, Arun Shamanna Lakshmi wrote:

> +	}
> +	if (!match) {
> +		dev_err(codec->dev, "ASoC: Failed to find matched enum value\n");
> +		return -EINVAL;
> +	} else
> +		ucontrol->value.enumerated.item[0] = i;

Coding style nit: if one side of the if has braces both should.  Most of
this code could also use more blank lines.

> +	for (reg_idx = 0; reg_idx < e->num_regs; reg_idx++) {
> +		val = e->values[item * e->num_regs + reg_idx];
> +		ret = snd_soc_update_bits_locked(codec, e->reg[reg_idx],
> +						e->mask[reg_idx], val);
> +		if (ret)
> +			return ret;
> +	}

So, this is a bit interesting.  It will update one register at a time
which means that we are likely to transiently set an invalid value
sometimes which might not make the hardware happy or may cause us to
write a valid value with undesirable consequences.  I'd expect to see
some handling of this, some combination of providing a safe value that
the hardware could be reset to prior to change and doing a bulk write to
all the registers simultaneously if we can (I know sometimes hardware
has special handling for atomic updates of multi-register values in a
single block transfer).

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTM37mAAoJELSic+t+oim91JwP/1O6HzKdLQzCV9TXiRiLE+9B
faDk5xuDbDHYD9btV0YExWP1iKnmMJBQ0E6X8+3pq2yPkLEcUBbAuPm3NClH5KTR
hlnQIg8M8Ypssnh23x57/4+VKcIpMFJdr+wAlzCFMae0bPCSifxfwFaIutfRS3i2
5EPckDHI6yAERgVYBiudgK3MqAG07o5UnIC6DEKybgL5cseABNj21d1XE1wkhIKR
yeMAazWddeaA8gADPD2rP+gKqWojjEqNbGpkm7JXx3T/YRF5dhu2mbjqwzC2YHP1
iLzPd6+XiKNyK6MN6/sPBh3AEN+xOGNLaKr4lLRBG89VPS7wSmapOhJuyAZtLaLq
R/xVa56X4CXpVBZX9ML0eQvJFjSEuNIlBTxcO2692yt6xOD9oKN8CIzdprwdaYYW
c89E5HKuPCseemNlT9DPWNFSPnOUL0WiEaY0+hR/YSzCzqa31oynJmfo2wHzu75I
6NMIHX1KsVAZ3QesD0a2IxPO7pDDYFbnnJ3LkQ1OicNIc0rB3VeR9mFedDA9oxjH
mJOd6PH7OOj0DUQK2Uor7DoX1W69TqNzYx4AKCVipUtXBSPlNljd6xbV0BPyTN5O
vA9UP1Vi1m3RXf9LVHRaLt7vfVOlV6gPCqOWRKyQR76338/ohgmW7yDkq4oKpsmC
4HUKiQosoQi1qAZhXguu
=LJ5n
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--

--===============1528878034484665630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1528878034484665630==--
