From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/6] ALSA: ad1889: constify snd_pcm_ops
	structures
Date: Fri,  2 Sep 2016 00:13:12 +0200
Message-ID: <1472767994-26269-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id AEBB92672B3
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
To: Thibaut Varene <T-Bone@parisc-linux.org>
Cc: alsa-devel@alsa-project.org, linux-parisc@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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
 sound/pci/ad1889.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 1fc6d8b..8c36990 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -571,7 +571,7 @@ snd_ad1889_capture_pointer(struct snd_pcm_substream *ss)
 	return bytes_to_frames(ss->runtime, ptr);
 }
 
-static struct snd_pcm_ops snd_ad1889_playback_ops = {
+static const struct snd_pcm_ops snd_ad1889_playback_ops = {
 	.open = snd_ad1889_playback_open,
 	.close = snd_ad1889_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -582,7 +582,7 @@ static struct snd_pcm_ops snd_ad1889_playback_ops = {
 	.pointer = snd_ad1889_playback_pointer, 
 };
 
-static struct snd_pcm_ops snd_ad1889_capture_ops = {
+static const struct snd_pcm_ops snd_ad1889_capture_ops = {
 	.open = snd_ad1889_capture_open,
 	.close = snd_ad1889_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
