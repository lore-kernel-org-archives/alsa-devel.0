From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 1/3] ALSA: hda - Make azx_attach_pcm_stream
	static
Date: Sun,  2 Mar 2014 20:43:59 -0800
Message-ID: <1393821841-4133-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f74.google.com (mail-pb0-f74.google.com
 [209.85.160.74])
 by alsa0.perex.cz (Postfix) with ESMTP id D213D2654D4
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 05:44:16 +0100 (CET)
Received: by mail-pb0-f74.google.com with SMTP id md12so399792pbc.5
 for <alsa-devel@alsa-project.org>; Sun, 02 Mar 2014 20:44:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

It is only used in hda_controller.c now.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 6156d0a..97993e1 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -971,8 +971,8 @@ static void azx_pcm_free(struct snd_pcm *pcm)
 
 #define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
 
-int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
-			  struct hda_pcm *cpcm)
+static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
+				 struct hda_pcm *cpcm)
 {
 	struct azx *chip = bus->private_data;
 	struct snd_pcm *pcm;
-- 
1.8.1.3.605.g02339dd
