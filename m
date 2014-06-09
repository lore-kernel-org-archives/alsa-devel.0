From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5677: Convert to use
	rl6231_get_clk_info
Date: Mon, 9 Jun 2014 21:17:24 +0100
Message-ID: <20140609201724.GU5099@sirena.org.uk>
References: <1401764201.15216.0.camel@phoenix>
 <1401764288.15216.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7358032916962591560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45BEF265739
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:17:40 +0200 (CEST)
In-Reply-To: <1401764288.15216.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7358032916962591560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HR4ti3j4RKbrMpBw"
Content-Disposition: inline


--HR4ti3j4RKbrMpBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 10:58:08AM +0800, Axel Lin wrote:

>  #define RT5677_DEVICE_ID 0x6327
> @@ -2798,21 +2799,6 @@ static const struct snd_soc_dapm_route
> rt5677_dapm_routes[] = {

Your mailer has corrupted this patch by word wrapping the line above -
can you please check and resend?

--HR4ti3j4RKbrMpBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhZRAAoJELSic+t+oim9IpMQAIglvTHA+8QDA3IyauOKL/4M
2tslSKuH8RxNEmUMwCkTZt/BVpOKWLNqIWolZ8pp+rf9U/QcuEExGbrKE0Hg3Pb7
g0Gg/rEjWly2W+UUcqg4eTQ7MxdALzoyt2hpxOmfE8mtqaU7sD/KQ4QPLpBQMYoS
fkFwXq6KobnpXnkAMJJmcJyeOzK6fTl6FLVHlS65GyfijhdwKBcQsVGUptymfxyF
DyX9NKkF81rfrBAL5uJUkfeC5qdKUOq45yzuPFSPYBi7bUmtl63r00NhYMscrdLT
jlWwYy+TbEANvfrCTyMZxlCsBAbw6PQ+wa+y8MHc1PQGgsXLil4QH2t0o9KY2/61
K/VOl5IBevsKGGAKyKvFNSUKHwCqPjH+aQd2DEH/OgcFklHQW7+X5xCyonsOpyYR
+dfrG0ibsEV3ON8Hediri4Lcqv4GZf4W24qYJMFYwgiAeig3bCUxQRXi+GXsuAtU
GFOvN2wgSzdOTx/+ptZmJy5i+Yc7H8N6YfTkivMY1t9tPldGquSZkMeJ6lYeGJHJ
p6jpzucQGbMw9YpB8sFFY6wSkDtAHeHuKBYBlPzi6CIvZE6S3ywzbfw8whjEdxjf
IT3w1uneak0Gsg4EcHYPXqXMoTogJYhNcqJuiyPTVA9EastEONOUo4ENbYVkRUmT
ltnH6A82jrKQ6tGI1JFI
=/Axe
-----END PGP SIGNATURE-----

--HR4ti3j4RKbrMpBw--

--===============7358032916962591560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7358032916962591560==--
