From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/6] ALSA: constify snd_pcm_ops structures
Date: Fri,  2 Sep 2016 00:13:10 +0200
Message-ID: <1472767994-26269-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D5FD267295
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 00:31:09 +0200 (CEST)
In-Reply-To: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Check for snd_pcm_ops structures that are only stored in the ops field of a
snd_soc_platform_driver structure or passed as the third argument to
snd_pcm_set_ops.  The corresponding field or parameter is declared const,
so snd_pcm_ops structures that have this property can be declared as const
also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_pcm_ops i@p = { ... };

@ok1@
identifier r.i;
struct snd_soc_platform_driver e;
position p;
@@
e.ops = &i@p;

@ok2@
identifier r.i;
expression e1, e2;
position p;
@@
snd_pcm_set_ops(e1, e2, &i@p)

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_pcm_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_pcm_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/pci/als300.c               |    4 ++--
 sound/pci/als4000.c              |    4 ++--
 sound/pci/asihpi/asihpi.c        |    4 ++--
 sound/pci/atiixp.c               |    6 +++---
 sound/pci/atiixp_modem.c         |    4 ++--
 sound/pci/aw2/aw2-alsa.c         |    4 ++--
 sound/pci/azt3328.c              |    6 +++---
 sound/pci/ca0106/ca0106_main.c   |   16 ++++++++--------
 sound/pci/cmipci.c               |   10 +++++-----
 sound/pci/cs4281.c               |    4 ++--
 sound/pci/ctxfi/ctpcm.c          |    4 ++--
 sound/pci/emu10k1/emu10k1x.c     |    4 ++--
 sound/pci/emu10k1/emupcm.c       |   12 ++++++------
 sound/pci/emu10k1/p16v.c         |    4 ++--
 sound/pci/ens1370.c              |    6 +++---
 sound/pci/es1938.c               |    4 ++--
 sound/pci/es1968.c               |    4 ++--
 sound/pci/fm801.c                |    4 ++--
 sound/pci/hda/hda_controller.c   |    2 +-
 sound/pci/ice1712/ice1712.c      |   10 +++++-----
 sound/pci/ice1712/ice1724.c      |   10 +++++-----
 sound/pci/korg1212/korg1212.c    |    4 ++--
 sound/pci/lola/lola_pcm.c        |    2 +-
 sound/pci/lx6464es/lx6464es.c    |    4 ++--
 sound/pci/maestro3.c             |    4 ++--
 sound/pci/mixart/mixart.c        |    4 ++--
 sound/pci/nm256/nm256.c          |    4 ++--
 sound/pci/pcxhr/pcxhr.c          |    2 +-
 sound/pci/riptide/riptide.c      |    4 ++--
 sound/pci/rme32.c                |   16 ++++++++--------
 sound/pci/rme96.c                |    8 ++++----
 sound/pci/rme9652/hdsp.c         |    4 ++--
 sound/pci/rme9652/hdspm.c        |    2 +-
 sound/pci/rme9652/rme9652.c      |    4 ++--
 sound/pci/sonicvibes.c           |    4 ++--
 sound/pci/trident/trident_main.c |   12 ++++++------
 sound/pci/via82xx.c              |   10 +++++-----
 sound/pci/via82xx_modem.c        |    4 ++--
 sound/pci/ymfpci/ymfpci_main.c   |   10 +++++-----
 39 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index add3176..ab75601 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -563,7 +563,7 @@ static snd_pcm_uframes_t snd_als300_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(substream->runtime, current_ptr);
 }
 
