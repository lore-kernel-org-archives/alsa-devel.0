From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: asoc-v2 ac97-wm9713 suspend/resume
Date: Sun, 22 Jun 2008 21:46:52 +0200
Message-ID: <87abhdw8ur.fsf@free.fr>
References: <485E890D.2070307@oliford.co.uk> <87k5ghweoh.fsf@free.fr>
	<485E920E.5050601@oliford.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E4F82480F
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 21:46:54 +0200 (CEST)
In-Reply-To: <485E920E.5050601@oliford.co.uk> (Oliver Ford's message of "Sun\,
	22 Jun 2008 18\:55\:26 +0100")
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

--=-=-=

Oliver Ford <ipaqlinux@oliford.co.uk> writes:

> Robert Jarzmik wrote:
>>  - I had to add a double reset in wm9713 resume() function as you did
>>
>>   
> Does this actually work for you?
Yes, indeed.
>
> I forgot to say, for me it allows the touchscreen to work, and 'amixer cset xxx
> xxx' commands seem to make things click, but I get no sound from aplay where I
> do before the suspend.
I joined here all my modifications to asoc-v2 and my board code. Hope this will
help you a bit.

For the other listening here, this is _not_ a submission, I'm still waiting for
the official go of asoc-v2 to clean and submit my patches.

--
Robert


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Dirty-hack-to-use-GPIO95-in-AC97-reset.patch

>From 78a4b1aafe8c0b36f9504d70cc3914265eba1d36 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Sun, 16 Mar 2008 22:44:17 +0100
Subject: [PATCH] Dirty hack to use GPIO95 in AC97 reset.

Mio Mitac A701 uses GPIO95 instead of GPIO113 as the reset
line connected to the WM9713 chip. This is dirty, and should
be replaced by an elegant solution where cold and warm reset
are implemented in machine driver mioa701_wm9713.c

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
---
 sound/soc/pxa/pxa2xx-ac97.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index cb12544..86fb9c2 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -145,10 +145,10 @@ static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 #ifdef CONFIG_PXA27x
 	/* warm reset broken on Bulverde,
 	   so manually keep AC97 reset high */
-	pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
+	pxa_gpio_mode(95 | GPIO_OUT | GPIO_DFLT_HIGH);
 	udelay(10);
 	GCR |= GCR_WARM_RST;
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	pxa_gpio_mode(95 | GPIO_ALT_FN_1_OUT);
 	udelay(500);
 #elif defined(CONFIG_PXA3xx)
 	/* Can't use interrupts */
@@ -303,8 +303,8 @@ static int pxa2xx_ac97_resume(struct platform_device *dev)
 	pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
 #endif
 #ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	/* Use GPIO 95 as AC97 Reset on Bulverde */
+	pxa_gpio_mode(95 | GPIO_ALT_FN_1_OUT);
 #endif
 	clk_enable(ac97_clk);
 	return 0;
@@ -457,8 +457,8 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 #ifdef CONFIG_PXA27x
-	/* Use GPIO 113 as AC97 Reset on Bulverde */
-	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
+	/* Use GPIO 95 as AC97 Reset on Bulverde */
+	pxa_gpio_mode(95 | GPIO_ALT_FN_1_OUT);
 
 	ac97conf_clk = clk_get(&pdev->dev, "AC97CONFCLK");
 	if (IS_ERR(ac97conf_clk)) {
-- 
1.5.5.3


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0002-Dirty-hack-to-workaround-pxa27x-buggy-hardreset.patch

>From 86e28a3258b8715c23c1e7eefd259fe0238d099e Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Fri, 25 Apr 2008 22:48:39 +0200
Subject: [PATCH] Dirty hack to workaround pxa27x buggy hardreset.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
---
 sound/soc/codecs/wm9713.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 2cb4fb8..8ec7ce9 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -975,6 +975,7 @@ static int wm9713_resume(struct platform_device *pdev)
 	u16 id;
 
 	/* give the codec an AC97 warm reset to start the link */
+	codec->ac97->bus->ops->reset(codec->ac97);
 	codec->ac97->bus->ops->warm_reset(codec->ac97);
 	id = codec->soc_phys_read(codec->ac97, AC97_VENDOR_ID2); 
 	if (id != 0x4c13) {
-- 
1.5.5.3


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0003-Added-double-ac97-reset-in-pxa27x-resume-path.patch

>From 2d8aa2d11131c7f68ffb3f031964bb98866ca511 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Mon, 28 Apr 2008 19:46:57 +0200
Subject: [PATCH] Added double ac97 reset in pxa27x resume path.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
---
 sound/soc/codecs/wm9713.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 8ec7ce9..5defac8 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -977,6 +977,8 @@ static int wm9713_resume(struct platform_device *pdev)
 	/* give the codec an AC97 warm reset to start the link */
 	codec->ac97->bus->ops->reset(codec->ac97);
 	codec->ac97->bus->ops->warm_reset(codec->ac97);
+	codec->ac97->bus->ops->reset(codec->ac97);
+	codec->ac97->bus->ops->warm_reset(codec->ac97);
 	id = codec->soc_phys_read(codec->ac97, AC97_VENDOR_ID2); 
 	if (id != 0x4c13) {
 		printk(KERN_ERR "wm9713 failed to resume");
-- 
1.5.5.3


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0004-Include-shuffle-in-2.6.25-kernels.patch

>From 81b4171dd0ba62391898240424102abdb9db67a8 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Wed, 30 Apr 2008 23:54:11 +0200
Subject: [PATCH] Include shuffle in 2.6.25 kernels.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
---
 sound/soc/pxa/pxa2xx-ac97.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 86fb9c2..04156d6 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>
+#include <asm/arch/pxa2xx-gpio.h>
 #include <asm/arch/audio.h>
 
 #include "pxa2xx-pcm.h"
-- 
1.5.5.3


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0005-Revert-wm9713-Expose-the-PLL-configuration.patch

>From e07ea80f6d8bbac6ab20b525a0c37269eb6bb741 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Sun, 1 Jun 2008 14:49:31 +0200
Subject: [PATCH] Revert "wm9713: Expose the PLL configuration"

This reverts commit 0d03f161680832984dd03f6bfc9a3423fc67501d.
There's a bug in set_pll call from resume function.
---
 sound/soc/codecs/wm9713.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 5defac8..eae042c 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -659,7 +659,7 @@ struct pll_ {
 	unsigned int k;
 };
 
-static struct pll_ pll[] = {
+struct pll_ pll[] = {
 	{13000000, 0, 1, 0, 0, 7, 0x23f488},
 	{2048000,  1, 0, 0, 0, 12, 0x0},
 	{4096000,  1, 0, 0, 0, 6, 0x0},
@@ -667,10 +667,9 @@ static struct pll_ pll[] = {
 	/* liam - add more entries */
 };
 
-static int wm9713_set_pll(struct snd_soc_dai *codec_dai,
+static int wm9713_set_pll(struct snd_soc_codec *codec,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm9713_data *wm9713 = codec->private_data;
 	int i;
 	u16 reg, reg2;
@@ -1056,13 +1055,11 @@ static struct snd_soc_dai_caps wm9713_voice_playback = {
 static struct snd_soc_dai_ops wm9713_hifi_dai_ops = {
 	/* alsa ops */
 	.prepare = ac97_hifi_prepare,
-	.set_pll = wm9713_set_pll,
 };
 
 static struct snd_soc_dai_ops wm9713_aux_dai_ops = {
 	/* alsa ops */
 	.prepare = ac97_aux_prepare,
-	.set_pll = wm9713_set_pll,
 };
 
 static struct snd_soc_dai_ops wm9713_voice_dai_ops = {
@@ -1074,7 +1071,6 @@ static struct snd_soc_dai_ops wm9713_voice_dai_ops = {
 	.set_clkdiv = wm9713_set_dai_clkdiv,
 	.set_fmt = wm9713_set_dai_fmt,
 	.set_tristate = wm9713_set_dai_tristate,
-	.set_pll = wm9713_set_pll,
 };
 
 /* for modprobe */
-- 
1.5.5.3


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=sound_soc_pxa.tar.gz
Content-Transfer-Encoding: base64
Content-Description: mioa701 board code

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
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
