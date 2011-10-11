From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Delete ads117x.h
Date: Wed, 12 Oct 2011 06:57:25 +0800
Message-ID: <1318373845.6115.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id BAC6424141
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 00:57:36 +0200 (CEST)
Received: by qap1 with SMTP id 1so103926qap.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 15:57:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This is not required after multi-component patch.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ads117x.h |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)
 delete mode 100644 sound/soc/codecs/ads117x.h

diff --git a/sound/soc/codecs/ads117x.h b/sound/soc/codecs/ads117x.h
deleted file mode 100644
index 3ce0286..0000000
--- a/sound/soc/codecs/ads117x.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * ads117x.h  --  Driver for ads1174/8 ADC chips
- *
- * Copyright 2009 ShotSpotter Inc.
- * Author: Graeme Gregory <gg@slimlogic.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-extern struct snd_soc_dai_driver ads117x_dai;
-extern struct snd_soc_codec_driver soc_codec_dev_ads117x;
-- 
1.7.4.1
