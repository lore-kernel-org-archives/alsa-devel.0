From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6437a: use __be32 for a __be32 buf"
	to the asoc tree
Date: Mon,  7 Jan 2019 18:57:58 +0000 (GMT)
Message-ID: <20190107185758.4F0EE1127491@debutante.sirena.org.uk>
References: <20190105020249.8639-22-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7790F2670A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:57:59 +0100 (CET)
In-Reply-To: <20190105020249.8639-22-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6437a: use __be32 for a __be32 buf

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

>From b8e022e83ba99a0deb27e929033008402f863dd7 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:49 -0600
Subject: [PATCH] ASoC: rl6437a: use __be32 for a __be32 buf

The buf in rl6347a_hw_read is __be32.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6347a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 8f571cf8edd4..c0d729b45277 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -64,8 +64,8 @@ int rl6347a_hw_read(void *context, unsigned int reg, unsigned int *value)
 	struct i2c_client *client = context;
 	struct i2c_msg xfer[2];
 	int ret;
-	__be32 be_reg;
-	unsigned int index, vid, buf = 0x0;
+	__be32 be_reg, buf = 0x0;
+	unsigned int index, vid;
 
 	/* handle index registers */
 	if (reg <= 0xff) {
-- 
2.20.1
