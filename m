From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/11] ALSA: dice: add cache of stream formats
Date: Wed, 25 Apr 2018 08:42:24 +0900
Message-ID: <20180424234234.6063-2-o-takashi@sakamocchi.jp>
References: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 773742676BC
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 01:43:12 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id p15so13558852pff.11
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 16:43:12 -0700 (PDT)
In-Reply-To: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/dice/dice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index da00e75e09d4..be18bc0ac1ea 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -80,6 +80,10 @@ struct snd_dice {
 	unsigned int rsrv_offset;
 
 	unsigned int clock_caps;
+	unsigned int tx_channels[MAX_STREAMS][3];
+	unsigned int rx_channels[MAX_STREAMS][3];
+	unsigned int tx_midi_ports[MAX_STREAMS];
+	unsigned int rx_midi_ports[MAX_STREAMS];
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
-- 
2.14.1
