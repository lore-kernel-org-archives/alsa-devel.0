From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive exception
 handling
Date: Tue, 3 Dec 2013 18:22:56 +0000
Message-ID: <20131203182256.GL27568@sirena.org.uk>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3073849919447794378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A58265200
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 19:22:58 +0100 (CET)
In-Reply-To: <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: vinod.koul@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3073849919447794378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2AePNYCLzMTyE/xc"
Content-Disposition: inline


--2AePNYCLzMTyE/xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 04:27:55PM +0000, Charles Keepax wrote:

> +static void sig_handler(int signum __attribute__ ((unused)))
> +{
> +	printf("Interrupted, saving what we have!\n");
> +
> +	finish_record();
> +
> +	if (file)
> +		fclose(file);
> +
> +	_exit(EXIT_FAILURE);
> +}

You can't safely do most of this such as calling fclose() from within a
signal handler, the set of functions that are guaranteed safe is quite
limited - see signal(7).

--2AePNYCLzMTyE/xc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSniF8AAoJELSic+t+oim9WmcP/1bQl/RWjJJ7ZVUXiB6SdpKs
lCaUxV0tV2NqizNKUzXc6yEKXTzIRn7PDcGBTw+qtZBZmv1DHqgjcNVl5Ot1yYEj
VfYh0PVgBs8m86hUBdAMtw0xkev59B+GQiZKI887WHxq2DF6wbPyzI0xpe96soSQ
FDVSvv85/YGoMkVyIJDeRBGDwJIB9nycwzEBJMjtPqEJUBsigjtkjwiBUqu8URQ9
yPXA8AxR0BtAUm3i3QdL3Lc0Coxq4XO5RNELTHmE+XSAf14fYLqjtkE6si7TUvGD
ekRgYO3f+tL+1vUCjldnSGLH7kf8p3/DF9GJ717t1o9qWAoZlC+xzqfDK9vso7V1
sLpmE1Ra2QT7sbmMgrhg10KGjaPmTl9fb+vRPiCzE2mfXa4VaYBV9RgnV9uAwJPI
sML8B2bojWzjEpTY2GloOxBqY7yMw2haZFFbdgr8onPrmgHrFUVwl/WJZguUbL3x
i2Oi9k6gGVIJUyOeCH6rXWj3tCfI3mBX+kmPSn+cvhTwAiQM4FGLyFX7VCOyBWcV
gpTPElTcIc6k9eU6OhzLrWcsgELbJVy55/A7wt4heDpcF+V6O4ZNEBwx4LmwGiV9
5kUv9KLDTV+p4pUchYY46zeILfyN9hYmI7lzGIC8gi7DhOEU1og3ENC51BP+dweW
U3od7rUS//SSWJ033x9J
=UyJL
-----END PGP SIGNATURE-----

--2AePNYCLzMTyE/xc--

--===============3073849919447794378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3073849919447794378==--
