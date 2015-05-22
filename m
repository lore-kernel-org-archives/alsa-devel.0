From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-lib: use dev_err() when
	detecting incoming streaming error
Date: Fri, 22 May 2015 23:21:13 +0900
Message-ID: <1432304474-6533-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C8AC7265AE5
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 16:21:18 +0200 (CEST)
In-Reply-To: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When detecting invalid value in 'dbs' field of CIP header or packet
discontinuity, current implementation reports the status by err_info().
In most cases this state is caused by model-specific issue due to
vendor's customization and should be reported to developers.

This commit use dev_err() instead of dev_info() for this purpose.
In the cases, packet streaming is aborted, thus no message floading
occurs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 29efbda..93cf93a 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -723,7 +723,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 			(cip_header[0] & CIP_DBS_MASK) >> CIP_DBS_SHIFT;
 		/* avoid division by zero */
 		if (data_block_quadlets == 0) {
-			dev_info_ratelimited(&s->unit->device,
+			dev_err(&s->unit->device,
 				"Detect invalid value in dbs field: %08X\n",
 				cip_header[0]);
 			return -EIO;
@@ -756,9 +756,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	}
 
 	if (lost) {
-		dev_info(&s->unit->device,
-			 "Detect discontinuity of CIP: %02X %02X\n",
-			 s->data_block_counter, data_block_counter);
+		dev_err(&s->unit->device,
+			"Detect discontinuity of CIP: %02X %02X\n",
+			s->data_block_counter, data_block_counter);
 		return -EIO;
 	}
 
-- 
2.1.4
