From: Mark Brown <broonie@kernel.org>
Subject: Re: Using simple-card to replace kirkwood-t5325.c
Date: Tue, 15 Apr 2014 23:29:02 +0100
Message-ID: <20140415222902.GI12304@sirena.org.uk>
References: <20140415161302.GC1871@lunn.ch>
 <534D7D31.6040802@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6910071790293106411=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF382260799
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 00:29:21 +0200 (CEST)
In-Reply-To: <534D7D31.6040802@metafoo.de>
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
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: alsa-devel@alsa-project.org


--===============6910071790293106411==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQAkT9kf8uI42z2+"
Content-Disposition: inline


--dQAkT9kf8uI42z2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 08:40:49PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2014 06:13 PM, Andrew Lunn wrote:

> >	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> >	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> >	snd_soc_dapm_enable_pin(dapm, "Speaker");

> I'm not sure where this got started, but this mostly seems to be
> cargo-culting. External pins are enabled by default, there is no need to
> call snd_soc_dapm_enable_pin() unless snd_soc_dapm_disable_pin() has been
> called before for the same pin.

It started before I ever started working on ASoC.  Sometimes it's done
for documentation.

> >It also seems
> >common to disable pins and to set them to NC. Is this a generic enough
> >feature it could be added to the DT binding?

> We should probably require that the DAPM routes and widgets are always
> completely specified. In this case the fully_routed flag can be set and
> unconnected pins will automatically be marked as not connected. Although it
> might be too late now to require this since there are already users of the
> simple card out in the wild which may have incomplete constraints.

I think we can do something like say that anything that specifies off
chip widgets needs to fully specify.

> >static int t5325_hw_params(struct snd_pcm_substream *substream,
> >        	   struct snd_pcm_hw_params *params)
> >{

> >This seems a lot less common requirements. All the Marvell SoCs need
> >it, but not many others. So i don't think it makes sense to add it
> >directly to simple-card, otherwise simple-card quickly becomes
> >complex-card as everybody else wants there quirks adding.

> Maybe the drivers can be reworked to not require this anymore. The CODEC
> driver may be able to figure this out on its own.

I don't think it can, that looks like the CODEC MCLK being supplied by
the SoC (it's nothing to do with a requirement from the SoC really).
Ideally this would be handled through the clock API but that's a bit
fail at the minute for architecture neutral code.  It's a bit of a hack
but specifying the ratio in the DT (which I thought we supported in
simple-card already but don't seem to) would sidestep the issue.

> >Has there been any thoughts about turning simple-card.c into a
> >library, or adding hooks so that a driver can modify the created
> >dai_link structures to add in ops like this?

> A few of the function that got added for the simple card are already
> available as library functions in soc-core.c. More can probably made
> available to other drivers if useful.

Yes, that's the preferred approach - where it's useful.

--dQAkT9kf8uI42z2+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTbKrAAoJELSic+t+oim9ZksP/3fF9EPr6nubHJVwrSAzCEbC
DcnBtivbcECGfiDywLzu8SqTv8CTcgHAMB5IAFglPLAErDVD18C8Fq7+QpsZtoPE
wEsheEMtfCBH2g7a1hfB+zKzrUcFMUueq8z96WEmdNibZN+rOV+jqX0FKJkWzRv/
JccxGuKTR+3D+95U9ztCG51JxvTJtRmkAo5KRIY01+KQBYDqJOgdYuC9QICkunoE
UE0Hv58skXvsiLK5r4yLu7VM050oeV+e9CAXWUfnKzPQ/sxjtSJSLPSVudemXmPS
4MT2WcbQLu039kiO20dcwIOU8kutgp9x0Harz/4xYhlnnxeFKikpVjoAfAhE0JKA
OEwQPWCWEt7G8T27TSm6QRhk/1c2Wb+vj9XYS6HFrW316+rqfplmn/gpQBwV6/mT
BYw167PnF1tXo0MuPk24g4rVCUVdWEWoQ5c0mBsvY0MZdCq3w1zTmrGuiB5DhIus
qUeCuF7hhbzqS42xp/GeTEbcomqIP4MLElieLyJzISYk8sCbuvdGdaCxdUeBNmkD
lMOI2j/1p5qAuNuAV1FBpbA3VYCxIbAfz4m5EDQi66kAWRiUYuaC252PYggUEVro
VS3rA2FwN6iZ+5yJc3I+Z+EJira57LgIx60Lot+XzJnRhUSAy40n25+Yj+hCq1/7
nj5V1h91JXkufZxcqCbu
=vjo3
-----END PGP SIGNATURE-----

--dQAkT9kf8uI42z2+--

--===============6910071790293106411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6910071790293106411==--
