From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: lx6464es: Use NULL for pointers
Date: Tue, 26 May 2015 14:41:50 +0200
Message-ID: <1432644112-16543-4-git-send-email-tiwai@suse.de>
References: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E34261736
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:54 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C05E1AD66
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
In-Reply-To: <1432644112-16543-1-git-send-email-tiwai@suse.de>
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

Spotted by sparse:
  sound/pci/lx6464es/lx6464es.c:415:47: warning: Using plain integer as NULL pointer
  sound/pci/lx6464es/lx6464es.c:417:48: warning: Using plain integer as NULL pointer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lx6464es/lx6464es.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 611b9a88784e..cba89beb2b38 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -412,9 +412,9 @@ static int lx_pcm_hw_free(struct snd_pcm_substream *substream)
 	err = snd_pcm_lib_free_pages(substream);
 
 	if (is_capture)
-		chip->capture_stream.stream = 0;
+		chip->capture_stream.stream = NULL;
 	else
-		chip->playback_stream.stream = 0;
+		chip->playback_stream.stream = NULL;
 
 exit:
 	mutex_unlock(&chip->setup_mutex);
-- 
2.4.1
