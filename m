From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
Date: Sun, 02 Oct 2011 23:14:55 +0200
Message-ID: <3289863.m6ULFZUV3p@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-6-git-send-email-arnd@arndb.de>
	<20111002204729.GC5811@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 7825124380
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 23:15:44 +0200 (CEST)
In-Reply-To: <20111002204729.GC5811@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sunday 02 October 2011 21:47:30 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:03PM +0200, Arnd Bergmann wrote:
> 
> >  config SND_SAMSUNG_AC97
> >       tristate
> > +     depends on SND_SOC_ALL_CODECS=n || SND_SOC_ALL_CODECS
> >       select SND_SOC_AC97_BUS
> 
> No, I'm not sure what the problem you're trying to fix here but this
> looks pretty terrible.  SND_SOC_ALL_CODECS is a debugging tool for build
> coverage, we shouldn't be restricting actual useful drivers based on it.
> What is the intention of this change and why does it only apply to the
> Samsung platform?  It all looks very magic.

It's a bug that I only observed on exynos4, and it could be that
this patch didn't actually solve it in the end. I'll drop it for
now and do a better report when the problem comes back.

I remember that I never fully understood what was going on either,
and I suspected a problem with Kconfig resulting in some builtin
ac97 code referencing symbols that are enabled in a module when
SND_SOC_ALL_CODECS=m.

> >  config SND_SOC_SAMSUNG_SMDK_WM8994
> >       tristate "SoC I2S Audio support for WM8994 on SMDK"
> >       depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
> > +     depends on MFD_WM8994
> >       select SND_SOC_WM8994
> 
> This is non-idiomatic - we always select the CODEC drivers rather than
> depending on them for usability.

Ok. I did this patch before the MFD_SUPPORT option was removed, so I did
not want to add both 'select MFD_WM8994' and 'select MFD_SUPPORT' here.

So should SND_SOC_WM8994 instead select MFD_WM8994? That would mean adding
the select only in one place.

	Arnd

8<---
ASoC: codecs: SND_SOC_WM8994 requires MFD_WM8994

The samsung SMDK platform can select SND_SOC_WM8994 while the
necessary MFD driver is not present. Always select MFD_WM8994
now in order to satisfy the build dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d41447..b7b9ddc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -92,7 +92,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8990 if I2C
 	select SND_SOC_WM8991 if I2C
 	select SND_SOC_WM8993 if I2C
-	select SND_SOC_WM8994 if MFD_WM8994
+	select SND_SOC_WM8994
 	select SND_SOC_WM8995 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8996 if I2C
 	select SND_SOC_WM9081 if I2C
@@ -373,6 +373,7 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	select MFD_WM8994
 
 config SND_SOC_WM8995
 	tristate
