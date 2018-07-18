From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Nuke snd_pcm_lib_mmap_vmalloc()
Date: Wed, 18 Jul 2018 07:44:38 +0200
Message-ID: <20180718054438.25308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF7222673C7
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 07:44:50 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 96D05AF63
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 05:44:49 +0000 (UTC)
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

snd_pcm_lib_mmap_vmalloc() was supposed to be implemented with
somewhat special for vmalloc handling, but in the end, this turned to
just the default handler, i.e. NULL.  As the situation has never
changed over decades, let's rip it off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/most/sound/sound.c       | 1 -
 include/sound/pcm.h                      | 2 --
 sound/drivers/aloop.c                    | 1 -
 sound/drivers/vx/vx_pcm.c                | 2 --
 sound/firewire/bebob/bebob_pcm.c         | 1 -
 sound/firewire/dice/dice-pcm.c           | 2 --
 sound/firewire/digi00x/digi00x-pcm.c     | 1 -
 sound/firewire/fireface/ff-pcm.c         | 1 -
 sound/firewire/fireworks/fireworks_pcm.c | 1 -
 sound/firewire/isight.c                  | 1 -
 sound/firewire/motu/motu-pcm.c           | 2 --
 sound/firewire/oxfw/oxfw-pcm.c           | 2 --
 sound/firewire/tascam/tascam-pcm.c       | 1 -
 sound/mips/sgio2audio.c                  | 3 ---
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c   | 1 -
 sound/soc/codecs/rt5514-spi.c            | 1 -
 sound/usb/6fire/pcm.c                    | 1 -
 sound/usb/caiaq/audio.c                  | 1 -
 sound/usb/hiface/pcm.c                   | 1 -
 sound/usb/misc/ua101.c                   | 2 --
 sound/usb/pcm.c                          | 2 --
 21 files changed, 30 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 04c18323c2ea..89b02fc305b8 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -457,7 +457,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.trigger    = pcm_trigger,
 	.pointer    = pcm_pointer,
 	.page       = snd_pcm_lib_get_vmalloc_page,