-static struct snd_pcm_ops snd_als300_playback_ops = {
+static const struct snd_pcm_ops snd_als300_playback_ops = {
 	.open =		snd_als300_playback_open,
 	.close =	snd_als300_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -574,7 +574,7 @@ static struct snd_pcm_ops snd_als300_playback_ops = {
 	.pointer =	snd_als300_pointer,
 };
 
-static struct snd_pcm_ops snd_als300_capture_ops = {
+static const struct snd_pcm_ops snd_als300_capture_ops = {
 	.open =		snd_als300_capture_open,
 	.close =	snd_als300_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index ff39a0c..edabe13 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -672,7 +672,7 @@ static int snd_als4000_capture_close(struct snd_pcm_substream *substream)
 
 /******************************************************************/
 
-static struct snd_pcm_ops snd_als4000_playback_ops = {
+static const struct snd_pcm_ops snd_als4000_playback_ops = {
 	.open =		snd_als4000_playback_open,
 	.close =	snd_als4000_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -683,7 +683,7 @@ static struct snd_pcm_ops snd_als4000_playback_ops = {
 	.pointer =	snd_als4000_playback_pointer
 };
 
-static struct snd_pcm_ops snd_als4000_capture_ops = {
+static const struct snd_pcm_ops snd_als4000_capture_ops = {
 	.open =		snd_als4000_capture_open,
 	.close =	snd_als4000_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 1039ecc..976a3d2 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1138,7 +1138,7 @@ static int snd_card_asihpi_playback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_card_asihpi_playback_mmap_ops = {
+static const struct snd_pcm_ops snd_card_asihpi_playback_mmap_ops = {
 	.open = snd_card_asihpi_playback_open,
 	.close = snd_card_asihpi_playback_close,
 	.ioctl = snd_card_asihpi_playback_ioctl,
@@ -1305,7 +1305,7 @@ static int snd_card_asihpi_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
+static const struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.open = snd_card_asihpi_capture_open,
 	.close = snd_card_asihpi_capture_close,
 	.ioctl = snd_card_asihpi_capture_ioctl,
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 2ce0022..a40c918 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1148,7 +1148,7 @@ static int snd_atiixp_spdif_close(struct snd_pcm_substream *substream)
 }
 
 /* AC97 playback */
-static struct snd_pcm_ops snd_atiixp_playback_ops = {
+static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 	.open =		snd_atiixp_playback_open,
 	.close =	snd_atiixp_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1160,7 +1160,7 @@ static struct snd_pcm_ops snd_atiixp_playback_ops = {
 };
 
 /* AC97 capture */
-static struct snd_pcm_ops snd_atiixp_capture_ops = {
+static const struct snd_pcm_ops snd_atiixp_capture_ops = {
 	.open =		snd_atiixp_capture_open,
 	.close =	snd_atiixp_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1172,7 +1172,7 @@ static struct snd_pcm_ops snd_atiixp_capture_ops = {
 };
 
 /* SPDIF playback */
-static struct snd_pcm_ops snd_atiixp_spdif_ops = {
+static const struct snd_pcm_ops snd_atiixp_spdif_ops = {
 	.open =		snd_atiixp_spdif_open,
 	.close =	snd_atiixp_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index c534552..40152fe 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -947,7 +947,7 @@ static int snd_atiixp_capture_close(struct snd_pcm_substream *substream)
 
 
 /* AC97 playback */
-static struct snd_pcm_ops snd_atiixp_playback_ops = {
+static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 	.open =		snd_atiixp_playback_open,
 	.close =	snd_atiixp_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -959,7 +959,7 @@ static struct snd_pcm_ops snd_atiixp_playback_ops = {
 };
 
 /* AC97 capture */
-static struct snd_pcm_ops snd_atiixp_capture_ops = {
+static const struct snd_pcm_ops snd_atiixp_capture_ops = {
 	.open =		snd_atiixp_capture_open,
 	.close =	snd_atiixp_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 1677143..57bbb87 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -179,7 +179,7 @@ static struct pci_driver aw2_driver = {
 module_pci_driver(aw2_driver);
 
 /* operators for playback PCM alsa interface */
-static struct snd_pcm_ops snd_aw2_playback_ops = {
+static const struct snd_pcm_ops snd_aw2_playback_ops = {
 	.open = snd_aw2_pcm_playback_open,
 	.close = snd_aw2_pcm_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -191,7 +191,7 @@ static struct snd_pcm_ops snd_aw2_playback_ops = {
 };
 
 /* operators for capture PCM alsa interface */
-static struct snd_pcm_ops snd_aw2_capture_ops = {
+static const struct snd_pcm_ops snd_aw2_capture_ops = {
 	.open = snd_aw2_pcm_capture_open,
 	.close = snd_aw2_pcm_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 5e2ef0b..80c4a44 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2090,7 +2090,7 @@ snd_azf3328_pcm_close(struct snd_pcm_substream *substream
 
 /******************************************************************/
 
-static struct snd_pcm_ops snd_azf3328_playback_ops = {
+static const struct snd_pcm_ops snd_azf3328_playback_ops = {
 	.open =		snd_azf3328_pcm_playback_open,
 	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -2101,7 +2101,7 @@ static struct snd_pcm_ops snd_azf3328_playback_ops = {
 	.pointer =	snd_azf3328_pcm_pointer
 };
 
-static struct snd_pcm_ops snd_azf3328_capture_ops = {
+static const struct snd_pcm_ops snd_azf3328_capture_ops = {
 	.open =		snd_azf3328_pcm_capture_open,
 	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -2112,7 +2112,7 @@ static struct snd_pcm_ops snd_azf3328_capture_ops = {
 	.pointer =	snd_azf3328_pcm_pointer
 };
 
-static struct snd_pcm_ops snd_azf3328_i2s_out_ops = {
+static const struct snd_pcm_ops snd_azf3328_i2s_out_ops = {
 	.open =		snd_azf3328_pcm_i2s_out_open,
 	.close =	snd_azf3328_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index d3cd956..6165a57 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1109,7 +1109,7 @@ snd_ca0106_pcm_pointer_capture(struct snd_pcm_substream *substream)
 }
 
 /* operators */
-static struct snd_pcm_ops snd_ca0106_playback_front_ops = {
+static const struct snd_pcm_ops snd_ca0106_playback_front_ops = {
 	.open =        snd_ca0106_pcm_open_playback_front,
 	.close =       snd_ca0106_pcm_close_playback,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -1120,7 +1120,7 @@ static struct snd_pcm_ops snd_ca0106_playback_front_ops = {
 	.pointer =     snd_ca0106_pcm_pointer_playback,
 };
 
-static struct snd_pcm_ops snd_ca0106_capture_0_ops = {
+static const struct snd_pcm_ops snd_ca0106_capture_0_ops = {
 	.open =        snd_ca0106_pcm_open_0_capture,
 	.close =       snd_ca0106_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -1131,7 +1131,7 @@ static struct snd_pcm_ops snd_ca0106_capture_0_ops = {
 	.pointer =     snd_ca0106_pcm_pointer_capture,
 };
 
-static struct snd_pcm_ops snd_ca0106_capture_1_ops = {
+static const struct snd_pcm_ops snd_ca0106_capture_1_ops = {
 	.open =        snd_ca0106_pcm_open_1_capture,
 	.close =       snd_ca0106_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -1142,7 +1142,7 @@ static struct snd_pcm_ops snd_ca0106_capture_1_ops = {
 	.pointer =     snd_ca0106_pcm_pointer_capture,
 };
 
-static struct snd_pcm_ops snd_ca0106_capture_2_ops = {
+static const struct snd_pcm_ops snd_ca0106_capture_2_ops = {
 	.open =        snd_ca0106_pcm_open_2_capture,
 	.close =       snd_ca0106_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -1153,7 +1153,7 @@ static struct snd_pcm_ops snd_ca0106_capture_2_ops = {
 	.pointer =     snd_ca0106_pcm_pointer_capture,
 };
 
-static struct snd_pcm_ops snd_ca0106_capture_3_ops = {
+static const struct snd_pcm_ops snd_ca0106_capture_3_ops = {
 	.open =        snd_ca0106_pcm_open_3_capture,
 	.close =       snd_ca0106_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -1164,7 +1164,7 @@ static struct snd_pcm_ops snd_ca0106_capture_3_ops = {
 	.pointer =     snd_ca0106_pcm_pointer_capture,
 };
 
-static struct snd_pcm_ops snd_ca0106_playback_center_lfe_ops = {
+static const struct snd_pcm_ops snd_ca0106_playback_center_lfe_ops = {
         .open =         snd_ca0106_pcm_open_playback_center_lfe,
         .close =        snd_ca0106_pcm_close_playback,
         .ioctl =        snd_pcm_lib_ioctl,
@@ -1175,7 +1175,7 @@ static struct snd_pcm_ops snd_ca0106_playback_center_lfe_ops = {
         .pointer =      snd_ca0106_pcm_pointer_playback, 
 };
 
-static struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
+static const struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
         .open =         snd_ca0106_pcm_open_playback_unknown,
         .close =        snd_ca0106_pcm_close_playback,
         .ioctl =        snd_pcm_lib_ioctl,
@@ -1186,7 +1186,7 @@ static struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
         .pointer =      snd_ca0106_pcm_pointer_playback, 
 };
 
-static struct snd_pcm_ops snd_ca0106_playback_rear_ops = {
+static const struct snd_pcm_ops snd_ca0106_playback_rear_ops = {
         .open =         snd_ca0106_pcm_open_playback_rear,
         .close =        snd_ca0106_pcm_close_playback,
         .ioctl =        snd_pcm_lib_ioctl,
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 24cdcba..73f5935 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1838,7 +1838,7 @@ static int snd_cmipci_capture_spdif_close(struct snd_pcm_substream *substream)
 /*
  */
 
-static struct snd_pcm_ops snd_cmipci_playback_ops = {
+static const struct snd_pcm_ops snd_cmipci_playback_ops = {
 	.open =		snd_cmipci_playback_open,
 	.close =	snd_cmipci_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1849,7 +1849,7 @@ static struct snd_pcm_ops snd_cmipci_playback_ops = {
 	.pointer =	snd_cmipci_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_cmipci_capture_ops = {
+static const struct snd_pcm_ops snd_cmipci_capture_ops = {
 	.open =		snd_cmipci_capture_open,
 	.close =	snd_cmipci_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1860,7 +1860,7 @@ static struct snd_pcm_ops snd_cmipci_capture_ops = {
 	.pointer =	snd_cmipci_capture_pointer,
 };
 
-static struct snd_pcm_ops snd_cmipci_playback2_ops = {
+static const struct snd_pcm_ops snd_cmipci_playback2_ops = {
 	.open =		snd_cmipci_playback2_open,
 	.close =	snd_cmipci_playback2_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1871,7 +1871,7 @@ static struct snd_pcm_ops snd_cmipci_playback2_ops = {
 	.pointer =	snd_cmipci_capture_pointer,	/* channel B */
 };
 
-static struct snd_pcm_ops snd_cmipci_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_cmipci_playback_spdif_ops = {
 	.open =		snd_cmipci_playback_spdif_open,
 	.close =	snd_cmipci_playback_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1882,7 +1882,7 @@ static struct snd_pcm_ops snd_cmipci_playback_spdif_ops = {
 	.pointer =	snd_cmipci_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_cmipci_capture_spdif_ops = {
+static const struct snd_pcm_ops snd_cmipci_capture_spdif_ops = {
 	.open =		snd_cmipci_capture_spdif_open,
 	.close =	snd_cmipci_capture_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index c296fd0..615d8a9 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -951,7 +951,7 @@ static int snd_cs4281_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_cs4281_playback_ops = {
+static const struct snd_pcm_ops snd_cs4281_playback_ops = {
 	.open =		snd_cs4281_playback_open,
 	.close =	snd_cs4281_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -962,7 +962,7 @@ static struct snd_pcm_ops snd_cs4281_playback_ops = {
 	.pointer =	snd_cs4281_pointer,
 };
 
-static struct snd_pcm_ops snd_cs4281_capture_ops = {
+static const struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.open =		snd_cs4281_capture_open,
 	.close =	snd_cs4281_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/ctxfi/ctpcm.c b/sound/pci/ctxfi/ctpcm.c
index d86c474..9749780 100644
--- a/sound/pci/ctxfi/ctpcm.c
+++ b/sound/pci/ctxfi/ctpcm.c
@@ -372,7 +372,7 @@ ct_pcm_capture_pointer(struct snd_pcm_substream *substream)
 }
 
 /* PCM operators for playback */
-static struct snd_pcm_ops ct_pcm_playback_ops = {
+static const struct snd_pcm_ops ct_pcm_playback_ops = {
 	.open	 	= ct_pcm_playback_open,
 	.close		= ct_pcm_playback_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -385,7 +385,7 @@ static struct snd_pcm_ops ct_pcm_playback_ops = {
 };
 
 /* PCM operators for capture */
-static struct snd_pcm_ops ct_pcm_capture_ops = {
+static const struct snd_pcm_ops ct_pcm_capture_ops = {
 	.open	 	= ct_pcm_capture_open,
 	.close		= ct_pcm_capture_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 6d1b98d..921037e 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -548,7 +548,7 @@ snd_emu10k1x_pcm_pointer(struct snd_pcm_substream *substream)
 }
 
 /* operators */
-static struct snd_pcm_ops snd_emu10k1x_playback_ops = {
+static const struct snd_pcm_ops snd_emu10k1x_playback_ops = {
 	.open =        snd_emu10k1x_playback_open,
 	.close =       snd_emu10k1x_playback_close,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -694,7 +694,7 @@ snd_emu10k1x_pcm_pointer_capture(struct snd_pcm_substream *substream)
 	return ptr;
 }
 
-static struct snd_pcm_ops snd_emu10k1x_capture_ops = {
+static const struct snd_pcm_ops snd_emu10k1x_capture_ops = {
 	.open =        snd_emu10k1x_pcm_open_capture,
 	.close =       snd_emu10k1x_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 14a305b..37be1e1 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1364,7 +1364,7 @@ static int snd_emu10k1_capture_efx_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_emu10k1_playback_ops = {
+static const struct snd_pcm_ops snd_emu10k1_playback_ops = {
 	.open =			snd_emu10k1_playback_open,
 	.close =		snd_emu10k1_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1376,7 +1376,7 @@ static struct snd_pcm_ops snd_emu10k1_playback_ops = {
 	.page =			snd_pcm_sgbuf_ops_page,
 };
 
-static struct snd_pcm_ops snd_emu10k1_capture_ops = {
+static const struct snd_pcm_ops snd_emu10k1_capture_ops = {
 	.open =			snd_emu10k1_capture_open,
 	.close =		snd_emu10k1_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1388,7 +1388,7 @@ static struct snd_pcm_ops snd_emu10k1_capture_ops = {
 };
 
 /* EFX playback */
-static struct snd_pcm_ops snd_emu10k1_efx_playback_ops = {
+static const struct snd_pcm_ops snd_emu10k1_efx_playback_ops = {
 	.open =			snd_emu10k1_efx_playback_open,
 	.close =		snd_emu10k1_efx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1455,7 +1455,7 @@ int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device)
 }
 
 
-static struct snd_pcm_ops snd_emu10k1_capture_mic_ops = {
+static const struct snd_pcm_ops snd_emu10k1_capture_mic_ops = {
 	.open =			snd_emu10k1_capture_mic_open,
 	.close =		snd_emu10k1_capture_mic_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1550,7 +1550,7 @@ static struct snd_kcontrol_new snd_emu10k1_pcm_efx_voices_mask = {
 	.put = snd_emu10k1_pcm_efx_voices_mask_put
 };
 
-static struct snd_pcm_ops snd_emu10k1_capture_efx_ops = {
+static const struct snd_pcm_ops snd_emu10k1_capture_efx_ops = {
 	.open =			snd_emu10k1_capture_efx_open,
 	.close =		snd_emu10k1_capture_efx_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1791,7 +1791,7 @@ static int snd_emu10k1_fx8010_playback_close(struct snd_pcm_substream *substream
 	return 0;
 }
 
-static struct snd_pcm_ops snd_emu10k1_fx8010_playback_ops = {
+static const struct snd_pcm_ops snd_emu10k1_fx8010_playback_ops = {
 	.open =			snd_emu10k1_fx8010_playback_open,
 	.close =		snd_emu10k1_fx8010_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 3c60b43..fd9ab44 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -601,7 +601,7 @@ snd_p16v_pcm_pointer_capture(struct snd_pcm_substream *substream)
 }
 
 /* operators */
-static struct snd_pcm_ops snd_p16v_playback_front_ops = {
+static const struct snd_pcm_ops snd_p16v_playback_front_ops = {
 	.open =        snd_p16v_pcm_open_playback_front,
 	.close =       snd_p16v_pcm_close_playback,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -612,7 +612,7 @@ static struct snd_pcm_ops snd_p16v_playback_front_ops = {
 	.pointer =     snd_p16v_pcm_pointer_playback,
 };
 
-static struct snd_pcm_ops snd_p16v_capture_ops = {
+static const struct snd_pcm_ops snd_p16v_capture_ops = {
 	.open =        snd_p16v_pcm_open_capture,
 	.close =       snd_p16v_pcm_close_capture,
 	.ioctl =       snd_pcm_lib_ioctl,
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 626cd21..7e760fe 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1227,7 +1227,7 @@ static int snd_ensoniq_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ensoniq_playback1_ops = {
+static const struct snd_pcm_ops snd_ensoniq_playback1_ops = {
 	.open =		snd_ensoniq_playback1_open,
 	.close =	snd_ensoniq_playback1_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1238,7 +1238,7 @@ static struct snd_pcm_ops snd_ensoniq_playback1_ops = {
 	.pointer =	snd_ensoniq_playback1_pointer,
 };
 
-static struct snd_pcm_ops snd_ensoniq_playback2_ops = {
+static const struct snd_pcm_ops snd_ensoniq_playback2_ops = {
 	.open =		snd_ensoniq_playback2_open,
 	.close =	snd_ensoniq_playback2_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1249,7 +1249,7 @@ static struct snd_pcm_ops snd_ensoniq_playback2_ops = {
 	.pointer =	snd_ensoniq_playback2_pointer,
 };
 
-static struct snd_pcm_ops snd_ensoniq_capture_ops = {
+static const struct snd_pcm_ops snd_ensoniq_capture_ops = {
 	.open =		snd_ensoniq_capture_open,
 	.close =	snd_ensoniq_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 8963d76..6813558 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -992,7 +992,7 @@ static int snd_es1938_playback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_es1938_playback_ops = {
+static const struct snd_pcm_ops snd_es1938_playback_ops = {
 	.open =		snd_es1938_playback_open,
 	.close =	snd_es1938_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1003,7 +1003,7 @@ static struct snd_pcm_ops snd_es1938_playback_ops = {
 	.pointer =	snd_es1938_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_es1938_capture_ops = {
+static const struct snd_pcm_ops snd_es1938_capture_ops = {
 	.open =		snd_es1938_capture_open,
 	.close =	snd_es1938_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 514f260..8146fb7 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1677,7 +1677,7 @@ static int snd_es1968_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_es1968_playback_ops = {
+static const struct snd_pcm_ops snd_es1968_playback_ops = {
 	.open =		snd_es1968_playback_open,
 	.close =	snd_es1968_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1688,7 +1688,7 @@ static struct snd_pcm_ops snd_es1968_playback_ops = {
 	.pointer =	snd_es1968_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_es1968_capture_ops = {
+static const struct snd_pcm_ops snd_es1968_capture_ops = {
 	.open =		snd_es1968_capture_open,
 	.close =	snd_es1968_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index bade9b9..c47287d 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -691,7 +691,7 @@ static int snd_fm801_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_fm801_playback_ops = {
+static const struct snd_pcm_ops snd_fm801_playback_ops = {
 	.open =		snd_fm801_playback_open,
 	.close =	snd_fm801_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -702,7 +702,7 @@ static struct snd_pcm_ops snd_fm801_playback_ops = {
 	.pointer =	snd_fm801_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_fm801_capture_ops = {
+static const struct snd_pcm_ops snd_fm801_capture_ops = {
 	.open =		snd_fm801_capture_open,
 	.close =	snd_fm801_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 2ad3b44..5008785 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -696,7 +696,7 @@ static int azx_pcm_mmap(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_default_mmap(substream, area);
 }
 
-static struct snd_pcm_ops azx_pcm_ops = {
+static const struct snd_pcm_ops azx_pcm_ops = {
 	.open = azx_pcm_open,
 	.close = azx_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 8ae3bb7..b4aa4c1 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -847,7 +847,7 @@ static int snd_ice1712_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ice1712_playback_ops = {
+static const struct snd_pcm_ops snd_ice1712_playback_ops = {
 	.open =		snd_ice1712_playback_open,
 	.close =	snd_ice1712_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -858,7 +858,7 @@ static struct snd_pcm_ops snd_ice1712_playback_ops = {
 	.pointer =	snd_ice1712_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_ice1712_playback_ds_ops = {
+static const struct snd_pcm_ops snd_ice1712_playback_ds_ops = {
 	.open =		snd_ice1712_playback_ds_open,
 	.close =	snd_ice1712_playback_ds_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -869,7 +869,7 @@ static struct snd_pcm_ops snd_ice1712_playback_ds_ops = {
 	.pointer =	snd_ice1712_playback_ds_pointer,
 };
 
-static struct snd_pcm_ops snd_ice1712_capture_ops = {
+static const struct snd_pcm_ops snd_ice1712_capture_ops = {
 	.open =		snd_ice1712_capture_open,
 	.close =	snd_ice1712_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1228,7 +1228,7 @@ static int snd_ice1712_capture_pro_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ice1712_playback_pro_ops = {
+static const struct snd_pcm_ops snd_ice1712_playback_pro_ops = {
 	.open =		snd_ice1712_playback_pro_open,
 	.close =	snd_ice1712_playback_pro_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1239,7 +1239,7 @@ static struct snd_pcm_ops snd_ice1712_playback_pro_ops = {
 	.pointer =	snd_ice1712_playback_pro_pointer,
 };
 
-static struct snd_pcm_ops snd_ice1712_capture_pro_ops = {
+static const struct snd_pcm_ops snd_ice1712_capture_pro_ops = {
 	.open =		snd_ice1712_capture_pro_open,
 	.close =	snd_ice1712_capture_pro_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 0b22c00..cd68114 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1113,7 +1113,7 @@ static int snd_vt1724_capture_pro_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_vt1724_playback_pro_ops = {
+static const struct snd_pcm_ops snd_vt1724_playback_pro_ops = {
 	.open =		snd_vt1724_playback_pro_open,
 	.close =	snd_vt1724_playback_pro_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1124,7 +1124,7 @@ static struct snd_pcm_ops snd_vt1724_playback_pro_ops = {
 	.pointer =	snd_vt1724_playback_pro_pointer,
 };
 
-static struct snd_pcm_ops snd_vt1724_capture_pro_ops = {
+static const struct snd_pcm_ops snd_vt1724_capture_pro_ops = {
 	.open =		snd_vt1724_capture_pro_open,
 	.close =	snd_vt1724_capture_pro_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1292,7 +1292,7 @@ static int snd_vt1724_capture_spdif_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_vt1724_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_vt1724_playback_spdif_ops = {
 	.open =		snd_vt1724_playback_spdif_open,
 	.close =	snd_vt1724_playback_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1303,7 +1303,7 @@ static struct snd_pcm_ops snd_vt1724_playback_spdif_ops = {
 	.pointer =	snd_vt1724_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_vt1724_capture_spdif_ops = {
+static const struct snd_pcm_ops snd_vt1724_capture_spdif_ops = {
 	.open =		snd_vt1724_capture_spdif_open,
 	.close =	snd_vt1724_capture_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1437,7 +1437,7 @@ static int snd_vt1724_playback_indep_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_vt1724_playback_indep_ops = {
+static const struct snd_pcm_ops snd_vt1724_playback_indep_ops = {
 	.open =		snd_vt1724_playback_indep_open,
 	.close =	snd_vt1724_playback_indep_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 9e1ad11..565f7f5 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1681,7 +1681,7 @@ static int snd_korg1212_capture_copy(struct snd_pcm_substream *substream,
 	return snd_korg1212_copy_to(korg1212, dst, pos, count, 0, korg1212->channels * 2);
 }
 
-static struct snd_pcm_ops snd_korg1212_playback_ops = {
+static const struct snd_pcm_ops snd_korg1212_playback_ops = {
         .open =		snd_korg1212_playback_open,
         .close =	snd_korg1212_playback_close,
         .ioctl =	snd_korg1212_ioctl,
@@ -1693,7 +1693,7 @@ static struct snd_pcm_ops snd_korg1212_playback_ops = {
         .silence =	snd_korg1212_playback_silence,
 };
 
-static struct snd_pcm_ops snd_korg1212_capture_ops = {
+static const struct snd_pcm_ops snd_korg1212_capture_ops = {
 	.open =		snd_korg1212_capture_open,
 	.close =	snd_korg1212_capture_close,
 	.ioctl =	snd_korg1212_ioctl,
diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index 3bd6985..1268ba3 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -586,7 +586,7 @@ void lola_pcm_update(struct lola *chip, struct lola_pcm *pcm, unsigned int bits)
 	}
 }
 
-static struct snd_pcm_ops lola_pcm_ops = {
+static const struct snd_pcm_ops lola_pcm_ops = {
 	.open = lola_pcm_open,
 	.close = lola_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 8b8e2e5..c0f0c34 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -804,7 +804,7 @@ mac_ready:
 	return err;
 }
 
-static struct snd_pcm_ops lx_ops_playback = {
+static const struct snd_pcm_ops lx_ops_playback = {
 	.open      = lx_pcm_open,
 	.close     = lx_pcm_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -815,7 +815,7 @@ static struct snd_pcm_ops lx_ops_playback = {
 	.pointer   = lx_pcm_stream_pointer,
 };
 
-static struct snd_pcm_ops lx_ops_capture = {
+static const struct snd_pcm_ops lx_ops_capture = {
 	.open      = lx_pcm_open,
 	.close     = lx_pcm_close,
 	.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 17ae926..cafea6d 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1834,7 +1834,7 @@ snd_m3_capture_close(struct snd_pcm_substream *subs)
  * create pcm instance
  */
 
-static struct snd_pcm_ops snd_m3_playback_ops = {
+static const struct snd_pcm_ops snd_m3_playback_ops = {
 	.open =		snd_m3_playback_open,
 	.close =	snd_m3_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1845,7 +1845,7 @@ static struct snd_pcm_ops snd_m3_playback_ops = {
 	.pointer =	snd_m3_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_m3_capture_ops = {
+static const struct snd_pcm_ops snd_m3_capture_ops = {
 	.open =		snd_m3_capture_open,
 	.close =	snd_m3_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 25c0ddd..80d4399 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -922,7 +922,7 @@ static snd_pcm_uframes_t snd_mixart_stream_pointer(struct snd_pcm_substream *sub
 
 
 
-static struct snd_pcm_ops snd_mixart_playback_ops = {
+static const struct snd_pcm_ops snd_mixart_playback_ops = {
 	.open      = snd_mixart_playback_open,
 	.close     = snd_mixart_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -933,7 +933,7 @@ static struct snd_pcm_ops snd_mixart_playback_ops = {
 	.pointer   = snd_mixart_stream_pointer,
 };
 
-static struct snd_pcm_ops snd_mixart_capture_ops = {
+static const struct snd_pcm_ops snd_mixart_capture_ops = {
 	.open      = snd_mixart_capture_open,
 	.close     = snd_mixart_close,
 	.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 4735e27..103fe31 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -902,7 +902,7 @@ snd_nm256_capture_close(struct snd_pcm_substream *substream)
 /*
  * create a pcm instance
  */
-static struct snd_pcm_ops snd_nm256_playback_ops = {
+static const struct snd_pcm_ops snd_nm256_playback_ops = {
 	.open =		snd_nm256_playback_open,
 	.close =	snd_nm256_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -917,7 +917,7 @@ static struct snd_pcm_ops snd_nm256_playback_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_nm256_capture_ops = {
+static const struct snd_pcm_ops snd_nm256_capture_ops = {
 	.open =		snd_nm256_capture_open,
 	.close =	snd_nm256_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 9293235..bb7eee9 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1146,7 +1146,7 @@ static snd_pcm_uframes_t pcxhr_stream_pointer(struct snd_pcm_substream *subs)
 }
 
 
-static struct snd_pcm_ops pcxhr_ops = {
+static const struct snd_pcm_ops pcxhr_ops = {
 	.open      = pcxhr_open,
 	.close     = pcxhr_close,
 	.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 067a912..ae41fcb 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1669,7 +1669,7 @@ static int snd_riptide_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_riptide_playback_ops = {
+static const struct snd_pcm_ops snd_riptide_playback_ops = {
 	.open = snd_riptide_playback_open,
 	.close = snd_riptide_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -1680,7 +1680,7 @@ static struct snd_pcm_ops snd_riptide_playback_ops = {
 	.trigger = snd_riptide_trigger,
 	.pointer = snd_riptide_pointer,
 };
-static struct snd_pcm_ops snd_riptide_capture_ops = {
+static const struct snd_pcm_ops snd_riptide_capture_ops = {
 	.open = snd_riptide_capture_open,
 	.close = snd_riptide_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index cd94ac5..96d15db 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1196,7 +1196,7 @@ snd_rme32_capture_fd_pointer(struct snd_pcm_substream *substream)
 }
 
 /* for halfduplex mode */
-static struct snd_pcm_ops snd_rme32_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_rme32_playback_spdif_ops = {
 	.open =		snd_rme32_playback_spdif_open,
 	.close =	snd_rme32_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1210,7 +1210,7 @@ static struct snd_pcm_ops snd_rme32_playback_spdif_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme32_capture_spdif_ops = {
+static const struct snd_pcm_ops snd_rme32_capture_spdif_ops = {
 	.open =		snd_rme32_capture_spdif_open,
 	.close =	snd_rme32_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1223,7 +1223,7 @@ static struct snd_pcm_ops snd_rme32_capture_spdif_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme32_playback_adat_ops = {
+static const struct snd_pcm_ops snd_rme32_playback_adat_ops = {
 	.open =		snd_rme32_playback_adat_open,
 	.close =	snd_rme32_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1236,7 +1236,7 @@ static struct snd_pcm_ops snd_rme32_playback_adat_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme32_capture_adat_ops = {
+static const struct snd_pcm_ops snd_rme32_capture_adat_ops = {
 	.open =		snd_rme32_capture_adat_open,
 	.close =	snd_rme32_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1249,7 +1249,7 @@ static struct snd_pcm_ops snd_rme32_capture_adat_ops = {
 };
 
 /* for fullduplex mode */
-static struct snd_pcm_ops snd_rme32_playback_spdif_fd_ops = {
+static const struct snd_pcm_ops snd_rme32_playback_spdif_fd_ops = {
 	.open =		snd_rme32_playback_spdif_open,
 	.close =	snd_rme32_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1261,7 +1261,7 @@ static struct snd_pcm_ops snd_rme32_playback_spdif_fd_ops = {
 	.ack =		snd_rme32_playback_fd_ack,
 };
 
-static struct snd_pcm_ops snd_rme32_capture_spdif_fd_ops = {
+static const struct snd_pcm_ops snd_rme32_capture_spdif_fd_ops = {
 	.open =		snd_rme32_capture_spdif_open,
 	.close =	snd_rme32_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1273,7 +1273,7 @@ static struct snd_pcm_ops snd_rme32_capture_spdif_fd_ops = {
 	.ack =		snd_rme32_capture_fd_ack,
 };
 
-static struct snd_pcm_ops snd_rme32_playback_adat_fd_ops = {
+static const struct snd_pcm_ops snd_rme32_playback_adat_fd_ops = {
 	.open =		snd_rme32_playback_adat_open,
 	.close =	snd_rme32_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1284,7 +1284,7 @@ static struct snd_pcm_ops snd_rme32_playback_adat_fd_ops = {
 	.ack =		snd_rme32_playback_fd_ack,
 };
 
-static struct snd_pcm_ops snd_rme32_capture_adat_fd_ops = {
+static const struct snd_pcm_ops snd_rme32_capture_adat_fd_ops = {
 	.open =		snd_rme32_capture_adat_open,
 	.close =	snd_rme32_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 41c31db..05b9da3 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1505,7 +1505,7 @@ snd_rme96_capture_pointer(struct snd_pcm_substream *substream)
 	return snd_rme96_capture_ptr(rme96);
 }
 
-static struct snd_pcm_ops snd_rme96_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_rme96_playback_spdif_ops = {
 	.open =		snd_rme96_playback_spdif_open,
 	.close =	snd_rme96_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1518,7 +1518,7 @@ static struct snd_pcm_ops snd_rme96_playback_spdif_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme96_capture_spdif_ops = {
+static const struct snd_pcm_ops snd_rme96_capture_spdif_ops = {
 	.open =		snd_rme96_capture_spdif_open,
 	.close =	snd_rme96_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1530,7 +1530,7 @@ static struct snd_pcm_ops snd_rme96_capture_spdif_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme96_playback_adat_ops = {
+static const struct snd_pcm_ops snd_rme96_playback_adat_ops = {
 	.open =		snd_rme96_playback_adat_open,
 	.close =	snd_rme96_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1543,7 +1543,7 @@ static struct snd_pcm_ops snd_rme96_playback_adat_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static struct snd_pcm_ops snd_rme96_capture_adat_ops = {
+static const struct snd_pcm_ops snd_rme96_capture_adat_ops = {
 	.open =		snd_rme96_capture_adat_open,
 	.close =	snd_rme96_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 7c8941b..b94fc63 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4861,7 +4861,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 	return 0;
 }
 
-static struct snd_pcm_ops snd_hdsp_playback_ops = {
+static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.open =		snd_hdsp_playback_open,
 	.close =	snd_hdsp_playback_release,
 	.ioctl =	snd_hdsp_ioctl,
@@ -4873,7 +4873,7 @@ static struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.silence =	snd_hdsp_hw_silence,
 };
 
-static struct snd_pcm_ops snd_hdsp_capture_ops = {
+static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.open =		snd_hdsp_capture_open,
 	.close =	snd_hdsp_capture_release,
 	.ioctl =	snd_hdsp_ioctl,
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 0e51a00..14bbf55 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6361,7 +6361,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 	return 0;
 }
 
-static struct snd_pcm_ops snd_hdspm_ops = {
+static const struct snd_pcm_ops snd_hdspm_ops = {
 	.open = snd_hdspm_open,
 	.close = snd_hdspm_release,
 	.ioctl = snd_hdspm_ioctl,
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index fdbc0aa..55172c6 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2368,7 +2368,7 @@ static int snd_rme9652_capture_release(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_rme9652_playback_ops = {
+static const struct snd_pcm_ops snd_rme9652_playback_ops = {
 	.open =		snd_rme9652_playback_open,
 	.close =	snd_rme9652_playback_release,
 	.ioctl =	snd_rme9652_ioctl,
@@ -2380,7 +2380,7 @@ static struct snd_pcm_ops snd_rme9652_playback_ops = {
 	.silence =	snd_rme9652_hw_silence,
 };
 
-static struct snd_pcm_ops snd_rme9652_capture_ops = {
+static const struct snd_pcm_ops snd_rme9652_capture_ops = {
 	.open =		snd_rme9652_capture_open,
 	.close =	snd_rme9652_capture_release,
 	.ioctl =	snd_rme9652_ioctl,
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 1b6fad7..e1a1387 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -857,7 +857,7 @@ static int snd_sonicvibes_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_sonicvibes_playback_ops = {
+static const struct snd_pcm_ops snd_sonicvibes_playback_ops = {
 	.open =		snd_sonicvibes_playback_open,
 	.close =	snd_sonicvibes_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -868,7 +868,7 @@ static struct snd_pcm_ops snd_sonicvibes_playback_ops = {
 	.pointer =	snd_sonicvibes_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_sonicvibes_capture_ops = {
+static const struct snd_pcm_ops snd_sonicvibes_capture_ops = {
 	.open =		snd_sonicvibes_capture_open,
 	.close =	snd_sonicvibes_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 599d2b7..27f0ed8 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2070,7 +2070,7 @@ static int snd_trident_foldback_close(struct snd_pcm_substream *substream)
    PCM operations
   ---------------------------------------------------------------------------*/
 
-static struct snd_pcm_ops snd_trident_playback_ops = {
+static const struct snd_pcm_ops snd_trident_playback_ops = {
 	.open =		snd_trident_playback_open,
 	.close =	snd_trident_playback_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2081,7 +2081,7 @@ static struct snd_pcm_ops snd_trident_playback_ops = {
 	.pointer =	snd_trident_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_trident_nx_playback_ops = {
+static const struct snd_pcm_ops snd_trident_nx_playback_ops = {
 	.open =		snd_trident_playback_open,
 	.close =	snd_trident_playback_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2115,7 +2115,7 @@ static struct snd_pcm_ops snd_trident_si7018_capture_ops = {
 	.pointer =	snd_trident_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_trident_foldback_ops = {
+static const struct snd_pcm_ops snd_trident_foldback_ops = {
 	.open =		snd_trident_foldback_open,
 	.close =	snd_trident_foldback_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2126,7 +2126,7 @@ static struct snd_pcm_ops snd_trident_foldback_ops = {
 	.pointer =	snd_trident_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_trident_nx_foldback_ops = {
+static const struct snd_pcm_ops snd_trident_nx_foldback_ops = {
 	.open =		snd_trident_foldback_open,
 	.close =	snd_trident_foldback_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2138,7 +2138,7 @@ static struct snd_pcm_ops snd_trident_nx_foldback_ops = {
 	.page =		snd_pcm_sgbuf_ops_page,
 };
 
-static struct snd_pcm_ops snd_trident_spdif_ops = {
+static const struct snd_pcm_ops snd_trident_spdif_ops = {
 	.open =		snd_trident_spdif_open,
 	.close =	snd_trident_spdif_close,
 	.ioctl =	snd_trident_ioctl,
@@ -2149,7 +2149,7 @@ static struct snd_pcm_ops snd_trident_spdif_ops = {
 	.pointer =	snd_trident_spdif_pointer,
 };
 
-static struct snd_pcm_ops snd_trident_spdif_7018_ops = {
+static const struct snd_pcm_ops snd_trident_spdif_7018_ops = {
 	.open =		snd_trident_spdif_open,
 	.close =	snd_trident_spdif_close,
 	.ioctl =	snd_trident_ioctl,
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 3dd038b..38a17b4 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1366,7 +1366,7 @@ static int snd_via8233_playback_close(struct snd_pcm_substream *substream)
 
 
 /* via686 playback callbacks */
-static struct snd_pcm_ops snd_via686_playback_ops = {
+static const struct snd_pcm_ops snd_via686_playback_ops = {
 	.open =		snd_via686_playback_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1379,7 +1379,7 @@ static struct snd_pcm_ops snd_via686_playback_ops = {
 };
 
 /* via686 capture callbacks */
-static struct snd_pcm_ops snd_via686_capture_ops = {
+static const struct snd_pcm_ops snd_via686_capture_ops = {
 	.open =		snd_via82xx_capture_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1392,7 +1392,7 @@ static struct snd_pcm_ops snd_via686_capture_ops = {
 };
 
 /* via823x DSX playback callbacks */
-static struct snd_pcm_ops snd_via8233_playback_ops = {
+static const struct snd_pcm_ops snd_via8233_playback_ops = {
 	.open =		snd_via8233_playback_open,
 	.close =	snd_via8233_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1405,7 +1405,7 @@ static struct snd_pcm_ops snd_via8233_playback_ops = {
 };
 
 /* via823x multi-channel playback callbacks */
-static struct snd_pcm_ops snd_via8233_multi_ops = {
+static const struct snd_pcm_ops snd_via8233_multi_ops = {
 	.open =		snd_via8233_multi_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1418,7 +1418,7 @@ static struct snd_pcm_ops snd_via8233_multi_ops = {
 };
 
 /* via823x capture callbacks */
-static struct snd_pcm_ops snd_via8233_capture_ops = {
+static const struct snd_pcm_ops snd_via8233_capture_ops = {
 	.open =		snd_via82xx_capture_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 99b9137..2f6d40f 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -804,7 +804,7 @@ static int snd_via82xx_pcm_close(struct snd_pcm_substream *substream)
 
 
 /* via686 playback callbacks */
-static struct snd_pcm_ops snd_via686_playback_ops = {
+static const struct snd_pcm_ops snd_via686_playback_ops = {
 	.open =		snd_via82xx_playback_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -817,7 +817,7 @@ static struct snd_pcm_ops snd_via686_playback_ops = {
 };
 
 /* via686 capture callbacks */
-static struct snd_pcm_ops snd_via686_capture_ops = {
+static const struct snd_pcm_ops snd_via686_capture_ops = {
 	.open =		snd_via82xx_capture_open,
 	.close =	snd_via82xx_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 4c26076..ffee284 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1123,7 +1123,7 @@ static int snd_ymfpci_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ymfpci_playback_ops = {
+static const struct snd_pcm_ops snd_ymfpci_playback_ops = {
 	.open =			snd_ymfpci_playback_open,
 	.close =		snd_ymfpci_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1134,7 +1134,7 @@ static struct snd_pcm_ops snd_ymfpci_playback_ops = {
 	.pointer =		snd_ymfpci_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_ymfpci_capture_rec_ops = {
+static const struct snd_pcm_ops snd_ymfpci_capture_rec_ops = {
 	.open =			snd_ymfpci_capture_rec_open,
 	.close =		snd_ymfpci_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1169,7 +1169,7 @@ int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device)
 				     snd_pcm_std_chmaps, 2, 0, NULL);
 }
 
-static struct snd_pcm_ops snd_ymfpci_capture_ac97_ops = {
+static const struct snd_pcm_ops snd_ymfpci_capture_ac97_ops = {
 	.open =			snd_ymfpci_capture_ac97_open,
 	.close =		snd_ymfpci_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1203,7 +1203,7 @@ int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ymfpci_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_ymfpci_playback_spdif_ops = {
 	.open =			snd_ymfpci_playback_spdif_open,
 	.close =		snd_ymfpci_playback_spdif_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1236,7 +1236,7 @@ int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ymfpci_playback_4ch_ops = {
+static const struct snd_pcm_ops snd_ymfpci_playback_4ch_ops = {
 	.open =			snd_ymfpci_playback_4ch_open,
 	.close =		snd_ymfpci_playback_4ch_close,
 	.ioctl =		snd_pcm_lib_ioctl,
