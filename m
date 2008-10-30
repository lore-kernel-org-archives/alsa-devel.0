From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 30 Oct 2008 11:40:57 +0000
Message-ID: <20081030114057.GB5747@sirena.org.uk>
References: <20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
	<20081028131031.GG9068@sirena.org.uk>
	<20081028153435.GK9068@sirena.org.uk>
	<49078946.9030003@oliford.co.uk>
	<20081029160451.GD14648@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E51D24381
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 12:41:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081029160451.GD14648@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2008 at 04:04:51PM +0000, Mark Brown wrote:

> I won't be able to fix it today since I have to go and get my eyes
> examined (no wonder it took me so long to spot this!) but I expect I'll
> have a patch tomorrow.

Please try this, it resolves the problems I'm seeing here:

commit 9fafa720f6dd4a7a9476bef0d78fee14af401c14
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Thu Oct 30 11:32:47 2008 +0000

    ASoC: Fix mono controls after conversion to support full int masks
    
    When ASoC was converted to support full int width masks SOC_SINGLE_VALUE()
    omitted the assignment of rshift, causing the control operatins to report
    some mono controls as stereo. This happened to work some of the time due
    to a confusion between shift and min in snd_soc_info_volsw().
    
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d33825d..da0040b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -28,7 +28,8 @@
  */
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .shift = xshift, .max = xmax, .invert = xinvert})
+	{.reg = xreg, .shift = xshift, .rshift = xshift, .max = xmax, \
+	.invert = xinvert})
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .max = xmax, .invert = xinvert})
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0399fff..a17f864 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1563,7 +1563,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int max = mc->max;
-	unsigned int shift = mc->min;
+	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 
 	if (max == 1)
