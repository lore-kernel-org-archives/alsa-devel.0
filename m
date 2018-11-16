From: Colin King <colin.king@canonical.com>
Subject: [PATCH 1/5] ALSA: asihpi: clean up indentation, replace spaces with tab
Date: Fri, 16 Nov 2018 15:06:32 +0000
Message-ID: <20181116150636.5226-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The struct declaration is not indented correctly. Fix this by replacing
spaces with a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/asihpi/asihpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index a31fe1550903..aad74e809797 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1183,7 +1183,7 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
 					u32 h_stream)
 {
-  struct hpi_format hpi_format;
+	struct hpi_format hpi_format;
 	u16 format;
 	u16 err;
 	u32 h_control;
-- 
2.19.1
