From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4118: fix missing header" to the asoc
	tree
Date: Mon,  4 Feb 2019 16:17:02 +0000 (GMT)
Message-ID: <20190204161702.9CA57440082@finisterre.ee.mobilebroadband>
References: <20190204153538.26166-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6852645342403553214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF47226746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 17:17:09 +0100 (CET)
In-Reply-To: <20190204153538.26166-1-peron.clem@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Cl=C3=83=C2=A9ment=20P=C3=83=C2=A9ron=20=3Cpero?=
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, =?utf-8?b?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Adrien Charruel <adrien.charruel@devialet.com>
List-Id: alsa-devel@alsa-project.org

--===============6852645342403553214==
Content-Type: text/plain

The patch

   ASoC: ak4118: fix missing header

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0f747bb273790f49be4660521d86d7cebd1bbe1e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Date: Mon, 4 Feb 2019 16:35:38 +0100
Subject: [PATCH] ASoC: ak4118: fix missing header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver use the gpio consumer interface.
Add the header as it's needed.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4118.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index 238ab29f2bf4..ce419e8cf890 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.20.1


--===============6852645342403553214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6852645342403553214==--
