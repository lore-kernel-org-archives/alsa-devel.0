From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: sb: Use IS_REACHABLE()
Date: Mon, 15 May 2017 11:33:37 +0200
Message-ID: <20170515093338.21220-2-tiwai@suse.de>
References: <20170515093338.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 547F42673DB
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:33:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E9644AC0D
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:33:40 +0000 (UTC)
In-Reply-To: <20170515093338.21220-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Replace the complex ifdef conditions with IS_REACHABLE() macro.
No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/emu8000.c | 2 +-
 sound/isa/sb/sb16.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index ec180708f160..0b5c4cf3abfa 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -1138,7 +1138,7 @@ snd_emu8000_new(struct snd_card *card, int index, long port, int seq_ports,
 		snd_emu8000_free(hw);
 		return err;
 	}
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_REACHABLE(CONFIG_SND_SEQUENCER)
 	if (snd_seq_device_new(card, index, SNDRV_SEQ_DEV_ID_EMU8000,
 			       sizeof(struct snd_emu8000*), &awe) >= 0) {
 		strcpy(awe->name, "EMU-8000");
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 3b2e4f405ff2..31ab09b3b049 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -62,7 +62,7 @@ MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB AWE 32},"
 #define SNDRV_DEBUG_IRQ
 #endif
 
-#if defined(SNDRV_SBAWE) && (defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE)))
+#if defined(SNDRV_SBAWE) && IS_REACHABLE(CONFIG_SND_SEQUENCER)
 #define SNDRV_SBAWE_EMU8000
 #endif
 
-- 
2.12.2
