From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: au88x0: Fix sparse warning wrt PCM
	format type
Date: Wed, 25 Jul 2018 23:19:40 +0200
Message-ID: <20180725211945.19222-6-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A3A26775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:55 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D2960B0B0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
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

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of vortex_alsafmt_aspfmt() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/pci/au88x0/au88x0_core.c:2778:14: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0.h      | 2 +-
 sound/pci/au88x0/au88x0_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index bcc648bf6478..e3e31f07d766 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -241,7 +241,7 @@ static int vortex_core_init(vortex_t * card);
 static int vortex_core_shutdown(vortex_t * card);
 static void vortex_enable_int(vortex_t * card);
 static irqreturn_t vortex_interrupt(int irq, void *dev_id);
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v);
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v);
 
 /* Connection  stuff. */
 static void vortex_connect_default(vortex_t * vortex, int en);
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 4083c8b01619..2e5b460a847c 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2770,7 +2770,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
 
 /* Alsa support. */
 
-static int vortex_alsafmt_aspfmt(int alsafmt, vortex_t *v)
+static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v)
 {
 	int fmt;
 
-- 
2.18.0
