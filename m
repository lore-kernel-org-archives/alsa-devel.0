From: bgoswami@codeaurora.org
Subject: [PATCH] ASoC: change mask in snd_soc_get/put_volsw_sx
	to unsigned int
Date: Sun, 31 Dec 2017 20:40:14 -0800
Message-ID: <1514781614-6039-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id CE114266E02
 for <alsa-devel@alsa-project.org>; Mon,  1 Jan 2018 05:46:12 +0100 (CET)
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
Cc: plai@qti.qualcomm.com, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Banajit Goswami <bgoswami@codeaurora.org>

If the result of (min + max) is negative in functions
snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(), there
will be an overflow for the variable 'mask'.
   UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:6
   signed integer overflow:
   -2147483648 - 1 cannot be represented in type 'int'

Fix this by updating the variable type of 'mask' to unsigned int.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 500f98c..7144a51 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -378,7 +378,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
 	unsigned int val;
 	int ret;
 
@@ -423,7 +423,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
