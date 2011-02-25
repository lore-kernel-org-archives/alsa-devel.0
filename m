From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 21/21]sound:soc:samsung:dma.c remove one to
	many l's in the word.
Date: Thu, 24 Feb 2011 22:16:37 -0800
Message-ID: <1298614597-4340-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CEADA1037F8
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 07:16:57 +0100 (CET)
Received: by ywg4 with SMTP id 4so385656ywg.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 22:16:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, tiwai@suse.de, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The patch below removes an extra "l" in the word.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 sound/soc/samsung/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 2124019..807efa5 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -313,7 +313,7 @@ dma_pointer(struct snd_pcm_substream *substream)
 	/* we seem to be getting the odd error from the pcm library due
 	 * to out-of-bounds pointers. this is maybe due to the dma engine
 	 * not having loaded the new values for the channel before being
-	 * callled... (todo - fix )
+	 * called... (todo - fix )
 	 */
 
 	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
-- 
1.7.4.1
