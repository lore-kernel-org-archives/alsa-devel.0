From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Use __printf markup to silence
	compiler" to the asoc tree
Date: Tue, 12 Feb 2019 14:21:47 +0000 (GMT)
Message-ID: <20190212142147.7E3621128113@debutante.sirena.org.uk>
References: <20190123194131.19406-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B4E2673F8
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:21:53 +0100 (CET)
In-Reply-To: <20190123194131.19406-1-malat@debian.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathieu Malaterre <malat@debian.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Use __printf markup to silence compiler

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

>From 595d2f74cd3caedb704a118bd09c1b4dfbfc0ec0 Mon Sep 17 00:00:00 2001
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 23 Jan 2019 20:41:30 +0100
Subject: [PATCH] ASoC: Use __printf markup to silence compiler

Silence warnings (triggered at W=1) by adding relevant __printf
attributes.

  sound/soc/soc-dapm.c:149:2: warning: function 'pop_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d31d295b540f..dea6fc2353e4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -157,6 +157,7 @@ static void pop_wait(u32 pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
+__printf(3, 4)
 static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
-- 
2.20.1
