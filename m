From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] ASoC: mop500: Staticize non exported
	struct
Date: Tue, 14 May 2013 22:19:55 +0200
Message-ID: <1368562797-10440-9-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id A7FBA260859
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:28 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

The mop500_dai_links struct is not used outside of mop500.c, so make it static.

Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/mop500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 204b899..8f5cd00 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -27,7 +27,7 @@
 #include "mop500_ab8500.h"
 
 /* Define the whole MOP500 soundcard, linking platform to the codec-drivers  */
-struct snd_soc_dai_link mop500_dai_links[] = {
+static struct snd_soc_dai_link mop500_dai_links[] = {
 	{
 		.name = "ab8500_0",
 		.stream_name = "ab8500_0",
-- 
1.8.0
