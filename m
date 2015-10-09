From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: fix build warning" to the asoc
	tree
Date: Fri, 09 Oct 2015 12:21:31 +0100
Message-ID: <E1ZkVjv-0006bq-PM@finisterre>
References: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E043C265163
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:48 +0200 (CEST)
In-Reply-To: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: fix build warning

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

>From dc542fb4179a104fc73760a2da0fd78f68f70d6d Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 7 Oct 2015 17:52:12 +0530
Subject: [PATCH] ASoC: rt5645: fix build warning

We were getting build warning about "Section mismatch".
dmi_platform_intel_broadwell is being referenced from the probe function
rt5645_i2c_probe(), but dmi_platform_intel_broadwell was marked with
__initdata.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index cd1a4ec..d9993d4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3241,7 +3241,7 @@ static int buddy_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
+static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{
 		.ident = "Chrome Buddy",
 		.callback = buddy_quirk_cb,
-- 
2.5.0
