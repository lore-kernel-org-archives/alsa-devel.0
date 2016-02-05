From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-tascam: remove needless
	member for control and status message
Date: Fri,  5 Feb 2016 09:56:08 +0900
Message-ID: <1454633768-17729-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA372605B8
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 01:56:13 +0100 (CET)
In-Reply-To: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Commit 3beab0f844fa added a member for control and status message, while
it's planned and not implemented yet.

This commit removes it.

Fixes: 3beab0f844fa('ALSA: firewire-tascam: add support for outgoing MIDI messages by asynchronous transaction')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 6626860..30ab77e 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -71,9 +71,6 @@ struct snd_tscm {
 	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
 	u8 running_status[TSCM_MIDI_OUT_PORT_MAX];
 	bool on_sysex[TSCM_MIDI_OUT_PORT_MAX];
-
-	/* For control messages. */
-	struct snd_firewire_tascam_status *status;
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
-- 
2.5.0
