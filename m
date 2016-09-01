From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/6] ALSA: oxygen: constify snd_pcm_ops structures
Date: Fri,  2 Sep 2016 00:13:13 +0200
Message-ID: <1472767994-26269-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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
 sound/pci/oxygen/oxygen_pcm.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_pcm.c b/sound/pci/oxygen/oxygen_pcm.c
index aa2ebd1..042a243 100644
--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -631,7 +631,7 @@ static snd_pcm_uframes_t oxygen_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(runtime, curr_addr - (u32)runtime->dma_addr);
 }
 
-static struct snd_pcm_ops oxygen_rec_a_ops = {
+static const struct snd_pcm_ops oxygen_rec_a_ops = {
 	.open      = oxygen_rec_a_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -642,7 +642,7 @@ static struct snd_pcm_ops oxygen_rec_a_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static struct snd_pcm_ops oxygen_rec_b_ops = {
+static const struct snd_pcm_ops oxygen_rec_b_ops = {
 	.open      = oxygen_rec_b_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -653,7 +653,7 @@ static struct snd_pcm_ops oxygen_rec_b_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static struct snd_pcm_ops oxygen_rec_c_ops = {
+static const struct snd_pcm_ops oxygen_rec_c_ops = {
 	.open      = oxygen_rec_c_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -664,7 +664,7 @@ static struct snd_pcm_ops oxygen_rec_c_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static struct snd_pcm_ops oxygen_spdif_ops = {
+static const struct snd_pcm_ops oxygen_spdif_ops = {
 	.open      = oxygen_spdif_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -675,7 +675,7 @@ static struct snd_pcm_ops oxygen_spdif_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static struct snd_pcm_ops oxygen_multich_ops = {
+static const struct snd_pcm_ops oxygen_multich_ops = {
 	.open      = oxygen_multich_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
@@ -686,7 +686,7 @@ static struct snd_pcm_ops oxygen_multich_ops = {
 	.pointer   = oxygen_pointer,
 };
 
-static struct snd_pcm_ops oxygen_ac97_ops = {
+static const struct snd_pcm_ops oxygen_ac97_ops = {
 	.open      = oxygen_ac97_open,
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
