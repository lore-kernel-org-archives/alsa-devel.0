From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 5/5] ASoC: AD1836: clean up comment headers
Date: Wed, 15 Jun 2011 15:29:23 -0400
Message-ID: <1308166163-22355-6-git-send-email-vapier@gentoo.org>
References: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 904CA103814
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 21:29:02 +0200 (CEST)
In-Reply-To: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |   19 +++++--------------
 sound/soc/codecs/ad1836.h |   17 ++++-------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index b9a5bab..4e5c572 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -1,19 +1,10 @@
-/*
- * File:         sound/soc/codecs/ad1836.c
- * Author:       Barry Song <Barry.Song@analog.com>
- *
- * Created:      Aug 04 2009
- * Description:  Driver for AD1836 sound chip
- *
- * Modified:
- *               Copyright 2009 Analog Devices Inc.
+ /*
+ * Audio Codec driver supporting:
+ *  AD1835A, AD1836, AD1837A, AD1838A, AD1839A
  *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ * Copyright 2009-2011 Analog Devices Inc.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Licensed under the GPL-2 or later.
  */
 
 #include <linux/init.h>
diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
index 80c24fd..444747f 100644
--- a/sound/soc/codecs/ad1836.h
+++ b/sound/soc/codecs/ad1836.h
@@ -1,19 +1,10 @@
 /*
- * File:         sound/soc/codecs/ad1836.h
- * Based on:
- * Author:       Barry Song <Barry.Song@analog.com>
+ * Audio Codec driver supporting:
+ *  AD1835A, AD1836, AD1837A, AD1838A, AD1839A
  *
- * Created:      Aug 04, 2009
- * Description:  definitions for AD1836 registers
+ * Copyright 2009-2011 Analog Devices Inc.
  *
- * Modified:
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Licensed under the GPL-2 or later.
  */
 
 #ifndef __AD1836_H__
-- 
1.7.5.3
