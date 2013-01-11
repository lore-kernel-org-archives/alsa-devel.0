From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual switch
	controls
Date: Fri, 11 Jan 2013 12:45:35 +0000
Message-ID: <20130111124535.GZ20956@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
 <1357833977-3682-2-git-send-email-lars@metafoo.de>
 <20130111121912.GY20956@opensource.wolfsonmicro.com>
 <50F007DF.9000606@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5297508655762468894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94797264EBE
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 13:45:37 +0100 (CET)
In-Reply-To: <50F007DF.9000606@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5297508655762468894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ufMBWnG1WFkAvCRz"
Content-Disposition: inline


--ufMBWnG1WFkAvCRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 01:38:55PM +0100, Lars-Peter Clausen wrote:
> On 01/11/2013 01:19 PM, Mark Brown wrote:

> > going to affect everything else in the path).  I'd expect to see
> > something like this implemented by having a control that has a specified
> > value forced in the register while the control is enabled (kind of the
> > opposite of a supply).  This is a fairly common need for older parts
> > though it's unusual to see it on a new device.

> I think I want the opposite of what you just described. I want to be able to
> overwrite the control setting based on the power state.

Right, just a thinko though - you see the point though.

> In ASoC I modeled this by letting DAPM take care of mute controls. E.g. the
> mute control gets disabled if there is an active path from the DAC through
> the mixer to one of the outputs and gets disabled otherwise. This makes sure
> that when the DAC is powered down (when there is no active path from the DAC
> to any of the outputs) each mute control is also enabled. The virtual
> switches now allow disable a path from the DAC to the mixer, which in turn
> will cause DAPM to enable the mute control. This is similar to how the
> virtual enums already work.

Virtual enums do actually end up routing, that's not what a mute control
usually does.  You can do the above in the manner I suggested, just have
the register forced to a particular value when the DAC is disabled.

--ufMBWnG1WFkAvCRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8AliAAoJELSic+t+oim9hAoQAJ23prg9XoQpFog4Nh2V8kBD
mKVXBCwP49swgM9GWa+GgQUuCaNDdojr7AfoV8k4GYf7AIJCT6CAFaFS+jEmVJNF
F924ObCN3b7ZbwzsJao5xJiu0QoClsRj/nrMAfa/MfUvfvCLgA0WR1cQ1116dfid
xf43yCTBmcFt4xESyK1ITgnYYh/53jjzpwkiiRGbMhynCNpop0JqwtAyAsfDl2Te
CrjEwNzK3SdXm91tGHb/V8+qL6z41NpW9xcNNwQqAobYUbPLLkG1xZA98gDIVqZi
mtIH5W2Br43SsQomjQhlajK5YYTbqGV2Zg65aqU+pPHmeQRehmRse8schtjw+CYX
Hh9veK8H+xEG0gCpgNgBo8t+JFqv2NROsqNU7gwtwJmcsxVCAmJWUs5rtMn6rQls
IOYejvYAtGHnE7MbFfA1i/mGalMuDwWZoXUaCQtPi1BMLSw3/fqtn8JqSMwBLnG+
lcCxHLKskoMt967qhYHuEoj5sPrbXoaN+7y+HOTjLV5/YYTTIGZrxxCoM+DsjNUy
TCi3NhTG02uoMbRKJ5dkSqZWSWvzPtkrOGZMAGT96oOq8vRw8D7exCrCm7PAedOO
tVJgodq6w2PM790KD67k51jCZ3DJdbO//FPK3kADKaaJXefbihmx4RI3TKvWmWCO
MwqbcsjhPkqhwrQTKrTQ
=A08F
-----END PGP SIGNATURE-----

--ufMBWnG1WFkAvCRz--

--===============5297508655762468894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5297508655762468894==--
