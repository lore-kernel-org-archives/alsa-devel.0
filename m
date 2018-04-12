From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 4/5] ASoC: tfa9879: switch to SPDX license tag
Date: Thu, 12 Apr 2018 23:14:36 +0200
Message-ID: <20180412211437.21599-5-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 7 +------
 sound/soc/codecs/tfa9879.h | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index c30e0efdbe39..4d9b3f393808 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * tfa9879.c  --  driver for NXP Semiconductors TFA9879
  *
  * Copyright (C) 2014 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/codecs/tfa9879.h b/sound/soc/codecs/tfa9879.h
index 3408c90c4628..66c88d0396fe 100644
--- a/sound/soc/codecs/tfa9879.h
+++ b/sound/soc/codecs/tfa9879.h
@@ -1,14 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * tfa9879.h  --  driver for NXP Semiconductors TFA9879
  *
  * Copyright (C) 2014 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #ifndef _TFA9879_H
-- 
2.11.0
