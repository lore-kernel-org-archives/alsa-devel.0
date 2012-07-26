From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC
	for Device Tree
Date: Thu, 26 Jul 2012 15:28:26 +0100
Message-ID: <20120726142825.GK3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <50114D71.9060700@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7488254356360093544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3468E265B44
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 16:28:25 +0200 (CEST)
In-Reply-To: <50114D71.9060700@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============7488254356360093544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ry3qE+viRNtbc3l7"
Content-Disposition: inline


--Ry3qE+viRNtbc3l7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 03:00:17PM +0100, Lee Jones wrote:
> On 26/07/12 12:50, Mark Brown wrote:

> >Yet again no binding documentation....

> RFC. ;)

> I'll write the documentation when/if the properties are accepted.

No, write the documentation.  It's way too much effort to reverse
engineer the bindings from the code.

> >>+		default :
> >>+			codec->ear_cmv = EAR_CMV_UNKNOWN;
> >>+			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");

> >The platform data code picks a default, can't the DT code do the same?

> No, I don't think that it does? The original code returns -EINVAL
> unless a value is specified.

The code doesn't specify values for the enumeration so it ought to
default to EAR_CMV_0_95V if nothing is specified.

> The original author is keen to have a clear error message in case
> users try to specify non-exact values. I'd rather we fail-out than
> use incorrect values which would be a great deal harder for a user
> to debug.

By that argument all the properties should be mandatory but it's only
this one IIRC.

--Ry3qE+viRNtbc3l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEVP/AAoJEBus8iNuMP3d4OAP/3dSjzRTMkWkanupN3zmIKS+
20DJ+p7U12apePR7+fXAUi3uJn5htRClpwJymyYNPTIcd0Q55647dqxOF7PX8bmt
pOBAeSyMbTBr05fMuOlp3YzOnR32c7/nO80100x8K8oJ8+oC7wS3xnlVrAermTiq
2EwE8PlFRuLVB58ROttdxzmORyxYPgyaon9UH9MPSTW9SmA1FkSAIEp13bojx3V9
TAuA/g8ItWPTW7vjCPytxBmH/wshwoI9SaIM/OZRLIGVDc2De7XYDla1uPa0Joy2
boxyB791GYs05hhGK8xKpkyDPtdbRyQNdYFZuOUIPf4X//bnHyOFEZFCxB2qW5+h
xhFFmlV4x/GpMNTZUyQe4xNTXiscCOw+zexu1r8uTi3KpyHoOzdel1H5pJV3jgFr
GMBAH+Vkz/7FubJ91lh2eOu7s4dL5C1JOR4IFMoym/SJk6f6HJM0W6sD8krFpx6U
aMoL52g+BnTm9/boB9rqQd75cMbbnmLF/QM/D6sDzxE3mV6QQtDV1eCVjE/RIw6+
HwXbKiSbTZgiAHKfJcumcs1ws+N+9NE7B9OZqi2MhvXWzrE1hxF9qU1tpl0dfYy3
ujncSTs07vN6UuIW3ymdAF3YmQNBa9rHoIQ/kD8NR/vwABTnbrAHixOa+/fm0IAZ
u7YBVktNDnjWCm2QFRTn
=0Ho6
-----END PGP SIGNATURE-----

--Ry3qE+viRNtbc3l7--

--===============7488254356360093544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7488254356360093544==--
