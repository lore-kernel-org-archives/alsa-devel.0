From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v3 1/2] ASoC: ssm2602: switch to SPDX identifier
Date: Wed,  6 Feb 2019 18:00:03 +0100
Message-ID: <20190206170004.11550-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D9DB267944
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 18:00:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Drop old license header and switch to SPDX-License-Identifier.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v3:
 - switch to C++ comment style
v2:
 - new created

 sound/soc/codecs/ssm2602.c | 39 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 501a4e73b185..30b6d30e8e7c 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -1,30 +1,15 @@
-/*
- * File:         sound/soc/codecs/ssm2602.c
- * Author:       Cliff Cai <Cliff.Cai@analog.com>
- *
- * Created:      Tue June 06 2008
- * Description:  Driver for ssm2602 sound chip
- *
- * Modified:
- *               Copyright 2008 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// File:         sound/soc/codecs/ssm2602.c
+// Author:       Cliff Cai <Cliff.Cai@analog.com>
+//
+// Created:      Tue June 06 2008
+// Description:  Driver for ssm2602 sound chip
+//
+// Modified:
+//               Copyright 2008 Analog Devices Inc.
+//
+// Bugs:         Enter bugs at http://blackfin.uclinux.org/
 
 #include <linux/module.h>
 #include <linux/regmap.h>
-- 
2.20.1
