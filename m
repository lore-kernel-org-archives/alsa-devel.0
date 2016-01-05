From: Mark Brown <broonie@kernel.org>
Subject: Applied "Linux 4.4-rc8" to the asoc tree
Date: Tue, 05 Jan 2016 12:33:12 +0000
Message-ID: <E1aGQnY-0007VL-Gb@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8832D2606D3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:33:17 +0100 (CET)
Received: from debutante.sirena.org.uk ([2a01:348:6:8808:fab::3]
 helo=debutante)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1aGQnb-0000qI-7b
 for alsa-devel@alsa-project.org; Tue, 05 Jan 2016 12:33:16 +0000
Received: from broonie by debutante with local (Exim 4.86)
 (envelope-from <broonie@sirena.org.uk>) id 1aGQnY-0007VL-Gb
 for alsa-devel@alsa-project.org; Tue, 05 Jan 2016 12:33:12 +0000
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   Linux 4.4-rc8

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

>From 168309855a7d1e16db751e9c647119fe2d2dc878 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Jan 2016 15:15:37 -0800
Subject: [PATCH] Linux 4.4-rc8

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1122433a5cd5..9d94adeceab6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 4
 PATCHLEVEL = 4
 SUBLEVEL = 0
-EXTRAVERSION = -rc7
+EXTRAVERSION = -rc8
 NAME = Blurry Fish Butt
 
 # *DOCUMENTATION*
-- 
2.6.2
