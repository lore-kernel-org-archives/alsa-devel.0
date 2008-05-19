From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC V2] Fix null-pointer dereference in
	soc_create_pcm()
Date: Mon, 19 May 2008 17:45:59 -0500
Message-ID: <1211237159-26546-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A6E7F2466A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 00:46:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When soc_create_pcm() finds all four components it needs, it displays a status
message.  This message references the local variables 'codec_dai' and
'cpu_dai', but these variables are initialized only when the codec DAI and the
cpu DAI are the last to be registered.  This patch changes the code to use the
stored values instead of the local variables.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7dc6d68..520469b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -921,8 +921,8 @@ check:
 	}
 
 	pcm->private_free = platform->pcm_free;
-	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n",
+		pcm_runtime->codec_dai->name, pcm_runtime->cpu_dai->name);
 	list_add(&pcm_runtime->list, &soc_card->pcm_list);
 	return 1;
 err:
-- 
1.5.5
