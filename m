From: alexey.kv@gmail.com
Subject: [PATCH - juli.c 1/1] ALSA: juli - Patch for
	suspend/resume for ESI Juli@
Date: Sat, 14 Nov 2009 15:18:54 +0200
Message-ID: <1258204734-23288-1-git-send-email-alexey.kv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, alexey.kv@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Aleksey Kunitskiy <alexey.kv@gmail.com>

Add proper suspend/resume code for Juli@ cards. Based on ice1724
suspend/resume work of Igor Chernyshev.
Fixes bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4413
Tested on linux-2.6.31.6

Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
---
 pci/ice1712/juli.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/pci/ice1712/juli.c b/pci/ice1712/juli.c
index 4bed963..0c9413d 100644
--- a/pci/ice1712/juli.c
+++ b/pci/ice1712/juli.c
@@ -483,6 +483,31 @@ static int __devinit juli_add_controls(struct snd_ice1712 *ice)
 }
 
 /*
+ * suspend/resume
+ * */
+
+#ifdef CONFIG_PM
+static int juli_resume(struct snd_ice1712 *ice)
+{
+	struct snd_akm4xxx *ak = ice->akm;
+	struct juli_spec *spec = ice->spec;
+	/* akm4358 un-reset, un-mute */
+	snd_akm4xxx_reset(ak, 0);
+	/* reinit ak4114 */
+	snd_ak4114_reinit(spec->ak4114);
+	return 0;
+}
+
+static int juli_suspend(struct snd_ice1712 *ice)
+{
+	struct snd_akm4xxx *ak = ice->akm;
+	/* akm4358 reset and soft-mute */
+	snd_akm4xxx_reset(ak, 1);
+	return 0;
+}
+#endif
+
+/*
  * initialize the chip
  */
 
@@ -626,6 +651,13 @@ static int __devinit juli_init(struct snd_ice1712 *ice)
 	ice->set_spdif_clock = juli_set_spdif_clock;
 
 	ice->spdif.ops.open = juli_spdif_in_open;
+
+#ifdef CONFIG_PM
+	ice->pm_resume = juli_resume;
+	ice->pm_suspend = juli_suspend;
+	ice->pm_suspend_enabled = 1;
+#endif
+
 	return 0;
 }
 
-- 
1.6.4.4
