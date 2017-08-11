From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/9] ALSA: gus: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:02 +0530
Message-ID: <1502452687-8202-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6298626648D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 13:58:49 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id h75so3293976pfh.5
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 04:58:49 -0700 (PDT)
In-Reply-To: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/gus/gus_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 6b3da01..36e852f 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -842,7 +842,7 @@ static int snd_gf1_pcm_volume_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	.put = snd_gf1_pcm_volume_put
 };
 
-static struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
+static const struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 	.open =		snd_gf1_pcm_playback_open,
 	.close =	snd_gf1_pcm_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -856,7 +856,7 @@ static int snd_gf1_pcm_volume_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	.fill_silence =	snd_gf1_pcm_playback_silence,
 };
 
-static struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
+static const struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
 	.open =		snd_gf1_pcm_capture_open,
 	.close =	snd_gf1_pcm_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
