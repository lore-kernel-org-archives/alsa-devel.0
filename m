From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: pci: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:40 +0100
Message-ID: <20170111190242.12585-6-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C7A26752C
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EE764AC4E
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
 sound/pci/ca0106/ca_midi.c    | 4 ++--
 sound/pci/cs4281.c            | 4 ++--
 sound/pci/cs46xx/cs46xx_lib.c | 4 ++--
 sound/pci/echoaudio/midi.c    | 4 ++--
 sound/pci/emu10k1/emu10k1x.c  | 4 ++--
 sound/pci/emu10k1/emumpu401.c | 4 ++--
 sound/pci/ens1370.c           | 4 ++--
 sound/pci/ice1712/ice1724.c   | 4 ++--
 sound/pci/rme9652/hdsp.c      | 4 ++--
 sound/pci/rme9652/hdspm.c     | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ca0106/ca_midi.c b/sound/pci/ca0106/ca_midi.c
index b91c7f6d19f9..4d4d385205eb 100644
--- a/sound/pci/ca0106/ca_midi.c
+++ b/sound/pci/ca0106/ca_midi.c
@@ -255,14 +255,14 @@ static void ca_midi_output_trigger(struct snd_rawmidi_substream *substream, int
 	}
 }
 
-static struct snd_rawmidi_ops ca_midi_output =
+static const struct snd_rawmidi_ops ca_midi_output =
 {
 	.open =		ca_midi_output_open,
 	.close =	ca_midi_output_close,
 	.trigger =	ca_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops ca_midi_input =
+static const struct snd_rawmidi_ops ca_midi_input =
 {
 	.open =		ca_midi_input_open,
 	.close =	ca_midi_input_close,
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 8f0f5f24e40e..fa7c51684dd2 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1767,14 +1767,14 @@ static void snd_cs4281_midi_output_trigger(struct snd_rawmidi_substream *substre
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_cs4281_midi_output =
+static const struct snd_rawmidi_ops snd_cs4281_midi_output =
 {
 	.open =		snd_cs4281_midi_output_open,
 	.close =	snd_cs4281_midi_output_close,
 	.trigger =	snd_cs4281_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_cs4281_midi_input =
+static const struct snd_rawmidi_ops snd_cs4281_midi_input =
 {
 	.open = 	snd_cs4281_midi_input_open,
 	.close =	snd_cs4281_midi_input_close,
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index fde3cd48258c..e561fd536f5b 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2683,14 +2683,14 @@ static void snd_cs46xx_midi_output_trigger(struct snd_rawmidi_substream *substre
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_cs46xx_midi_output =
+static const struct snd_rawmidi_ops snd_cs46xx_midi_output =
 {
 	.open =		snd_cs46xx_midi_output_open,
 	.close =	snd_cs46xx_midi_output_close,
 	.trigger =	snd_cs46xx_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_cs46xx_midi_input =
+static const struct snd_rawmidi_ops snd_cs46xx_midi_input =
 {
 	.open =		snd_cs46xx_midi_input_open,
 	.close =	snd_cs46xx_midi_input_close,
diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index a8fe58335ddc..8c685ddb1a41 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -288,13 +288,13 @@ static int snd_echo_midi_output_close(struct snd_rawmidi_substream *substream)
 
 
 
-static struct snd_rawmidi_ops snd_echo_midi_input = {
+static const struct snd_rawmidi_ops snd_echo_midi_input = {
 	.open = snd_echo_midi_input_open,
 	.close = snd_echo_midi_input_close,
 	.trigger = snd_echo_midi_input_trigger,
 };
 
-static struct snd_rawmidi_ops snd_echo_midi_output = {
+static const struct snd_rawmidi_ops snd_echo_midi_output = {
 	.open = snd_echo_midi_output_open,
 	.close = snd_echo_midi_output_close,
 	.trigger = snd_echo_midi_output_trigger,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 921037ed8468..32842734ada6 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1486,14 +1486,14 @@ static void snd_emu10k1x_midi_output_trigger(struct snd_rawmidi_substream *subst
 
  */
 
-static struct snd_rawmidi_ops snd_emu10k1x_midi_output =
+static const struct snd_rawmidi_ops snd_emu10k1x_midi_output =
 {
 	.open =		snd_emu10k1x_midi_output_open,
 	.close =	snd_emu10k1x_midi_output_close,
 	.trigger =	snd_emu10k1x_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_emu10k1x_midi_input =
+static const struct snd_rawmidi_ops snd_emu10k1x_midi_input =
 {
 	.open =		snd_emu10k1x_midi_input_open,
 	.close =	snd_emu10k1x_midi_input_close,
diff --git a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
index fdf2b0ada489..b6650f5c1621 100644
--- a/sound/pci/emu10k1/emumpu401.c
+++ b/sound/pci/emu10k1/emumpu401.c
@@ -308,14 +308,14 @@ static void snd_emu10k1_midi_output_trigger(struct snd_rawmidi_substream *substr
 
  */
 
-static struct snd_rawmidi_ops snd_emu10k1_midi_output =
+static const struct snd_rawmidi_ops snd_emu10k1_midi_output =
 {
 	.open =		snd_emu10k1_midi_output_open,
 	.close =	snd_emu10k1_midi_output_close,
 	.trigger =	snd_emu10k1_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_emu10k1_midi_input =
+static const struct snd_rawmidi_ops snd_emu10k1_midi_input =
 {
 	.open =		snd_emu10k1_midi_input_open,
 	.close =	snd_emu10k1_midi_input_close,
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 51736c2b5a00..164adad91650 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2317,14 +2317,14 @@ static void snd_ensoniq_midi_output_trigger(struct snd_rawmidi_substream *substr
 	spin_unlock_irqrestore(&ensoniq->reg_lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_ensoniq_midi_output =
+static const struct snd_rawmidi_ops snd_ensoniq_midi_output =
 {
 	.open =		snd_ensoniq_midi_output_open,
 	.close =	snd_ensoniq_midi_output_close,
 	.trigger =	snd_ensoniq_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_ensoniq_midi_input =
+static const struct snd_rawmidi_ops snd_ensoniq_midi_input =
 {
 	.open =		snd_ensoniq_midi_input_open,
 	.close =	snd_ensoniq_midi_input_close,
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index e5c52ed9b674..842744e7a139 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -367,7 +367,7 @@ static void vt1724_midi_output_drain(struct snd_rawmidi_substream *s)
 	} while (time_after(timeout, jiffies));
 }
 
-static struct snd_rawmidi_ops vt1724_midi_output_ops = {
+static const struct snd_rawmidi_ops vt1724_midi_output_ops = {
 	.open = vt1724_midi_output_open,
 	.close = vt1724_midi_output_close,
 	.trigger = vt1724_midi_output_trigger,
@@ -402,7 +402,7 @@ static void vt1724_midi_input_trigger(struct snd_rawmidi_substream *s, int up)
 	spin_unlock_irqrestore(&ice->reg_lock, flags);
 }
 
-static struct snd_rawmidi_ops vt1724_midi_input_ops = {
+static const struct snd_rawmidi_ops vt1724_midi_input_ops = {
 	.open = vt1724_midi_input_open,
 	.close = vt1724_midi_input_close,
 	.trigger = vt1724_midi_input_trigger,
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index b94fc6357139..fc0face6cdc6 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1510,14 +1510,14 @@ static int snd_hdsp_midi_output_close(struct snd_rawmidi_substream *substream)
 	return 0;
 }
 
-static struct snd_rawmidi_ops snd_hdsp_midi_output =
+static const struct snd_rawmidi_ops snd_hdsp_midi_output =
 {
 	.open =		snd_hdsp_midi_output_open,
 	.close =	snd_hdsp_midi_output_close,
 	.trigger =	snd_hdsp_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_hdsp_midi_input =
+static const struct snd_rawmidi_ops snd_hdsp_midi_input =
 {
 	.open =		snd_hdsp_midi_input_open,
 	.close =	snd_hdsp_midi_input_close,
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 14bbf55c1ef9..c48acdb0e186 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2043,14 +2043,14 @@ static int snd_hdspm_midi_output_close(struct snd_rawmidi_substream *substream)
 	return 0;
 }
 
-static struct snd_rawmidi_ops snd_hdspm_midi_output =
+static const struct snd_rawmidi_ops snd_hdspm_midi_output =
 {
 	.open =		snd_hdspm_midi_output_open,
 	.close =	snd_hdspm_midi_output_close,
 	.trigger =	snd_hdspm_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_hdspm_midi_input =
+static const struct snd_rawmidi_ops snd_hdspm_midi_input =
 {
 	.open =		snd_hdspm_midi_input_open,
 	.close =	snd_hdspm_midi_input_close,
-- 
2.11.0
