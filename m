From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Fix a compile warning at
	CONFIG_COMMON_CLK=n" to the asoc tree
Date: Tue,  7 May 2019 03:28:52 +0100 (BST)
Message-ID: <20190507022852.63EF1440033@finisterre.sirena.org.uk>
References: <20190506150224.1394-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4338764978016427827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5ACEEF8972B
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 04:29:09 +0200 (CEST)
In-Reply-To: <20190506150224.1394-2-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============4338764978016427827==
Content-Type: text/plain

The patch

   ASoC: da7219: Fix a compile warning at CONFIG_COMMON_CLK=n

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From ab0c433f32f86370152bc9cb4900e5fe9a11055c Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 6 May 2019 17:02:22 +0200
Subject: [PATCH] ASoC: da7219: Fix a compile warning at CONFIG_COMMON_CLK=n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A trivial fix for the randconfig build error:
  sound/soc/codecs/da7219.c:2366:6: warning: unused variable ‘i’ [-Wunused-variable]

Fixes: d90ba6c8b53e ("ASoC: da7219: Expose BCLK and WCLK control through CCF")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 206d01c6eb7e..43c03e7b2f0e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2357,7 +2357,9 @@ static int da7219_probe(struct snd_soc_component *component)
 static void da7219_remove(struct snd_soc_component *component)
 {
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+#ifdef CONFIG_COMMON_CLK
 	int i;
+#endif
 
 	da7219_aad_exit(component);
 
-- 
2.20.1


--===============4338764978016427827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4338764978016427827==--
