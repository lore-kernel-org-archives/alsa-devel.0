From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: jz4725b: Use C++ style comments
	in header" to the asoc tree
Date: Thu,  7 Feb 2019 15:22:29 +0000 (GMT)
Message-ID: <20190207152229.3486D1127EF9@debutante.sirena.org.uk>
References: <20190207133143.5232-6-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A40892679D2
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 16:22:30 +0100 (CET)
In-Reply-To: <20190207133143.5232-6-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: jz4725b: Use C++ style comments in header

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

>From a50e32694fbcdbf55875095258b9398e2eabd71f Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:43 -0300
Subject: [PATCH] ASoC: codecs: jz4725b: Use C++ style comments in header

Change the header comment to use C++ style, so that it looks more
consistent with the rest of ASoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 24b1b23b99c9..103ccbc5d55c 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * JZ4725B CODEC driver
- *
- * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
- */
+//
+// JZ4725B CODEC driver
+//
+// Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.20.1
