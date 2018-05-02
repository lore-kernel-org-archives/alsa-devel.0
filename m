From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 01/13] ALSA: dice: add cache of stream
	formats
Date: Wed,  2 May 2018 19:16:39 +0900
Message-ID: <20180502101651.26173-2-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E11022675DF
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:23 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id k11-v6so9181684pgo.10
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:23 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A previous commit 6f688268b3f4 ('ALSA: dice: purge generating channel
cache') purged cache of stream formats. DICE interface originally has
no feature to assist drivers to retrieve available formats for all of
supported sampling transmission frequencies, without changing the
frequency actually.

For later release of Dice ASICs such as TCD2210, Dice interface has
extended protocol and can support the feature. This assists drivers
to retrieve available stream formats.

This commit is a first step to regain the cache to generate PCM rules
for all of supported sampling transmission frequencies.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index da00e75e09d4..8f68976930c5 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -63,6 +63,13 @@
  */
 #define MAX_STREAMS	2
 
+enum snd_dice_rate_mode {
+	SND_DICE_RATE_MODE_LOW = 0,
+	SND_DICE_RATE_MODE_MIDDLE,
+	SND_DICE_RATE_MODE_HIGH,
+	SND_DICE_RATE_MODE_COUNT,
+};
+
 struct snd_dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -80,6 +87,10 @@ struct snd_dice {
 	unsigned int rsrv_offset;
 
 	unsigned int clock_caps;
+	unsigned int tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	unsigned int tx_midi_ports[MAX_STREAMS];
+	unsigned int rx_midi_ports[MAX_STREAMS];
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
-- 
2.14.1
