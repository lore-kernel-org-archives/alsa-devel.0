From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Remove return value in jack
	detect work" to the asoc tree
Date: Mon, 20 Jul 2015 18:52:26 +0100
Message-ID: <E1ZHFEo-0002wH-4k@debutante>
References: <1437355925-20498-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A36261585
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:32 +0200 (CEST)
In-Reply-To: <1437355925-20498-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Remove return value in jack detect work

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f136dce45116027fec65c342fbcb5aaa900729c6 Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 20 Jul 2015 09:32:05 +0800
Subject: [PATCH] ASoC: rt5645: Remove return value in jack detect work

"ASoC: rt5645: Check if codec is initialized in workqueue handler"
adds a check if codec is NULL in rt5645_irq_detection, which
returns an int. However, "ASoC: rt5645: Remove irq_jack_detection
function" removes that function, and moves the code in
jack_detect_work, which returns void.

Remove the return value to fix compilation warning.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 19392b13bd5b..2ee42781cc52 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2928,7 +2928,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	int val, btn_type, gpio_state = 0, report = 0;
 
 	if (!rt5645->codec)
-		return -EINVAL;
+		return;
 
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
-- 
2.1.4
