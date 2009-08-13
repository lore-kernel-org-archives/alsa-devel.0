From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 18/20] ASoC: Always syncronize audio
	transfers on frames
Date: Thu, 13 Aug 2009 17:35:31 +0300
Message-ID: <1250174133-451-19-git-send-email-eduardo.valentin__8723.31142095408$1250175115$gmane$org@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-17-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-18-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250174133-451-18-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

All these steps are required for ASoC to behave correctly.
rccr and xccr are format dependent, for example TDM audio
has different values than I2S or DSP_A. Also the
omap_mcbsp_xmit_enable and/or omap_mcbsp_recv_enable must
be called right after the DMA has started.
This provides no longer L and R channels switching at random.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8f361b1..0272d3f 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -191,6 +191,11 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!mcbsp_data->active++)
 			omap_mcbsp_start(mcbsp_data->bus_id);
+		/* Make sure data transfer is frame synchronized */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			omap_mcbsp_xmit_enable(mcbsp_data->bus_id, 1);
+		else
+			omap_mcbsp_recv_enable(mcbsp_data->bus_id, 1);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -336,11 +341,15 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 1-bit data delay */
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 1-bit data delay */
 		regs->rcr2      |= RDATDLY(1);
 		regs->xcr2      |= XDATDLY(1);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		/* Invert FS polarity configuration */
 		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
 		break;
-- 
1.6.2.GIT

