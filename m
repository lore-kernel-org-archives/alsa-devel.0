From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/11] ALSA: bebob: apply new enumerator to
	normalize the type of clock source
Date: Sun, 14 Jun 2015 12:49:28 +0900
Message-ID: <1434253777-433-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B4AD2604E2
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:44 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Previous commit allows this driver to detect several types of clock
source, while there's no normalized expression for it.

This commit adds a new enumerator for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 2a918ca..368b62d 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -50,9 +50,15 @@ extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
 
 /* device specific operations */
 #define SND_BEBOB_CLOCK_INTERNAL	"Internal"
+enum snd_bebob_clock_type {
+	SND_BEBOB_CLOCK_TYPE_INTERNAL = 0,
+	SND_BEBOB_CLOCK_TYPE_EXTERNAL,
+	SND_BEBOB_CLOCK_TYPE_SYT,
+};
 struct snd_bebob_clock_spec {
 	unsigned int num;
 	const char *const *labels;
+	enum snd_bebob_clock_type *types;
 	int (*get)(struct snd_bebob *bebob, unsigned int *id);
 };
 struct snd_bebob_rate_spec {
-- 
2.1.4
