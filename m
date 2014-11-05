From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:rt286: set combo jack by dmi
Date: Wed, 5 Nov 2014 17:23:11 +0000
Message-ID: <20141105172311.GF8509@sirena.org.uk>
References: <1415164166-15512-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1623546135762474809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D11062606E0
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 18:23:32 +0100 (CET)
In-Reply-To: <1415164166-15512-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1623546135762474809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2014 at 01:09:26PM +0800, bardliao@realtek.com wrote:

> +static struct dmi_system_id intel_platform[] __initdata = {
> +	{

This is fine but can you please rename the variable from intel_platform
to something more meaningful like the name of the reference design these
are derived from or something?  That way if we need to add some other
quirk (and I guess we will) we won't have to rename this table - I guess
anything that's using a DMI quirk will be some Intel based platform.

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWlz+AAoJECTWi3JdVIfQDBgH/06RPr1cjchUK2BqyyKM5rPF
vdLNm6hTjyEVWmv6eIoSt9Wj1r8og+PmMs5jPe9y6Ntr+QSPwHanCh/j/hfV8Ahg
03N50ntXfUpW5k4DI+7tNLu5G6iRzQ1VEcW3lHDo02VargmVN1qK3/rvj4Sf9xrm
SPu1knztLZGUI9fSeQqKGsg3XnA39HULQMWpjGGc7nXob0f7buUImjzzBAWAprkI
4QNS6RtrO7uv+6EcKLe4BLBZME7k5U906xgXnTuAdUOfsLLwBuG25dywVwlZFvYN
kqEUwu08XtBFB9M/Cy0RexF4NGqKtDEREX1Kc1DTnamITOwsbKu8JtVGBoUpvp4=
=51gK
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============1623546135762474809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1623546135762474809==--
