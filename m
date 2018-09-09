From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireface: fix memory leak in ff400_switch_fetching_mode()
Date: Sun,  9 Sep 2018 22:25:52 +0900
Message-ID: <20180909132552.2451-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

An allocated memory forgets to be released.

Fixes: 76fdb3a9e13 ('ALSA: fireface: add support for Fireface 400')
Cc: <stable@vger.kernel.org> # 4.12+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index ad7a0a32557d..64c3cb0fb926 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -146,6 +146,7 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 {
 	__le32 *reg;
 	int i;
+	int err;
 
 	reg = kcalloc(18, sizeof(__le32), GFP_KERNEL);
 	if (reg == NULL)
@@ -163,9 +164,11 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 			reg[i] = cpu_to_le32(0x00000001);
 	}
 
-	return snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
-				  FF400_FETCH_PCM_FRAMES, reg,
-				  sizeof(__le32) * 18, 0);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 FF400_FETCH_PCM_FRAMES, reg,
+				 sizeof(__le32) * 18, 0);
+	kfree(reg);
+	return err;
 }
 
 static void ff400_dump_sync_status(struct snd_ff *ff,
-- 
2.17.1
