From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 15:59:34 +0100
Message-ID: <20081007145934.GA32344@rakim.wolfsonmicro.main>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
	<B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
	<20081007134318.GF19835@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E54B24604
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 16:59:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 05:21:48PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> I'm sorry, It seems to be the switch connecting MICN to negative PGA
> terminal that does not stay on (register 0x2c bit 1)

Ah, I think I see what's going on here.  Could you try this patch,
please (again, untested)?

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 94cab49..ea524c4 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -227,9 +227,9 @@ SND_SOC_DAPM_PGA("SpkN Out", WM8510_POWER3, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SpkP Out", WM8510_POWER3, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA("Mono Out", WM8510_POWER3, 7, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA("Mic PGA", WM8510_POWER2, 2, 0,
-		 &wm8510_micpga_controls[0],
-		 ARRAY_SIZE(wm8510_micpga_controls)),
+SND_SOC_DAPM_MIXER("Mic PGA", WM8510_POWER2, 2, 0,
+		   &wm8510_micpga_controls[0],
+		   ARRAY_SIZE(wm8510_micpga_controls)),
 SND_SOC_DAPM_MIXER("Boost Mixer", WM8510_POWER2, 4, 0,
 	&wm8510_boost_controls[0],
 	ARRAY_SIZE(wm8510_boost_controls)),
