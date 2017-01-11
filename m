From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: firewire: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:41 +0100
Message-ID: <20170111190242.12585-7-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 834F9267523
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:45 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EFFE7AC57
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 19:02:43 +0000 (UTC)
In-Reply-To: <20170111190242.12585-1-tiwai@suse.de>
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

Now snd_rawmidi_ops is maintained as a const pointer in snd_rawmidi,
we can constify the definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/bebob/bebob_midi.c         | 4 ++--
 sound/firewire/dice/dice-midi.c           | 4 ++--
 sound/firewire/digi00x/digi00x-midi.c     | 8 ++++----
 sound/firewire/fireworks/fireworks_midi.c | 4 ++--
 sound/firewire/oxfw/oxfw-midi.c           | 4 ++--
 sound/firewire/oxfw/oxfw-scs1x.c          | 4 ++--
 sound/firewire/tascam/tascam-midi.c       | 4 ++--
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 7e5fb4b990bd..3befa3eca6ef 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -120,12 +120,12 @@ static void set_midi_substream_names(struct snd_bebob *bebob,
 
 int snd_bebob_create_midi_devices(struct snd_bebob *bebob)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_capture_open,
 		.close		= midi_capture_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
 		.trigger	= midi_playback_trigger,
diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index cdf71c211342..8ff6da3c51f7 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -91,12 +91,12 @@ static void set_midi_substream_names(struct snd_dice *dice,
 
 int snd_dice_create_midi(struct snd_dice *dice)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_open,
 		.close		= midi_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_open,
 		.close		= midi_close,
 		.trigger	= midi_playback_trigger,
diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 8689c3bb4c6a..915d2a21223e 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -148,22 +148,22 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 
 int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 {
-	static struct snd_rawmidi_ops phys_capture_ops = {
+	static const struct snd_rawmidi_ops phys_capture_ops = {
 		.open		= midi_phys_open,
 		.close		= midi_phys_close,
 		.trigger	= midi_phys_capture_trigger,
 	};
-	static struct snd_rawmidi_ops phys_playback_ops = {
+	static const struct snd_rawmidi_ops phys_playback_ops = {
 		.open		= midi_phys_open,
 		.close		= midi_phys_close,
 		.trigger	= midi_phys_playback_trigger,
 	};
-	static struct snd_rawmidi_ops ctl_capture_ops = {
+	static const struct snd_rawmidi_ops ctl_capture_ops = {
 		.open		= midi_ctl_open,
 		.close		= midi_ctl_capture_close,
 		.trigger	= midi_ctl_capture_trigger,
 	};
-	static struct snd_rawmidi_ops ctl_playback_ops = {
+	static const struct snd_rawmidi_ops ctl_playback_ops = {
 		.open		= midi_ctl_open,
 		.close		= midi_ctl_playback_close,
 		.trigger	= midi_ctl_playback_trigger,
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 2873eca22bfc..f5da2cd4ce42 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -120,12 +120,12 @@ static void set_midi_substream_names(struct snd_efw *efw,
 
 int snd_efw_create_midi_devices(struct snd_efw *efw)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_capture_open,
 		.close		= midi_capture_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
 		.trigger	= midi_playback_trigger,
diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 076a1a977275..b7bbd77dfff1 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -130,12 +130,12 @@ static void set_midi_substream_names(struct snd_oxfw *oxfw,
 
 int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_capture_open,
 		.close		= midi_capture_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
 		.trigger	= midi_playback_trigger,
diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index f897c9831077..79400586b7ac 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -297,7 +297,7 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *stream, int up)
 	}
 }
 
-static struct snd_rawmidi_ops midi_capture_ops = {
+static const struct snd_rawmidi_ops midi_capture_ops = {
 	.open    = midi_capture_open,
 	.close   = midi_capture_close,
 	.trigger = midi_capture_trigger,
@@ -338,7 +338,7 @@ static void midi_playback_drain(struct snd_rawmidi_substream *stream)
 	wait_event(scs->idle_wait, scs->output_idle);
 }
 
-static struct snd_rawmidi_ops midi_playback_ops = {
+static const struct snd_rawmidi_ops midi_playback_ops = {
 	.open    = midi_playback_open,
 	.close   = midi_playback_close,
 	.trigger = midi_playback_trigger,
diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
index 7fdc71e4763e..df4f95d65925 100644
--- a/sound/firewire/tascam/tascam-midi.c
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -70,12 +70,12 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_capture_open,
 		.close		= midi_capture_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
 		.trigger	= midi_playback_trigger,
-- 
2.11.0
