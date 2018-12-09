From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireface: fix reference to wrong register for clock configuration
Date: Sun,  9 Dec 2018 17:04:19 +0900
Message-ID: <20181209080419.9554-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In an initial commit, 'SYNC_STATUS' register is referred to get
clock configuration, however this is wrong, according to my local
note at hand for reverse-engineering about packet dump. It should
be 'CLOCK_CONFIG' register. Actually, ff400_dump_clock_config()
is correctly programmed.

This commit fixes the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 76fdb3a9e13a ('ALSA: fireface: add support for Fireface 400')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 64c3cb0fb926..654a50319198 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -30,7 +30,7 @@ static int ff400_get_clock(struct snd_ff *ff, unsigned int *rate,
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 FF400_SYNC_STATUS, &reg, sizeof(reg), 0);
+				 FF400_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return err;
 	data = le32_to_cpu(reg);
-- 
2.19.1
