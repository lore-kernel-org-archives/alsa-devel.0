From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] hda: comment typo fix
Date: Tue, 7 Oct 2008 14:17:53 +0800
Message-ID: <1223360275.282524.8948@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

fix a typo in comment for process_unsol_events().

Signed-off-by: Wu Fengguang<wfg@linux.intel.com>
---

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index c742e10..7717a92 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -314,7 +314,7 @@ int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
 }
 
 /*
- * process queueud unsolicited events
+ * process queued unsolicited events
  */
 static void process_unsol_events(struct work_struct *work)
 {
