From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 02/17 v2] ASoC: dapm: Add helpers to
	lock/unlock DAPM mutex
Date: Tue, 18 Feb 2014 15:22:13 +0000
Message-ID: <1392736948-26623-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC5C32651CB
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 16:30:44 +0100 (CET)
In-Reply-To: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

Acquiring the DAPM mutex is necessary before using several DAPM
functions and dereference is quite ugly. This patch provides a helper
function to simplify this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21038e0..dc46623 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1204,4 +1204,15 @@ extern struct dentry *snd_soc_debugfs_root;
 
 extern const struct dev_pm_ops snd_soc_pm_ops;
 
+/* Helper functions */
+static inline void snd_soc_dapm_mutex_lock(struct snd_soc_dapm_context *dapm)
+{
+	mutex_lock(&dapm->card->dapm_mutex);
+}
+
+static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
+{
+	mutex_unlock(&dapm->card->dapm_mutex);
+}
+
 #endif
-- 
1.7.2.5
