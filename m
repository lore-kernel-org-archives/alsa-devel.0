From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] ASoC: codecs: jz4725b: Use C++ style comments in header
Date: Thu,  7 Feb 2019 10:31:43 -0300
Message-ID: <20190207133143.5232-6-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Change the header comment to use C++ style, so that it looks more
consistent with the rest of ASoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

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
2.11.0
