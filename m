From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/9] ALSA: es1688: constify snd_pcm_ops
	structures
Date: Fri, 11 Aug 2017 17:28:00 +0530
Message-ID: <1502452687-8202-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B940326648D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 13:58:45 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id t86so3316213pfe.1
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 04:58:44 -0700 (PDT)
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
 sound/isa/es1688/es1688_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index 5d3df96..ec7e68b 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -706,7 +706,7 @@ int snd_es1688_create(struct snd_card *card,
 	return err;
 }
 
-static struct snd_pcm_ops snd_es1688_playback_ops = {
+static const struct snd_pcm_ops snd_es1688_playback_ops = {
 	.open =			snd_es1688_playback_open,
 	.close =		snd_es1688_playback_close,
 	.ioctl =		snd_es1688_ioctl,
@@ -717,7 +717,7 @@ int snd_es1688_create(struct snd_card *card,
 	.pointer =		snd_es1688_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_es1688_capture_ops = {
+static const struct snd_pcm_ops snd_es1688_capture_ops = {
 	.open =			snd_es1688_capture_open,
 	.close =		snd_es1688_capture_close,
 	.ioctl =		snd_es1688_ioctl,
-- 
1.9.1
