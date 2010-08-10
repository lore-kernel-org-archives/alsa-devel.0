From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 17/17] ASoC: multi-component - remove no longer
	needed codec headers
Date: Wed, 11 Aug 2010 00:03:08 +0100
Message-ID: <1281481388-3000-18-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE41F10388F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:04:02 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:04:02 -0700 (PDT)
In-Reply-To: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Since we no longer need to export DAI or CODEC driver
struct, we can delete these files.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/ac97.h              |   19 -------------------
 sound/soc/codecs/ak4104.h            |    7 -------
 sound/soc/codecs/ak4642.h            |   20 --------------------
 sound/soc/codecs/cq93vc.h            |   29 -----------------------------
 sound/soc/codecs/da7210.h            |   24 ------------------------
 sound/soc/codecs/jz4740.h            |   20 --------------------
 sound/soc/codecs/spdif_transciever.h |   18 ------------------
 sound/soc/codecs/wm8727.h            |   21 ---------------------
 8 files changed, 0 insertions(+), 158 deletions(-)
 delete mode 100644 sound/soc/codecs/ac97.h
 delete mode 100644 sound/soc/codecs/ak4104.h
 delete mode 100644 sound/soc/codecs/ak4642.h
 delete mode 100644 sound/soc/codecs/cq93vc.h
 delete mode 100644 sound/soc/codecs/da7210.h
 delete mode 100644 sound/soc/codecs/jz4740.h
 delete mode 100644 sound/soc/codecs/spdif_transciever.h
 delete mode 100644 sound/soc/codecs/wm8727.h

diff --git a/sound/soc/codecs/ac97.h b/sound/soc/codecs/ac97.h
deleted file mode 100644
index a924659..0000000
--- a/sound/soc/codecs/ac97.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * linux/sound/codecs/ac97.h -- ALSA SoC Layer
- *
- * Author:		Liam Girdwood
- * Created:		Dec 1st 2005
- * Copyright:	Wolfson Microelectronics. PLC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __LINUX_SND_SOC_AC97_H
-#define __LINUX_SND_SOC_AC97_H
-
-extern struct snd_soc_codec_driver soc_codec_dev_ac97;
-extern struct snd_soc_dai_driver ac97_dai;
-
-#endif
diff --git a/sound/soc/codecs/ak4104.h b/sound/soc/codecs/ak4104.h
deleted file mode 100644
index 51e8922..0000000
--- a/sound/soc/codecs/ak4104.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _AK4104_H
-#define _AK4104_H
-
-extern struct snd_soc_dai_driver ak4104_dai;
-extern struct snd_soc_codec_driver soc_codec_device_ak4104;
-
-#endif
diff --git a/sound/soc/codecs/ak4642.h b/sound/soc/codecs/ak4642.h
deleted file mode 100644
index d5a9e43..0000000
--- a/sound/soc/codecs/ak4642.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * ak4642.h  --  AK4642 Soc Audio driver
- *
- * Copyright (C) 2009 Renesas Solutions Corp.
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * Based on ak4535.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _AK4642_H
-#define _AK4642_H
-
-extern struct snd_soc_dai_driver ak4642_dai;
-extern struct snd_soc_codec_driver soc_codec_dev_ak4642;
-
-#endif
diff --git a/sound/soc/codecs/cq93vc.h b/sound/soc/codecs/cq93vc.h
deleted file mode 100644
index 77f9d3d..0000000
--- a/sound/soc/codecs/cq93vc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
- *
- * Copyright (C) 2010 Texas Instruments, Inc
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef _CQ93VC_H
-#define _CQ93VC_H
-
-extern struct snd_soc_dai_driver cq93vc_dai;
-extern struct snd_soc_codec_driver soc_codec_dev_cq93vc;
-
-#endif
diff --git a/sound/soc/codecs/da7210.h b/sound/soc/codecs/da7210.h
deleted file mode 100644
index 390d621..0000000
--- a/sound/soc/codecs/da7210.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * da7210.h  --  audio driver for da7210
- *
- * Copyright (c) 2009 Dialog Semiconductor
- * Written by David Chen <Dajun.chen@diasemi.com>
- *
- * Copyright (C) 2009 Renesas Solutions Corp.
- * Cleanups by Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef _DA7210_H
-#define _DA7210_H
-
-extern struct snd_soc_dai da7210_dai;
-extern struct snd_soc_codec_device soc_codec_dev_da7210;
-
-#endif
-
diff --git a/sound/soc/codecs/jz4740.h b/sound/soc/codecs/jz4740.h
deleted file mode 100644
index d4b5d73..0000000
--- a/sound/soc/codecs/jz4740.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
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
-
-#ifndef __SND_SOC_CODECS_JZ4740_CODEC_H__
-#define __SND_SOC_CODECS_JZ4740_CODEC_H__
-
-extern struct snd_soc_dai_driver jz4740_codec_dai;
-extern struct snd_soc_codec_driver soc_codec_dev_jz4740_codec;
-
-#endif
diff --git a/sound/soc/codecs/spdif_transciever.h b/sound/soc/codecs/spdif_transciever.h
deleted file mode 100644
index d686191..0000000
--- a/sound/soc/codecs/spdif_transciever.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * ALSA SoC DIT/DIR driver header
- *
- * Author:      Steve Chen,  <schen@mvista.com>
- * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef CODEC_STUBS_H
-#define CODEC_STUBS_H
-
-extern struct snd_soc_codec_driver soc_codec_spdif_dit;
-extern struct snd_soc_dai_driver dit_stub_dai;
-
-#endif /* CODEC_STUBS_H */
diff --git a/sound/soc/codecs/wm8727.h b/sound/soc/codecs/wm8727.h
deleted file mode 100644
index 21fa74b..0000000
--- a/sound/soc/codecs/wm8727.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * wm8727.h
- *
- *  Created on: 15-Oct-2009
- *      Author: neil.jones@imgtec.com
- *
- * Copyright (C) 2009 Imagination Technologies Ltd.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef WM8727_H_
-#define WM8727_H_
-
-extern struct snd_soc_dai_driver wm8727_dai;
-extern struct snd_soc_codec_driver soc_codec_dev_wm8727;
-
-#endif /* WM8727_H_ */
-- 
1.7.0.4