-	.mmap       = snd_pcm_lib_mmap_vmalloc,
 };
 
 static int split_arg_list(char *buf, char **card_name, u16 *ch_num,
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index fcdf358a25f0..1206045ccf03 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1342,8 +1342,6 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 #define snd_pcm_lib_mmap_iomem	NULL
 #endif
 
-#define snd_pcm_lib_mmap_vmalloc NULL
-
 /**
  * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
  * @dma: DMA number
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 78a2fdc38531..1e34e6381baa 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -778,7 +778,6 @@ static const struct snd_pcm_ops loopback_pcm_ops = {
 	.trigger =	loopback_trigger,
 	.pointer =	loopback_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 static int loopback_pcm_new(struct loopback *loopback,
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 380a028469c4..ba80f459bdc5 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -883,7 +883,6 @@ static const struct snd_pcm_ops vx_pcm_playback_ops = {
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_playback_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 
@@ -1105,7 +1104,6 @@ static const struct snd_pcm_ops vx_pcm_capture_ops = {
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_capture_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index e6adab3ef42e..ea9b86450580 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -373,7 +373,6 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
 		.pointer	= pcm_playback_pointer,
 		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
-		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 80351b29fe0d..bb3ef5ff3488 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -412,7 +412,6 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.pointer   = capture_pointer,
 		.ack       = capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
@@ -425,7 +424,6 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.pointer   = playback_pointer,
 		.ack       = playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	unsigned int capture, playback;
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 796f4b4645f5..fdcff0460c53 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -352,7 +352,6 @@ int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
 		.pointer	= pcm_playback_pointer,
 		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
-		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index e3c16308363d..bf47f9ec8703 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -383,7 +383,6 @@ int snd_ff_create_pcm_devices(struct snd_ff *ff)
 		.pointer	= pcm_playback_pointer,
 		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
-		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 40faed5e6968..aed566d82726 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -397,7 +397,6 @@ int snd_efw_create_pcm_devices(struct snd_efw *efw)
 		.pointer	= pcm_playback_pointer,
 		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
-		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 3919e186a30b..30957477e005 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -454,7 +454,6 @@ static int isight_create_pcm(struct isight *isight)
 		.trigger   = isight_trigger,
 		.pointer   = isight_pointer,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index 4330220890e8..ab69d7e6ac05 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -363,7 +363,6 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
 		.pointer   = capture_pointer,
 		.ack       = capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
@@ -376,7 +375,6 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu)
 		.pointer   = playback_pointer,
 		.ack       = playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 3dd46285c0e2..b3f6503dd34d 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -389,7 +389,6 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 		.pointer   = pcm_capture_pointer,
 		.ack       = pcm_capture_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
@@ -402,7 +401,6 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 		.pointer   = pcm_playback_pointer,
 		.ack       = pcm_playback_ack,
 		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	unsigned int cap = 0;
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 6ec8ec634d4d..e4cc8990e195 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -279,7 +279,6 @@ int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
 		.pointer	= pcm_playback_pointer,
 		.ack		= pcm_playback_ack,
 		.page		= snd_pcm_lib_get_vmalloc_page,
-		.mmap		= snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 9fb68b35de5a..3ec9391a4736 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -685,7 +685,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
 	.page =        snd_pcm_lib_get_vmalloc_page,
-	.mmap =        snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
@@ -698,7 +697,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
 	.page =        snd_pcm_lib_get_vmalloc_page,
-	.mmap =        snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct snd_pcm_ops snd_sgio2audio_capture_ops = {
@@ -711,7 +709,6 @@ static const struct snd_pcm_ops snd_sgio2audio_capture_ops = {
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
 	.page =        snd_pcm_lib_get_vmalloc_page,
-	.mmap =        snd_pcm_lib_mmap_vmalloc,
 };
 
 /*
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
index 4a2354b5ae00..98a6863e933c 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
@@ -276,7 +276,6 @@ static const struct snd_pcm_ops pdacf_pcm_capture_ops = {
 	.trigger =	pdacf_pcm_trigger,
 	.pointer =	pdacf_pcm_capture_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 18686ffb0cd5..6478d10c4f4a 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -268,7 +268,6 @@ static const struct snd_pcm_ops rt5514_spi_pcm_ops = {
 	.hw_params	= rt5514_spi_hw_params,
 	.hw_free	= rt5514_spi_hw_free,
 	.pointer	= rt5514_spi_pcm_pointer,
-	.mmap		= snd_pcm_lib_mmap_vmalloc,
 	.page		= snd_pcm_lib_get_vmalloc_page,
 };
 
diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 2dd2518a71d3..f8ef3e2a8ca0 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -565,7 +565,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.trigger = usb6fire_pcm_trigger,
 	.pointer = usb6fire_pcm_pointer,
 	.page = snd_pcm_lib_get_vmalloc_page,
-	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
 static void usb6fire_pcm_init_urb(struct pcm_urb *urb,
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 15344d39a6cd..c6108a3d7f8f 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -348,7 +348,6 @@ static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.trigger =	snd_usb_caiaq_pcm_trigger,
 	.pointer =	snd_usb_caiaq_pcm_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 static void check_for_elapsed_periods(struct snd_usb_caiaqdev *cdev,
diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 396c317115b1..e1fbb9cc9ea7 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -523,7 +523,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.trigger = hiface_pcm_trigger,
 	.pointer = hiface_pcm_pointer,
 	.page = snd_pcm_lib_get_vmalloc_page,
-	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
 static int hiface_pcm_init_urb(struct pcm_urb *urb,
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 386fbfd5c617..a0b6d039017f 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -900,7 +900,6 @@ static const struct snd_pcm_ops capture_pcm_ops = {
 	.trigger = capture_pcm_trigger,
 	.pointer = capture_pcm_pointer,
 	.page = snd_pcm_lib_get_vmalloc_page,
-	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct snd_pcm_ops playback_pcm_ops = {
@@ -913,7 +912,6 @@ static const struct snd_pcm_ops playback_pcm_ops = {
 	.trigger = playback_pcm_trigger,
 	.pointer = playback_pcm_pointer,
 	.page = snd_pcm_lib_get_vmalloc_page,
-	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct uac_format_type_i_discrete_descriptor *
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 160f52c4871b..4b930fa47277 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1694,7 +1694,6 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.trigger =	snd_usb_substream_playback_trigger,
 	.pointer =	snd_usb_pcm_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct snd_pcm_ops snd_usb_capture_ops = {
@@ -1707,7 +1706,6 @@ static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.trigger =	snd_usb_substream_capture_trigger,
 	.pointer =	snd_usb_pcm_pointer,
 	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 static const struct snd_pcm_ops snd_usb_playback_dev_ops = {
-- 
2.18.0
