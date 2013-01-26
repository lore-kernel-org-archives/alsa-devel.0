From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 002/002] ASoC: Replace max98090 Device
	Driver
Date: Sat, 26 Jan 2013 15:12:54 +0800
Message-ID: <20130126071252.GG10580@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F403@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F4C7@ITSVLEX06.it.maxim-ic.internal>
 <20130125072131.GA6403@opensource.wolfsonmicro.com>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F4CC@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8976173323678817321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8F532616E4
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 08:13:01 +0100 (CET)
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F4CC@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jwong@jwassociates.com" <jwong@jwassociates.com>
List-Id: alsa-devel@alsa-project.org


--===============8976173323678817321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2013 at 07:39:45AM -0800, Jerry Wong wrote:
> On Thu, Jan 24, 2013 at 03:28:54PM -0800, Jerry Wong wrote:

> > This is an odd control that is a combination of an enum and a power
> > management widget. The 0 value of the enum  turns power off.
> > Not sure what is another choice. The enum value needs to be
> > saved so it can be restored when DAPM turns the control on.

> > That doesn't appear to be what your control actually does - what happens
> > if someone writes ot the control while the widget is powered down?

> It stores the desired value for DAPM to use when the widget is powered up.

It looks like it's a SOC_ENUM_SINGLE so it should map directly on to the
register map?

> > > +static const struct snd_kcontrol_new max98090_snd_controls[] = {
> > > +       SOC_SINGLE("MIC Bias VCM Bandgap", M98090_REG_BIAS_CNTL,
> > > +               M98090_VCM_MODE_SHIFT, M98090_VCM_MODE_NUM - 1, 0),

> > > Why is this a user visible control?

> > It is not controlled by DAPM. The low power function is taken care of by
> > /SHDN\, so this retains the user choice of bandgap or divider reference.

> > Why would the user want this choice?

> This allows the user to select VCM Bandgap for all their references (higher power
> and higher audio quality when in use), or divider reference (lower power and lower
> audio quality when in use). /SHDN\ prevents power drain when either is not in use.

So in that case I'd recommend doing something like making it an
enmerated control which makes the tradeoff clear.

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA4EAAAoJELSic+t+oim9Wa0P/iM+epTiasyUT4ccah1ik0ue
AU41El8cEcSe+yssEnPKfwPmv2/YuaTDZPO0sltHJWtuNkWwyS6jNgSwjZoy1+BE
qMOnB7BT2mAVn7wroifI51hJmsjERU7z+ERklGLj2sn/ppQTNDBpJ85RjBWvnMEV
KQmHJV9+jrVwRIzi55DXUvpcycf/rvDf/2ie5AyxASpoksmjp84iUlbsWuAndR8B
rS67nFPCH8SeeVW0f+E+Ehy7+hSdnr1pXre+OQo4C/btg8BJK3ZwvkGTjtLd4QdE
kHZwPeDJFF3rCzIGNt+WyfMcGF/CF6OeQiJ4jLGJN7BywLoIbYP2OZ4UAfbpkyeZ
/xiTZWnVizClFuxZRpIFbj+YbB2iVW9aV9J+kx6Xd3BC8/Hiqom21iMMjPGkckte
euDExOlD1OPomnLUdxSkVSVzhEVAfVW80mqqy6/1LrI725wkJi3zZUx5/OezIYID
P/ssumBBtb1udJRhPWs8eX+4ZctwFwSOG/9pdxN5rGYJWNMrVCwBa5zkRgjs4EyJ
WqxuWtuxDwxlJReLmhPS35WCWh/aAnvnj4vSDZzoaZPlIBbJ51ZW1uMMHA/FmUgI
frH/+bELA3OqyZG1ac1J+kg66CyMtqqr5ZqZorg9ZlXLYwFbdikx/CQ7HObtQptC
ypw+JS5+xf8XHhULFEQK
=+6CT
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--

--===============8976173323678817321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8976173323678817321==--
