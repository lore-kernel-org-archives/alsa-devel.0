From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as sgtl5000 maintainer
Date: Fri, 16 Feb 2018 12:45:13 -0200
Message-ID: <1518792313-12582-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5066626701D
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 15:45:19 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id f4so4014147qtj.6
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 06:45:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

I would like helping maintaining and reviewing/testing sgtl5000
related patches.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76e..c488c8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9922,6 +9922,13 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP SGTL5000 DRIVER
+M:	Fabio Estevam <fabio.estevam@nxp.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
+F:	sound/soc/codecs/sgtl5000*
+
 NXP TDA998X DRM DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Supported
-- 
2.7.4
