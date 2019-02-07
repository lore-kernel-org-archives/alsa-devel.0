From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/6] ASoC: codecs: jz4740: Use SPDX license notifier
Date: Thu,  7 Feb 2019 10:31:40 -0300
Message-ID: <20190207133143.5232-3-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Add license information as a standard SPDX license notifier instead of
custom text.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Use C++ style comment

 sound/soc/codecs/jz4740.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9395b583432c..9b3e1227a971 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -1,15 +1,8 @@
-/*
- * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// JZ4740 CODEC driver
+//
+// Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.11.0
