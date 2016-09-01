From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 6/6] ALSA: bt87x: constify snd_pcm_ops structures
Date: Fri,  2 Sep 2016 00:13:14 +0200
Message-ID: <1472767994-26269-7-git-send-email-Julia.Lawall@lip6.fr>
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
 sound/pci/bt87x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 5925b71..f2c0709 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -550,7 +550,7 @@ static snd_pcm_uframes_t snd_bt87x_pointer(struct snd_pcm_substream *substream)
 	return (snd_pcm_uframes_t)bytes_to_frames(runtime, chip->current_line * chip->line_bytes);
 }
 
-static struct snd_pcm_ops snd_bt87x_pcm_ops = {
+static const struct snd_pcm_ops snd_bt87x_pcm_ops = {
 	.open = snd_bt87x_pcm_open,
 	.close = snd_bt87x_close,
 	.ioctl = snd_pcm_lib_ioctl,
