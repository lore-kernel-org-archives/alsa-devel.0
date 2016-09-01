From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/6] ALSA: cs5535audio: constify snd_pcm_ops structures
Date: Fri,  2 Sep 2016 00:13:09 +0200
Message-ID: <1472767994-26269-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaya Kumar <jayakumar.alsa@gmail.com>
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
 sound/pci/cs5535audio/cs5535audio_pcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 27fa57d..c208c1d 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -380,7 +380,7 @@ static int snd_cs5535audio_capture_prepare(struct snd_pcm_substream *substream)
 				 substream->runtime->rate);
 }
 
-static struct snd_pcm_ops snd_cs5535audio_playback_ops = {
+static const struct snd_pcm_ops snd_cs5535audio_playback_ops = {
 	.open =		snd_cs5535audio_playback_open,
 	.close =	snd_cs5535audio_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -391,7 +391,7 @@ static struct snd_pcm_ops snd_cs5535audio_playback_ops = {
 	.pointer =	snd_cs5535audio_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_cs5535audio_capture_ops = {
+static const struct snd_pcm_ops snd_cs5535audio_capture_ops = {
 	.open =		snd_cs5535audio_capture_open,
 	.close =	snd_cs5535audio_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
