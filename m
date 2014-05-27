From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/12] fireworks/bebob: Improve indentation
Date: Wed, 28 May 2014 00:14:43 +0900
Message-ID: <1401203687-4189-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4493026586C
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:16 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

According to coding rule.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_midi.c         | 4 ++--
 sound/firewire/fireworks/fireworks_midi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index c04cea2..63343d5 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -143,7 +143,7 @@ int snd_bebob_create_midi_devices(struct snd_bebob *bebob)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-					&midi_capture_ops);
+				    &midi_capture_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 
@@ -154,7 +154,7 @@ int snd_bebob_create_midi_devices(struct snd_bebob *bebob)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-					&midi_playback_ops);
+				    &midi_playback_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 4a600d2..cf9c652 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -143,7 +143,7 @@ int snd_efw_create_midi_devices(struct snd_efw *efw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-					&midi_capture_ops);
+				    &midi_capture_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 
@@ -154,7 +154,7 @@ int snd_efw_create_midi_devices(struct snd_efw *efw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-					&midi_playback_ops);
+				    &midi_playback_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 
-- 
1.8.3.2
