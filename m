From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: ac97: Fix kernel-doc error with
	sphinx formatter
Date: Mon, 14 Nov 2016 22:30:03 +0100
Message-ID: <20161114213005.22443-2-tiwai@suse.de>
References: <20161114213005.22443-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC11266F1A
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 22:30:10 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 83B8EABFB
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 21:30:10 +0000 (UTC)
In-Reply-To: <20161114213005.22443-1-tiwai@suse.de>
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

Sphinx takes a word like (*foo)->bar in the kernel-doc comments as a
part of the emphasized marker, and complains like

  ./sound/pci/ac97/ac97_codec.c:1908: WARNING: Inline emphasis start-string without end-string.

For avoiding this, wrap it with the quotes (``) in the comment.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 82259ca61e64..1ef7cdf1d3e8 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1907,7 +1907,7 @@ static int ac97_reset_wait(struct snd_ac97 *ac97, int timeout, int with_modem)
  * write).  The other callbacks, wait and reset, are not mandatory.
  * 
  * The clock is set to 48000.  If another clock is needed, set
- * (*rbus)->clock manually.
+ * ``(*rbus)->clock`` manually.
  *
  * The AC97 bus instance is registered as a low-level device, so you don't
  * have to release it manually.
-- 
2.10.2
