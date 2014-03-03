From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Reorder the bias update
	sequence
Date: Mon, 3 Mar 2014 12:48:09 +0800
Message-ID: <20140303044809.GM2411@sirena.org.uk>
References: <1393689843-22916-1-git-send-email-xiaoxiang@xiaomi.com>
 <1393689843-22916-2-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7908397161426995767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 043642654D5
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 05:48:27 +0100 (CET)
In-Reply-To: <1393689843-22916-2-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiang Xiao <xiaoxiang@xiaomi.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7908397161426995767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vR/vnstCraLpx+OT"
Content-Disposition: inline


--vR/vnstCraLpx+OT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 12:04:03AM +0800, Xiang Xiao wrote:
> The new sequence ensure that dapm_pre_sequence_async work on
> the card before all codecs and dapm_post_sequence_async work
> on the card after all codecs.
> So the machine driver could utilize the determinate sequence
> to do the gloabl setup and teardown in the right place.

Applied, thanks.

--vR/vnstCraLpx+OT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFAmGAAoJELSic+t+oim96lkP/0zBOdCXkeEUeIVR27EoEerj
tTFFxnGyNOsoZFtjheILDs1xysPEawG/72wlceFrhbpP6NapwgUefTPnnkl7TLuY
q5/CsDUe7IsftSKQ84z90ZQ0zTPaHe19jgADRZ7h3IOu+c5SSvpbkJxxyhMbPdgq
6F+iTe7VtzzRUOteStAjgXFRU9FQIS0FA2/my9W4MXbHnOztO2IglJc1nJNINxtC
tOyZBn1Axs5j+kYd2obEvW1rQgauL17Nvg38d8Arc+QG4FAds1bpICo3fVASNkbo
HhiwnT4ch2TvsJqCFZtwu6+kyuuNZHJvLQqswbcgj++k/e+ePO0VOLxEWSGHUmnE
6bG5AD+dgkf3NlHC6v4h4pbOKfiBUVyoW02A29YZzdEsqvP9xQnzkJF5PTx8cPVx
IT53FjtexHD4sxFT5XrVJWhnTX9dSoK1Z9WJet5di0dUJ8LZyXH6wLHcTuRkEBf5
IZT4Q4xswqCHvjMUG9U1qhybTcm7qRLhSK0Qsn/PcD8glKQ3rdnAm+VPO6S01lwg
P/EvCmIV9ffAdsPvjNe55Z5+xaRwyORZw3TstF7ioOZo/ZEwu3YyrQ6+9hIW4N4h
4AE/oVD6wiifSQZwjbRVjsjLsePYu2cmbiUskaaBJQBQfF8CGSV7/Q6xfLNegXOE
CHn22TBSQgMbuYebbd4Q
=/2td
-----END PGP SIGNATURE-----

--vR/vnstCraLpx+OT--

--===============7908397161426995767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7908397161426995767==--
