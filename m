From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire: fix NULL pointer dereference
	when releasing uninitialized data of iso-resource
Date: Sun, 20 Aug 2017 15:54:26 +0900
Message-ID: <20170820065426.2414-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3D37B266BCF
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 08:54:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, "# v4 . 5+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When calling 'iso_resource_free()' for uninitialized data, this function
causes NULL pointer dereference due to its 'unit' member. This occurs when
unplugging audio and music units on IEEE 1394 bus at failure of card
registration.

This commit fixes the bug. The bug exists since kernel v4.5.

Fixes: 324540c4e05c ('ALSA: fireface: postpone sound card registration') at v4.12
Fixes: 8865a31e0fd8 ('ALSA: firewire-motu: postpone sound card registration') at v4.12
Fixes: b610386c8afb ('ALSA: firewire-tascam: deleyed registration of sound card') at v4.7
Fixes: 86c8dd7f4da3 ('ALSA: firewire-digi00x: delayed registration of sound card') at v4.7
Fixes: 6c29230e2a5f ('ALSA: oxfw: delayed registration of sound card') at v4.7
Fixes: 7d3c1d5901aa ('ALSA: fireworks: delayed registration of sound card') at v4.7
Fixes: 04a2c73c97eb ('ALSA: bebob: delayed registration of sound card') at v4.7
Fixes: b59fb1900b4f ('ALSA: dice: postpone card registration') at v4.5
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/iso-resources.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/iso-resources.c b/sound/firewire/iso-resources.c
index f0e4d502d604..066b5df666f4 100644
--- a/sound/firewire/iso-resources.c
+++ b/sound/firewire/iso-resources.c
@@ -210,9 +210,14 @@ EXPORT_SYMBOL(fw_iso_resources_update);
  */
 void fw_iso_resources_free(struct fw_iso_resources *r)
 {
-	struct fw_card *card = fw_parent_device(r->unit)->card;
+	struct fw_card *card;
 	int bandwidth, channel;
 
+	/* Not initialized. */
+	if (r->unit == NULL)
+		return;
+	card = fw_parent_device(r->unit)->card;
+
 	mutex_lock(&r->mutex);
 
 	if (r->allocated) {
-- 
2.11.0
