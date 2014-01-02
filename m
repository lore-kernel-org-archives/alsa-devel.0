From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/19] ASoC: kirkwood: Don't set unused
 struct snd_pcm_hardware fields
Date: Thu, 2 Jan 2014 11:53:31 +0000
Message-ID: <20140102115331.GU31886@sirena.org.uk>
References: <20131230204209.109eca01@armhf>
 <52C47627.9080709@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7314081736799551427=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF5A2616F6
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 12:53:34 +0100 (CET)
In-Reply-To: <52C47627.9080709@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7314081736799551427==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RHIbD+tF1+NVxQvu"
Content-Disposition: inline


--RHIbD+tF1+NVxQvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 01, 2014 at 09:10:15PM +0100, Lars-Peter Clausen wrote:

> This seems all to be very hackish. We clearly need to fix that DPCM only
> considers the constraints of the FE DAI though.

Yes.  Or otherwise make sure they get fed in anyway.

> The digital domain of a sound card can be thought of as a pipeline which
> mostly operates on one sample at a time. The samples have two main

> to change the width. What we are interested in is for which parameters on
> the PCM side are we able to build up a pipeline that satisfies all
> constraints of all the components in the pipeline. I think this can be done
> by walking the DAPM graph and collect the constraints associated with the
> components in the path (The graph walking only has to be done when
> components are added or removed). E.g. build up a list of all the the DAIs
> that are reachable from a PCM and then use the constraints of those DAIs for
> the PCM.

This is sort of the direction I'd been thinking in but there's a couple
of extra bits to consider here.  The big one is that we have devices
with constraints that aren't connected to the routing so just walking
DAPM isn't sufficient - for example, a constraint like "all the DACs
have to be in the same domain at the same rate".  This makes the
collecting all the constraints harder and routing dependent.

What I'd been thinking of was annotating the DAPM graph with digital
domain objects (registering a list of digital domains each of which has
some DAPM objects anyway) and then using the DAPM graph to flow through
both settings when streams start and constraints when we're trying to
figure out those.  I started implementing this but didn't get much
beyond registration.

> While we are at it we should probably also reduce the separation between
> DPCM and clasic PCM as clasic PCM is just a special case (static routes) of
> DPCM.

I'd been thinking of that in the other direction - moving things out of
DPCM and into DAPM or ASoC specific stuff so that the ALSA level PCM
interface is more hidden, making dynamic PCM less tied to PCM.  The
stuff with handling sample sizes rather than formats is going in that
general direction.  I'm not sure this doesn't boil down to the same
thing as you're suggesting when they're implemented though.

--RHIbD+tF1+NVxQvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxVM4AAoJELSic+t+oim9z6MP/1Mmp7/bBcTb9UoLaH671TX+
jiI/fiO6epy/kWMS7uNG2kE4TTdhD3zFiGx0AIHbnLdWMoVhMEz1OiFoUSddUXVs
8ymnz0fkteXhv0P29UNW4ZhfMWvHDRAqDlE9qcQIJYS/wbGZ4wx9vqYNS6ztE3s6
R1yy7GTfMf6JyroLNu1t3F7IXSojp2oNKpi2M0ZcRGiFQ30RdWysC5hMbQQndY+j
nHlDcaoZqtEXpmTG97+AsoBYDAPIikwszWlfqAcz2WfK+kgLGpIPbXvDzpuGLjGx
9HeDq5X2FjUHCdiauOSqJFXXuHhEL8Yuv+m1LZI8JByCNAQaBiXL5ZEsEpL31Ykx
+Q53/f+BW2ifZbQj4GeH0Y2DleU0d0jbgCIeGbbMBLkkC1Bjo7QtNJ29ZpXEZHni
ofJDMWEJAC+basIFKVBR+21KBctogbQV4zlrregeKOZspMrr5Pt/mc4ErrnLBGXE
s1rbAoouCXxYdu0135Wa8IVsFS/FLz1gWhi1lqCaIEbaLzX8SMN0wOj0ItOgxW9e
OrE7cka0GnAaKpeiTPeWdWLODNxF+bBDjdhEbjEQZnJ9PLIVCkb9HFseCaMYXwsI
4aYi8vEKARS4QDznpRfK5hZb1dos1bKoMYyWP8ZjtkndapfqinpXaDIIc3O34vZ0
1QSmxFICS0ANcVZGpok+
=E2sb
-----END PGP SIGNATURE-----

--RHIbD+tF1+NVxQvu--

--===============7314081736799551427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7314081736799551427==--
