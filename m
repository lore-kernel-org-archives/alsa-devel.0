From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] ALSA: asihpi: Fix duplicate const for clock sources
Date: Tue, 24 Mar 2015 11:48:24 +0100
Message-ID: <1427194104-31617-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Replace duplicated const keyword for 'sampleclock_sources' with proper
array of const pointers to const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/pci/asihpi/asihpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e5cd7be85355..1039eccbb895 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2376,7 +2376,7 @@ static int snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    Sampleclock source  controls
  ------------------------------------------------------------*/
-static const char const *sampleclock_sources[] = {
+static const char * const sampleclock_sources[] = {
 	"N/A", "Local PLL", "Digital Sync", "Word External", "Word Header",
 	"SMPTE", "Digital1", "Auto", "Network", "Invalid",
 	"Prev Module", "BLU-Link",
-- 
1.9.1
