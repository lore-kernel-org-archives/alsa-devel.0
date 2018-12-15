From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireface: fix for state to fetch PCM frames
Date: Sat, 15 Dec 2018 19:06:48 +0900
Message-ID: <20181215100648.2126-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According to my memo at hand and saved records, writing 0x00000001 to
SND_FF_REG_FETCH_PCM_FRAMES disables fetching PCM frames in corresponding
channel, however current implement uses reversed logic. This results in
muted volume in device side during playback.

This commit corrects the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 76fdb3a9e13a ('ALSA: fireface: add support for Fireface 400')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 8f34174ee813..fd257051d4a4 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -86,7 +86,7 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 	if (reg == NULL)
 		return -ENOMEM;
 
-	if (enable) {
+	if (!enable) {
 		/*
 		 * Each quadlet is corresponding to data channels in a data
 		 * blocks in reverse order. Precisely, quadlets for available
-- 
2.19.1
