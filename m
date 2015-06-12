From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] sound: oss/sb_audio: use swap()
	in sb_audio_close()
Date: Fri, 12 Jun 2015 18:59:08 +0200
Message-ID: <1434128348-10567-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay108.isp.belgacom.be (mailrelay108.isp.belgacom.be
 [195.238.20.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 813AE26694F
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 18:59:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/oss/sb_audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/oss/sb_audio.c b/sound/oss/sb_audio.c
index 048439a..dc91072 100644
--- a/sound/oss/sb_audio.c
+++ b/sound/oss/sb_audio.c
@@ -102,12 +102,8 @@ void sb_audio_close(int dev)
 	if(devc->duplex
 	   && !devc->fullduplex
 	   && (devc->opened & OPEN_READ) && (devc->opened & OPEN_WRITE))
-	{
-		struct dma_buffparms *dmap_temp;
-		dmap_temp = audio_devs[dev]->dmap_out;
-		audio_devs[dev]->dmap_out = audio_devs[dev]->dmap_in;
-		audio_devs[dev]->dmap_in = dmap_temp;
-	}
+		swap(audio_devs[dev]->dmap_out, audio_devs[dev]->dmap_in);
+
 	audio_devs[dev]->dmap_out->dma = devc->dma8;
 	audio_devs[dev]->dmap_in->dma = ( devc->duplex ) ?
 		devc->dma16 : devc->dma8;
-- 
2.4.2
