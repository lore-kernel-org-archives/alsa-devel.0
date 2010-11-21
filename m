From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 4/4] ASoC: Remove cyclic dependency between
	soc.h and soc-dapm.h/soc-dai.h
Date: Sun, 21 Nov 2010 19:48:47 +0200
Message-ID: <1290361727-25162-4-git-send-email-jhnikula@gmail.com>
References: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 598D910383C
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 18:49:04 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 2so3482634ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 09:49:04 -0800 (PST)
In-Reply-To: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There is no need anymore to include soc.h in soc-dapm.h and soc-dai.h as
drivers are converted to include only soc.h.

Thanks to Lars-Peter Clausen <lars@metafoo.de> for pointing out the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h  |    2 --
 include/sound/soc-dapm.h |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e7b6802..0195b7e 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -16,8 +16,6 @@
 
 #include <linux/list.h>
 
-#include <sound/soc.h>
-
 struct snd_pcm_substream;
 
 /*
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 78d3560..041e98b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/types.h>
 #include <sound/control.h>
-#include <sound/soc.h>
 
 /* widget has no PM register bit */
 #define SND_SOC_NOPM	-1
-- 
1.7.0.4
