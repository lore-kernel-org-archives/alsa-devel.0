From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Don't take unresponsive D3
	transition too serious
Date: Thu,  6 Jun 2013 15:02:53 +0200
Message-ID: <1370523773-28528-2-git-send-email-tiwai@suse.de>
References: <1370523773-28528-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CD48926565A
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:02:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A35FFA566D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:02:16 +0200 (CEST)
In-Reply-To: <1370523773-28528-1-git-send-email-tiwai@suse.de>
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

When a codec is powered off, some systems don't respond properly after
D3 FG transition, while the driver still expects the response and
tries to fall back to different modes (polling and single-cmd).  When
the fallback happens, the driver stays in that mode, and falling back
to the single-cmd mode means it'll loose the unsol event handling,
too.

The unresponsiveness at D3 isn't too serious, thus this fallback is
mostly superfluous.  We can gracefully ignore the error there so that
the driver keeps the normal operation mode.

This patch adds a new bit flag for codec read/write, set in the power
transition stage, which is notified to the controller driver via a new
bus->no_response_fallback flag.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 7 ++++++-
 sound/pci/hda/hda_codec.h | 3 +++
 sound/pci/hda/hda_intel.c | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 503869a..35090b3 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -221,6 +221,8 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
  again:
 	snd_hda_power_up(codec);
 	mutex_lock(&bus->cmd_mutex);
+	if (flags & HDA_RW_NO_RESPONSE_FALLBACK)
+		bus->no_response_fallback = 1;
 	for (;;) {
 		trace_hda_send_cmd(codec, cmd);
 		err = bus->ops.command(bus, cmd);
@@ -233,6 +235,7 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
 		*res = bus->ops.get_response(bus, codec->addr);
 		trace_hda_get_response(codec, *res);
 	}
+	bus->no_response_fallback = 0;
 	mutex_unlock(&bus->cmd_mutex);
 	snd_hda_power_down(codec);
 	if (!codec_in_pm(codec) && res && *res == -1 && bus->rirb_error) {
@@ -3805,11 +3808,13 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 	hda_nid_t fg = codec->afg ? codec->afg : codec->mfg;
 	int count;
 	unsigned int state;
+	int flags = 0;
 
 	/* this delay seems necessary to avoid click noise at power-down */
 	if (power_state == AC_PWRST_D3) {
 		/* transition time less than 10ms for power down */
 		msleep(codec->epss ? 10 : 100);
+		flags = HDA_RW_NO_RESPONSE_FALLBACK;
 	}
 
 	/* repeat power states setting at most 10 times*/
@@ -3818,7 +3823,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 			codec->patch_ops.set_power_state(codec, fg,
 							 power_state);
 		else {
-			snd_hda_codec_read(codec, fg, 0,
+			snd_hda_codec_read(codec, fg, flags,
 					   AC_VERB_SET_POWER_STATE,
 					   power_state);
 			snd_hda_codec_set_power_to_all(codec, fg, power_state);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 39a658e..701c2e0 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -679,6 +679,7 @@ struct hda_bus {
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int power_keep_link_on:1; /* don't power off HDA link */
+	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 };
@@ -930,6 +931,8 @@ enum {
 	HDA_INPUT, HDA_OUTPUT
 };
 
+/* snd_hda_codec_read/write optional flags */
+#define HDA_RW_NO_RESPONSE_FALLBACK	(1 << 0)
 
 /*
  * constructors
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 49dfad4..f089fa0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -942,6 +942,9 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		}
 	}
 
+	if (!bus->no_response_fallback)
+		return -1;
+
 	if (!chip->polling_mode && chip->poll_count < 2) {
 		snd_printdd(SFX "%s: azx_get_response timeout, "
 			   "polling the codec once: last cmd=0x%08x\n",
-- 
1.8.3
