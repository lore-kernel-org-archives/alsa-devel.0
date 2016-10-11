From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Reenable use from userspace"
	to the asoc tree
Date: Tue, 11 Oct 2016 12:28:12 +0200
Message-ID: <E1btuI8-0008Cn-GF@finisterre>
References: <1445830900-1752-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E16261560
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 12:28:39 +0200 (CEST)
In-Reply-To: <1445830900-1752-1-git-send-email-broonie@kernel.org>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mendong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Reenable use from userspace

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

>From 7c45e3cc6a59fb00edea65dfb6d3ae60403e4539 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 26 Oct 2015 12:35:02 +0900
Subject: [PATCH] ASoC: topology: Reenable use from userspace

We had inserted a #error into the topology UAPI code to ensure that the
ABI was not adopted by userspace while final review and testing was
ongoing.  The idea was that some finishing touches would be made to the
ABI before declaring it stable and suitable for use in production but
this has not yet happened as more than a year later revisions to the ABI
are still onging.

The reality however is that people are shipping topology files in
production and these ABI changes are causing practical issues for users
and we can't break userspace.  This makes this error pointless so we
should remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asoc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 33d00a4ce656..819d895edfdc 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -18,12 +18,6 @@
 #include <linux/types.h>
 #include <sound/asound.h>
 
-#ifndef __KERNEL__
-#error This API is an early revision and not enabled in the current
-#error kernel release, it will be enabled in a future kernel version
-#error with incompatible changes to what is here.
-#endif
-
 /*
  * Maximum number of channels topology kcontrol can represent.
  */
-- 
2.9.3
