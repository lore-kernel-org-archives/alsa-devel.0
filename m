From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 20/20] ASoC: Always syncronize audio
	transfers on frames
Date: Tue, 11 Aug 2009 16:05:31 +0300
Message-ID: <1249995931-26015-21-git-send-email-eduardo.valentin__28857.3145088323$1249998055$gmane$org@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-12-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-13-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-14-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-18-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-19-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-20-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-20-git-send-email-eduardo.valentin@nokia.com>
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
index 2d96548..ad40da7 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -224,6 +224,11 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -373,11 +378,15 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
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

