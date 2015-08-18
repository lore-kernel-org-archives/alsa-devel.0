From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Disable use from userspace"
	to the asoc tree
Date: Tue, 18 Aug 2015 09:33:50 -0700
Message-ID: <E1ZRjpe-0002k4-1E@finisterre>
References: <1439877828-4206-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 999F32619BE
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 18:33:53 +0200 (CEST)
In-Reply-To: <1439877828-4206-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Disable use from userspace

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

>From 8c90503bf246bebb48caa5590d41df755ba08550 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 17 Aug 2015 22:59:25 -0700
Subject: [PATCH] ASoC: topology: Disable use from userspace

Since the topology API is still in sufficient flux for changes to be
identified disable the use of the userspace ABI by adding #error
statements to the code, ensuring that nobody relies on the headers as
currently defined.  It is expected that this change will be reverted for
v4.3.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 1221520..677c3c9 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -18,6 +18,12 @@
 #include <linux/types.h>
 #include <sound/asound.h>
 
+#ifndef __KERNEL__
+#error This API is an early revision and not enabled in the current
+#error kernel release, it will be enabled in a future kernel version
+#error with incompatible changes to what is here.
+#endif
+
 /*
  * Maximum number of channels topology kcontrol can represent.
  */
-- 
2.5.0
