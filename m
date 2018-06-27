From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH tinycompress] cplay: Stop playback stream at
	the end
Date: Wed, 27 Jun 2018 10:48:11 +0300
Message-ID: <1530085691-27736-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B9D9F267943
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 09:48:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, vkoul@kernel.org
Cc: shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Each compress_start should have a corresponding compress_stop
at the end.

Also, this gives user a change to cleanup resources that might
have been allocated in compress_start.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
I'm implementing codec library dynamic loading at runtime and I'm exploring
using:
	* SNDRV_COMPRESS_START -> to load the library
	* SNDRV_COMPRESS_STOP  -> to unload the library

This might not be the best idea becasue for example loading
the library might introduce some delays, anyhow i still think
this that compress_stop is correct thing to add at the end of
playback.


 src/utils/cplay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 87863a3..3c48d15 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -403,6 +403,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 		printf("%s: exit success\n", __func__);
 	/* issue drain if it supports */
 	compress_drain(compress);
+	compress_stop(compress);
 	free(buffer);
 	fclose(file);
 	compress_close(compress);
-- 
2.7.4
