From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH] ASoC: Update Cirrus Logic CODEC maintainers.
Date: Wed, 7 May 2014 09:49:36 -0500
Message-ID: <1399474176-3383-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0083.outbound.protection.outlook.com [65.55.169.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 372712616C9
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 16:47:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Paul Handrigan <paul.handrigan@cirrus.com>, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Remove Timur Tabi as maintainer for CS4270 codec. I would like to thank Timur
for his work on maintaining this driver.

Signed-off-by: Paul Handrigan <paul.handrigan@cirrus.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1066264..5f2dd76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2245,12 +2245,6 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/host/ohci-ep93xx.c
 
-CIRRUS LOGIC CS4270 SOUND DRIVER
-M:	Timur Tabi <timur@tabi.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Odd Fixes
-F:	sound/soc/codecs/cs4270*
-
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
1.9.1
