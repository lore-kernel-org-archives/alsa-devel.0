From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: fix
	snd_pcm_hw_rule_add arguments
Date: Fri, 9 Mar 2012 12:19:06 +0000
Message-ID: <20120309121906.GI3273@opensource.wolfsonmicro.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-2-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3989950947003106946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8872010B9A8
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:19:11 +0100 (CET)
In-Reply-To: <1331248757-3408-2-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============3989950947003106946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 01:19:15AM +0200, Grazvydas Ignotas wrote:
> We are setting SNDRV_PCM_HW_PARAM_BUFFER_SIZE based on
> SNDRV_PCM_HW_PARAM_CHANNELS, not vice versa. This bug didn't
> have much impact because the rules are evaluated multiple times
> by the core, and intended value got set eventually.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfUzAAoJEBus8iNuMP3dJycP/1FLPwpyNp1RMb4BkusTti+I
4yZrX83BUEY/T042KiGxz5ewOxCLQx0zpFTb6Nm4NaOTcyfyE/VpKzUt0aWx0V79
NZfFq6S3GjIKaESvv4X1GrHDIjHFP2FyTvWjPaJa7TL61mW62KeDc37WxMDdNmW/
FSEnJKIFfTrFggmF4R7DRvhZ/WWv8JYucIsR5NQLlKP7ZNDX5x4zewhDk29oCJXz
YUPibjVIRZB47gRGcG2zgQwCUCbRnJdAovrle0yP3AbPVP1jPhJDSB+R4r1hXCz0
kXz5lVgnRyRzF/Q2EvbiYQu0iIJn0e15wAEho7fwRmJHYyD8zy6lDlQpgyktLewZ
QYqNWqbKzP/aECDn2rmiUBDfuWdgkd+Rm/A0lyQf1WWyXpOxabMMLB+q4igvll65
QlE/7sLP8moC/LHuvk4tNXT5s6aY3JTlEAGsImLXcP90bRYRYP4h/50GqjS7YBeQ
T3031YgsDZ4s7iF6rP8eoltEyjwVJcHssGSL6vRTzlqb5uvvc/cZjBdT0y59iXId
oA9piqZlqXC870aSEtpnF9xMonIoT1MmOa9ZBkG/Y5RY02tXZEdOHCpJ/keZ4oqk
54GOUsi3L1s2TeQrc6vmhq4WYL0dOJE9bIU1+F1LJoN1nC7kAypgkoQ0kHj62+tg
XdTQ244uif+bC6Yii/bt
=AGsv
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--

--===============3989950947003106946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3989950947003106946==--
