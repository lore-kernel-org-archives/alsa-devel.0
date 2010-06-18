From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
	board
Date: Fri, 18 Jun 2010 09:10:33 +0200
Message-ID: <4C1B1BE9.9040802@eukrea.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>
	<20100618005637.GA3333@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020001010209060103040907"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 29.mail-out.ovh.net (29.mail-out.ovh.net [87.98.216.213])
	by alsa0.perex.cz (Postfix) with SMTP id 3925E103958
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 09:10:37 +0200 (CEST)
In-Reply-To: <20100618005637.GA3333@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020001010209060103040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Le 18/06/2010 02:56, Mark Brown a =E9crit :
> On Thu, Jun 17, 2010 at 03:44:01PM +0200, Eric B=E9nard wrote:
>> * tdm slot has to be configured to get sound working on i.MX25
>>
>> Signed-off-by: Eric B=E9nard<eric@eukrea.com>
>
> Applied but I had to hand apply the Kconfig update, please check that i=
t
> applied correctly.
>
Yes this seems fine, sorry I wasn't rebased against the right tree.

This Kconfig seems to have unecessary things into it :
- config SND_MXC_SOC_SSI :
	not used in the kernel
- 1st board :
	depends on SND_IMX_SOC
	select SND_MXC_SOC_SSI
- 2nd board :
	select SND_MXC_SOC_SSI
	but doesn't depends on SND_IMX_SOC
- 3rd board :
	select SND_IMX_SOC

Do you have any idea what SND_MXC_SOC_SSI is used for ?

Please find attached a patch which should clean this Kconfig. If it's ok=20
for you, I'll submit it the right way.

Eric

--------------020001010209060103040907
Content-Type: text/x-patch;
 name="0001-soc-imx-clean-Kconfig.patch"
Content-Disposition: attachment;
 filename="0001-soc-imx-clean-Kconfig.patch"
Content-Transfer-Encoding: quoted-printable

>From e177e758ad220e5f77d8321731e89f5b8b5da337 Mon Sep 17 00:00:00 2001
From: =3D?utf-8?q?Eric=3D20B=3DC3=3DA9nard?=3D <eric@eukrea.com>
Date: Fri, 18 Jun 2010 09:06:45 +0200
Subject: [PATCH] soc/imx: clean Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 sound/soc/imx/Kconfig |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 6ef57e0..35e6cf6 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -8,22 +8,17 @@ config SND_IMX_SOC
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX SSI interface.
=20
-config SND_MXC_SOC_SSI
-	tristate
-
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on SND_IMX_SOC && MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
-	select SND_MXC_SOC_SSI
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
=20
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
-	depends on MACH_PCM043 || MACH_PCA100
-	select SND_MXC_SOC_SSI
+	depends on SND_IMX_SOC && (MACH_PCM043 || MACH_PCA100)
 	select SND_SOC_WM9712
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
@@ -31,8 +26,7 @@ config SND_SOC_PHYCORE_AC97
=20
 config SND_SOC_EUKREA_TLV320
 	bool "Eukrea TLV320"
-	depends on MACH_EUKREA_MBIMX27_BASEBOARD || MACH_EUKREA_MBIMXSD_BASEBOA=
RD
-	select SND_IMX_SOC
+	depends on SND_IMX_SOC && (MACH_EUKREA_MBIMX27_BASEBOARD || MACH_EUKREA=
_MBIMXSD_BASEBOARD)
 	select SND_SOC_TLV320AIC23
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
--=20
1.6.3.3


--------------020001010209060103040907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020001010209060103040907--
