From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: [PATCH] snd-sbxfi: implement support for 192khz
	playback/capture.
Date: Sat, 18 Oct 2008 13:37:24 -0500
Message-ID: <20081018183020.540B577DF81@carpathia.dereferenced.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id A4D2F24531
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Oct 2008 20:42:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Implements support for 192khz initialization for playback and capture.

Signed-off-by: William Pitcock <nenolod@sacredspiral.co.uk>
---
 sound/pci/sbxfi/sbxfi.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
index 4c65125..d64d462 100644
--- a/sound/pci/sbxfi/sbxfi.c
+++ b/sound/pci/sbxfi/sbxfi.c
@@ -514,7 +514,7 @@ static void sbxfi_write_amop(struct sbxfi *chip,
 static void sbxfi_playback_start(struct sbxfi *chip, struct sbxfi_port *port)
 {
 	unsigned int start, loop;
-	unsigned int ctrl, ratec;
+	unsigned int ctrl, ratec = 0;
 	struct snd_pcm_runtime *runtime;
 
 	if (port->tlb_index < 0)
@@ -523,12 +523,19 @@ static void sbxfi_playback_start(struct sbxfi *chip, struct sbxfi_port *port)
 	start = port->tlb_index * SBXFI_PAGE_SIZE;
 	loop = start + frames_to_bytes(runtime, runtime->buffer_size);
 
+	/*
+	 * ratec is the rate selection mode, 0x4c = 48000hz, 0x5c = 96000hz,
+	 * 0x6c = 192000hz.
+	 */
 	switch (runtime->rate) {
 	case 48000:
-		ratec = 0x4c; /* XXX what meaning? */
+		ratec = 0x4c;
 		break;
 	case 96000:
-		ratec = 0x5c; /* XXX what meaning? */
+		ratec = 0x5c;
+		break;
+	case 192000:
+		ratec = 0x6c;
 		break;
 	}
 	ctrl = ratec;
@@ -559,7 +566,7 @@ static void sbxfi_playback_stop(struct sbxfi *chip, struct sbxfi_port *port)
 static void sbxfi_capture_start(struct sbxfi *chip, struct sbxfi_port *port)
 {
 	unsigned int start, loop;
-	unsigned int ctrl, ratec;
+	unsigned int ctrl, ratec = 0;
 	struct snd_pcm_runtime *runtime;
 
 	if (port->tlb_index < 0)
@@ -575,6 +582,9 @@ static void sbxfi_capture_start(struct sbxfi *chip, struct sbxfi_port *port)
 	case 96000:
 		ratec = 0x5d | SRCCTL_RUN_STATE;
 		break;
+	case 192000:
+		ratec = 0x6d | SRCCTL_RUN_STATE;
+		break;
 	}
 
 	ctrl = ratec;
-- 
1.5.5.4
