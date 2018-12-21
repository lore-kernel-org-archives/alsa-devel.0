From: tom.ty89@gmail.com
Subject: [PATCH 1/1] ALSA: oxygen: initialize
	spdif_playback_enable to 0
Date: Fri, 21 Dec 2018 20:52:57 +0800
Message-ID: <5c1ce234.1c69fb81.b937c.ee4a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Tom Yan <tom.ty89@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Tom Yan <tom.ty89@gmail.com>

There's no reason for us to do that while we initialize dac_mute to
1. Also oxygen_init() has been clearing the OXYGEN_SPDIF_OUT_ENABLE
bit anyway.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index b4ef5804212d..6a743c878415 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -373,7 +373,7 @@ static void oxygen_init(struct oxygen *chip)
 	for (i = 0; i < 8; ++i)
 		chip->dac_volume[i] = chip->model.dac_volume_min;
 	chip->dac_mute = 1;
-	chip->spdif_playback_enable = 1;
+	chip->spdif_playback_enable = 0;
 	chip->spdif_bits = OXYGEN_SPDIF_C | OXYGEN_SPDIF_ORIGINAL |
 		(IEC958_AES1_CON_PCM_CODER << OXYGEN_SPDIF_CATEGORY_SHIFT);
 	chip->spdif_pcm_bits = chip->spdif_bits;
-- 
2.20.1
