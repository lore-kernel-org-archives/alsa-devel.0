From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] soc at91 minor bug fixes
Date: Thu,  8 May 2008 11:27:55 +0100
Message-ID: <1210242475-24279-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210242475-24279-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA2E41037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 12:27:57 +0200 (CEST)
In-Reply-To: <1210242475-24279-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Patrik Sevallius <patrik.sevallius@enea.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

From: Patrik Sevallius <patrik.sevallius@enea.com>

Found these two bugs while browsing through the code.  The first one is
a cut-n-paste bug, instead of disabling the clock when request_irq()
fails, it enabled it once more.  The second one fixes a debug printout,
AT91_SSC_IER is write only, AT91_SSC_IMR is readable (the printed string
actually says imr).

Frank Mandarino was busy so he asked me to send these to this list.

/Patrik

Signed-off-by: Patrik Sevallius <patrik.sevallius@enea.com>
Acked-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/at91/at91-pcm.c |    2 +-
 sound/soc/at91/at91-ssc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/at91/at91-pcm.c b/sound/soc/at91/at91-pcm.c
index e36533d..ccac6bd 100644
--- a/sound/soc/at91/at91-pcm.c
+++ b/sound/soc/at91/at91-pcm.c
@@ -197,7 +197,7 @@ static int at91_pcm_trigger(struct snd_pcm_substream *substream,
 
 		DBG("sr=%lx imr=%lx\n",
 		    at91_ssc_read(params->ssc_base + AT91_SSC_SR),
-		    at91_ssc_read(params->ssc_base + AT91_SSC_IER));
+		    at91_ssc_read(params->ssc_base + AT91_SSC_IMR));
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
diff --git a/sound/soc/at91/at91-ssc.c b/sound/soc/at91/at91-ssc.c
index f642d2d..bc35d00 100644
--- a/sound/soc/at91/at91-ssc.c
+++ b/sound/soc/at91/at91-ssc.c
@@ -590,7 +590,7 @@ static int at91_ssc_hw_params(struct snd_pcm_substream *substream,
 			printk(KERN_WARNING "at91-ssc: request_irq failure\n");
 
 			DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
-			at91_sys_write(AT91_PMC_PCER, 1<<ssc_p->ssc.pid);
+			at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);
 			return ret;
 		}
 
-- 
1.5.5.1
