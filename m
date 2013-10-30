From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/9] ASoC: max98095: Add missing negative
	channel checks
Date: Wed, 30 Oct 2013 14:31:21 -0700
Message-ID: <20131030213121.GN2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-7-git-send-email-tiwai@suse.de>
 <20131030164653.GG2493@sirena.org.uk>
 <s5h61sek6ei.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4677801994305567403=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6662616E9
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 22:31:48 +0100 (CET)
In-Reply-To: <s5h61sek6ei.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4677801994305567403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 06:36:21PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Wed, Oct 30, 2013 at 08:35:04AM +0100, Takashi Iwai wrote:

> > > +	if (channel < 0)
> > > +		return channel;
> > >  	BUG_ON(channel > 1);

> > This doesn't seem to fit in well with the adjacent code - the handling
> > of out of bounds data isn't consistent though it looks like they're both
> > doing essentially the same thing here.

> Actually BUG_ON(channel > 1) is a pretty stupid line and should be
> removed.  You'll see that this never happens if you read the code.

Yeah, but then nor does a return of less than zero...

> Overall, this driver has way too many BUG_ON() without
> considerations.  Such BUT_ON()'s are worse than nothing, IMO.

Yeah, I'm ambivalent.  I think they're not too bad if it's about a
fairly small part of the driver agreeing with itself which is the case
here.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScXqmAAoJELSic+t+oim9SZ4P/jPQQ/eqK3QDYVAopirvLXXy
+ydyNiOO1LH3BilXLI3ircwUcvILSVLwLr/8JIL7kfVkqyzxf7wvymmLsYQop7J0
FuZfr/ZM1GvEdSTZLflqk2kTfK8pdNkMaGglDUtd5xY5D78fqfGOiJH0M5U21b3T
/w9yJI+u8COq4iG780q0/hGaauOpYFEOXMY5FqnZ72oGXL984rWvnhcz6qzjeMoS
YURSidMRDOemf2Si1e2ZJW5yrFVF46P4CwzegihwzOef/c+LtospqAgNliqNadap
kc3aNmBtsiwp/74Cu7OnLmCidz1SrF/hiUIaZjiqJSPwM/sh7pxSV3Vt24/eEodx
pv2kpcZeaoE+4WGOokmEhtDsJ7taYI/04AscGWtohQGeCg9ZRtn/XWcY6zlnPm/T
76N1h2RI4revc34W0hNlSKb5VBSCdllE2KJ8psjVhF5tAQkRBYc2qIEbZRCcwXOa
F6Db2ecdpcLYv1nx7Wicpu9doiBmd60GNAU6hJQdf3rn3b1dBnUecJS+V7kP5wlU
+OTWpI6Va5+35Wbg+nMcisiHK8Gf/oDD8EX4631fbcgnEa7LsFLJCWwNMFSR/vyW
DbFayHM+hzpBhuZ8BRd3KUuNHL1GkKXyFxXKYT2idc1HIU9q6MOsSlb0szYSUiGA
tELlct7rGjJuaVbMjQiX
=VBWh
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--

--===============4677801994305567403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4677801994305567403==--
