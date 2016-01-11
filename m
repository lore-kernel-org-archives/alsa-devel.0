From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: AMD: add missing include
Date: Mon, 11 Jan 2016 13:13:01 +0100
Message-ID: <4595844.NIUnxKiA0y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id E6A97260412
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 13:13:09 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Murali Krishna Vemuri <murali-krishna.vemuri@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The newly added AMD acp driver is missing an include for linux/io.h
and fails to build on ARM:

sound/soc/amd/acp-pcm-dma.c: In function 'acp_reg_read':
sound/soc/amd/acp-pcm-dma.c:83:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]

This adds the missing line.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This build error also appeared today on linux-next with ARM randconfig

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cc8b841b69b6..fa0311e4faed 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
+#include <linux/io.h>
 
 #include <sound/soc.h>
 
