From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: arizona: Disable AIF TX/RX before
	configuring it
Date: Tue, 22 Jul 2014 23:22:32 +0100
Message-ID: <20140722222232.GY17528@sirena.org.uk>
References: <20140716121029.GA22222@opensource.wolfsonmicro.com>
 <20140722104206.GA19663@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5854638652442181381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E18D26555A
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 00:22:49 +0200 (CEST)
In-Reply-To: <20140722104206.GA19663@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5854638652442181381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j5abB2DrWbqmv6QP"
Content-Disposition: inline


--j5abB2DrWbqmv6QP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2014 at 11:42:06AM +0100, Richard Fitzgerald wrote:
> Changes to the AIF configuration registers only take
> effect when the AIF is disabled. If the configuration
> is being changed from the previous setup, temporarily
> disable the AIF.

Applied, thanks.

--j5abB2DrWbqmv6QP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzuQlAAoJELSic+t+oim9BboQAIveeqw4GRQCvQFnyR9MBvf6
htIWqvpbBWU48Z3fLLX5afA9TdSmwvD0wBToyTLS19t+tBk4YpGEUHcS6tuaU/8D
hR8w0iir/CTsm21LRCvkJGYNHiQ6TX5RgKSqXQBcz9tfYSbsuwsUwlOGU2KGEfqK
GSYltt4TIcYxTnVDcFAPzBK1xssZmgMi9QYgIxqRYXnV6HnAOPFv6M2HNAM9Gm5S
LJyN4dd94/LHpiwOMiabNr87daIINIiTa2xpSc3V9742xpwLh27fNnKR+ZQ6IhE7
qEAbvpvtGxpuuIFsZbdR/qeeRg46Y3mgyRupbV3yoSTqAv6uJc0BzkdPU8miKvfx
ropAw10Dt3C3fiNnwgzbbfQjL2zbZt+U+mDzzUCnI3gXazHRxfQ+NRfFHw8lWDMm
rHSTUaai229+XTkZfSoiEAwcB18/5h+BqyE3Sz+noWN1NvH+AiE37f76eaUb9qXi
431Vwn0o+pNsXU76PD4V5auQuu0ulfnamYqZaMG1ZqCfcRes7p6s5JLwFLXciR76
AaNvS9sAlaYR8W/fs44ROhiZiydExHZ4vTGyCkqr16gfsD2H86SS0ieFDWhfnyXJ
FGKWDq4hJmn2NLRXwIQJI8OWTY8xR727ZKbU6PTKw5TEwxMEP743o6356x8eBotm
busjhyV0dr7s+EZcVhP1
=USZ6
-----END PGP SIGNATURE-----

--j5abB2DrWbqmv6QP--

--===============5854638652442181381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5854638652442181381==--
