From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] ASoC: Fix s3c-i2s-v2.c snd_soc_dai changes
Date: Thu, 16 Apr 2009 10:32:22 +0100
Message-ID: <1239874343-7280-4-git-send-email-ben-linux@fluff.org>
References: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-2-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-3-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 971A0103959
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:36:10 +0200 (CEST)
In-Reply-To: <1239874343-7280-3-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Fix the build error in s3c-i2s-v2.c caused by
a change to the snd_soc_dai ops field.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 295a4c9..b983ad7 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -624,10 +624,12 @@ static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 
 int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 {
-	dai->ops.trigger = s3c2412_i2s_trigger;
-	dai->ops.hw_params = s3c2412_i2s_hw_params;
-	dai->ops.set_fmt = s3c2412_i2s_set_fmt;
-	dai->ops.set_clkdiv = s3c2412_i2s_set_clkdiv;
+	struct snd_soc_dai_ops *ops = dai->ops;
+
+	ops->trigger = s3c2412_i2s_trigger;
+	ops->hw_params = s3c2412_i2s_hw_params;
+	ops->set_fmt = s3c2412_i2s_set_fmt;
+	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
 
 	dai->suspend = s3c2412_i2s_suspend;
 	dai->resume = s3c2412_i2s_resume;
-- 
1.5.6.5
