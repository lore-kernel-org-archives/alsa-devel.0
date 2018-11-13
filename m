From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4/4] cplay: fix typo
Date: Tue, 13 Nov 2018 20:26:28 +0530
Message-ID: <20181113145628.21026-4-vkoul@kernel.org>
References: <20181113145628.21026-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id DBD7F267AA5
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 16:32:34 +0100 (CET)
In-Reply-To: <20181113145628.21026-1-vkoul@kernel.org>
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
Cc: Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 src/utils/cplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 87863a307b47..9ffa1dd86f7f 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -366,7 +366,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 			goto BUF_EXIT;
 		}
 		if (wrote != num_read) {
-			/* TODO: Buufer pointer needs to be set here */
+			/* TODO: Buffer pointer needs to be set here */
 			fprintf(stderr, "We wrote %d, DSP accepted %d\n", num_read, wrote);
 		}
 	}
-- 
2.14.5
