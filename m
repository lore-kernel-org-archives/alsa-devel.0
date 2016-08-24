From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: bebob: rename file with
	vendor-dependent code so that it's for Yamaha/Terratec
Date: Wed, 24 Aug 2016 21:42:42 +0900
Message-ID: <1472042563-24634-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1472042563-24634-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 89A2C26885D
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:42:49 +0200 (CEST)
In-Reply-To: <1472042563-24634-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Once Yamaha and Terratec cooperated to develop some audio and music units
on IEEE 1394 bus. On these models, the same embedded board is used, and
similar configurations are also applied.

This commit renames file for Yamaha's configuration so that it's for both
of Yamaha and Terratec.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile                                    | 5 +++--
 sound/firewire/bebob/{bebob_yamaha.c => bebob_yamaha_terratec.c} | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename sound/firewire/bebob/{bebob_yamaha.c => bebob_yamaha_terratec.c} (93%)

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index af7ed66..dd45486 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,5 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
-		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob_yamaha.o \
-		  bebob_focusrite.o bebob_maudio.o bebob.o
+		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o \
+		  bebob_yamaha_terratec.o bebob_focusrite.o bebob_maudio.o \
+		  bebob.o
 obj-$(CONFIG_SND_BEBOB) += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha_terratec.c
similarity index 93%
rename from sound/firewire/bebob/bebob_yamaha.c
rename to sound/firewire/bebob/bebob_yamaha_terratec.c
index 90d4404..5c5d7d3 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha_terratec.c
@@ -14,7 +14,7 @@
  * must be accompanied. If changing the state, a LED on the device starts to
  * blink and its sync status is false. In this state, the device sounds nothing
  * even if streaming. To start streaming at the current sampling rate is only
- * way to revocer this state. GO46 is better for stand-alone mixer.
+ * way to recover this state. GO46 is better for stand-alone mixer.
  *
  * Both of them have a capability to change its sampling rate up to 192.0kHz.
  * At 192.0kHz, the device reports 4 PCM-in, 1 MIDI-in, 6 PCM-out, 1 MIDI-out.
@@ -25,7 +25,7 @@
  * streaming with many asynchronous transactions brings sounds with noises.
  * Unfortunately current 'ffado-mixer' generated many asynchronous transaction
  * to observe device's state, mainly check cmp connection and signal format. I
- * reccomend users to close ffado-mixer at 192.0kHz if mixer is needless.
+ * recommend users to close ffado-mixer at 192.0kHz if mixer is needless.
  */
 
 static enum snd_bebob_clock_type clk_src_types[] = {
-- 
2.7.4
