From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: firewire-lib: skip releasing stream
	data when it's not initialized
Date: Sat, 26 Mar 2016 21:05:59 +0900
Message-ID: <1458993959-22637-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id EBAA42612D1
 for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2016 13:06:04 +0100 (CET)
In-Reply-To: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

When any of AMDTP stream data are not initialized and private data is
going to be released, WARN_ON() in amdtp_stream_destroy() is hit and
dump messages. This may take users irritated.

This commit fixes the bug to skip releasing stream data when the data is
not initialized.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index ed29026..4484242 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -102,6 +102,10 @@ EXPORT_SYMBOL(amdtp_stream_init);
  */
 void amdtp_stream_destroy(struct amdtp_stream *s)
 {
+	/* Not initialized. */
+	if (s->protocol == NULL)
+		return;
+
 	WARN_ON(amdtp_stream_running(s));
 	kfree(s->protocol);
 	mutex_destroy(&s->mutex);
-- 
2.7.3
