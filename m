From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: fsl: expand the size of the name in
	fsl_ssi_private struct
Date: Thu, 23 May 2013 16:51:12 +0800
Message-ID: <1369299072-25147-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 793C9261ACD
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 10:45:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

strcpy(ssi_private->name, p) in probe() sets "name" by "p", gotten from dts,
while the length of "p", if the devicetree node name of SSI is commonly set,
would always be larger than 1 char size, so need a larger size for "name".

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2f2d837..b6a5f94 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -152,5 +152,5 @@ struct fsl_ssi_private {
 	} stats;
 
-	char name[1];
+	char name[32];
 };
 
-- 
1.7.1
