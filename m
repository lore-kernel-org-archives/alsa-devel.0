From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Mon, 28 Jan 2013 14:44:42 +0800
Message-ID: <20130128064440.GB5683@opensource.wolfsonmicro.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8416200986076496289=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4566C2650D1
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 07:44:52 +0100 (CET)
In-Reply-To: <20130128060914.GM26562@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8416200986076496289==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 27, 2013 at 10:09:14PM -0800, Vinod Koul wrote:
> On Mon, Jan 28, 2013 at 12:56:13PM +0800, Mark Brown wrote:

> > > How about:
> > > 	compr->ops = &soc_compr_ops;
> > > 	if (platform->driver->compr_ops && !platform->driver->compr_ops->copy)
> > > 		compr->ops->copy = NULL;

> > > That way you set it to null for those who doent implement this and would called
> > > for drivers who implement this.

> > We'd need to take a copy of it in case we have a system with a mix of
> > both styles.

> For the same device?

No, not for the same device - just in the system.  compr->ops has been
set to point to soc_compr_ops which is a static shared by all drivers in
the system (unless I've misread what you wrote above).

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBh5MAAoJELSic+t+oim9WOQP/2ain9lATNvNYDXak4W+hquD
de+iTPrB0a4ZY4lXwo6alQkqo9PnidwmozbhuuSO5KLIhNnfhxx6VmP1csxuFZEE
5Woen7rDYIbJMlAJ9ArqUgWhBfXWGHwMH9Zpk9/Pvxcz00Ew8eGW0LL1shvX3bu1
wuu6iH1kK+5nakdeypP7403PSuk7jLpIYembH8mbD3AuPOtoW68ORt94zYAfgnIZ
MixZokSi60u494uSpcnSTRFrIfdu4Kg383appDmA9dCtzkKxV0nQtZ/FTJ108yrl
MpJnPbrggh7YtCZrU4UzR+VaaL8oL5Oibb4dkt4PMsfrAhiEhj5nHs0ekydz5/+z
v7119Med0UMgceTdDEcp4VqNMOVb9BxKXB5nNvx/QNlCuT/WS4pOBnXIKXzJIwXY
1VmMSCbeST5LMGNVjhKcSH1ruoshaDQo28KTDUw70uY+6MDi4b24rYEw6QXVCouh
h6cob8YIzGK0S8md7xFllzRXACVgW28k7k2OilIgeINoR8uqmsVkaH79JniQa/v+
cRjiKf23OKm9CULDsZQXlna3VJpzviGUS00DsNE0na9doU5dUpGJYqAbDNLDqKrf
qEyJmoT0DJBSjer3oVxHbY2JHO5F+/nv6TvTq82ZGdaMwgT73NR8LyoUFNGgjftE
sGr5UZu9p/w2IDpJNpb4
=lI3T
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--===============8416200986076496289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8416200986076496289==--
