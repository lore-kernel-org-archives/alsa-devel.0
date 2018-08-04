From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: echoaudio: Mark expected switch
	fall-throughs
Date: Sat, 4 Aug 2018 15:13:26 -0500
Message-ID: <20180804201326.GA26730@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.46.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 563AA2677CE
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2018 22:13:27 +0200 (CEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 514F57781
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2018 15:13:27 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115156 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/echoaudio/echoaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 358ef7d..907cf1a 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -713,6 +713,7 @@ static int pcm_prepare(struct snd_pcm_substream *substream)
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
 		format.data_are_bigendian = 1;
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S32_LE:
 		format.bits_per_sample = 32;
 		break;
@@ -764,6 +765,7 @@ static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 					pipe->last_counter = 0;
 					pipe->position = 0;
 					*pipe->dma_counter = 0;
+					/* fall through */
 				case PIPE_STATE_PAUSED:
 					pipe->state = PIPE_STATE_STARTED;
 					break;
-- 
2.7.4
