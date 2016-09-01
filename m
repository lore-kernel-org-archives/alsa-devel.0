From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/6] ALSA: firewire: constify snd_pcm_ops
	structures
Date: Fri,  2 Sep 2016 00:13:11 +0200
Message-ID: <1472767994-26269-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 846C3267299
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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
 sound/firewire/dice/dice-pcm.c       |    4 ++--
 sound/firewire/digi00x/digi00x-pcm.c |    4 ++--
 sound/firewire/oxfw/oxfw-pcm.c       |    4 ++--
 sound/firewire/tascam/tascam-pcm.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 4aa0249..6074fe1 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -302,7 +302,7 @@ static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
 
 int snd_dice_create_pcm(struct snd_dice *dice)
 {
-	static struct snd_pcm_ops capture_ops = {
+	static const struct snd_pcm_ops capture_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
@@ -314,7 +314,7 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
-	static struct snd_pcm_ops playback_ops = {
+	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index cac28f7..613f058 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -329,7 +329,7 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&dg00x->rx_stream);
 }
 
-static struct snd_pcm_ops pcm_capture_ops = {
+static const struct snd_pcm_ops pcm_capture_ops = {
 	.open		= pcm_open,
 	.close		= pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -341,7 +341,7 @@ static struct snd_pcm_ops pcm_capture_ops = {
 	.page		= snd_pcm_lib_get_vmalloc_page,
 };
 
-static struct snd_pcm_ops pcm_playback_ops = {
+static const struct snd_pcm_ops pcm_playback_ops = {
 	.open		= pcm_open,
 	.close		= pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 8d23341..f3530f8 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -388,7 +388,7 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstm)
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
-	static struct snd_pcm_ops capture_ops = {
+	static const struct snd_pcm_ops capture_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
@@ -400,7 +400,7 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
-	static struct snd_pcm_ops playback_ops = {
+	static const struct snd_pcm_ops playback_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 380d3db..79db1b6 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -268,7 +268,7 @@ static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
 	return amdtp_stream_pcm_pointer(&tscm->rx_stream);
 }
 
-static struct snd_pcm_ops pcm_capture_ops = {
+static const struct snd_pcm_ops pcm_capture_ops = {
 	.open		= pcm_open,
 	.close		= pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -280,7 +280,7 @@ static struct snd_pcm_ops pcm_capture_ops = {
 	.page		= snd_pcm_lib_get_vmalloc_page,
 };
 
-static struct snd_pcm_ops pcm_playback_ops = {
+static const struct snd_pcm_ops pcm_playback_ops = {
 	.open		= pcm_open,
 	.close		= pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
