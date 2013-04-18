From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 10/17] ASoC: mxs: Use generic dmaengine PCM
Date: Thu, 18 Apr 2013 10:44:32 +0800
Message-ID: <20130418024430.GB14102@S2101-09.ap.freescale.net>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-11-git-send-email-lars@metafoo.de>
 <20130417084304.GK11245@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 31383265DA5
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 04:44:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130417084304.GK11245@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 04:43:06PM +0800, Shawn Guo wrote:
> On Mon, Apr 15, 2013 at 07:19:57PM +0200, Lars-Peter Clausen wrote:
> > Use the generic dmaengine PCM driver instead of a custom implementation.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  sound/soc/mxs/Kconfig   |   2 +-
> >  sound/soc/mxs/mxs-pcm.c | 135 ++++--------------------------------------------
> >  2 files changed, 11 insertions(+), 126 deletions(-)
> 
> After applying the patch, mxs audio is broken as below.
> 
> [    2.003200] mxs-saif 80042000.saif: Missing dma channel for stream: 1
> [    2.010220] mmc0: new high speed SDHC card at address e624
> [    2.016453] mxs-saif 80042000.saif: ASoC: pcm constructor failed: -22
> [    2.022964] mxs-sgtl5000 sound.12: ASoC: can't create pcm HiFi Playback :-22
> [    2.030310] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -22
> 
> It's caused by that dmaengine_pcm_new() will call
> dmaengine_pcm_compat_request_channel() twice to request the same mxs-dma
> channel, and the second call will fail.

For purpose of debugging, the mxs audio can just work as before with the
changes below.

Shawn 

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index ae0c37e..7d41fdd 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -148,6 +148,9 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
                if (!substream)
                        continue;

+               if (i == SNDRV_PCM_STREAM_CAPTURE)
+                       pcm->chan[i] = pcm->chan[SNDRV_PCM_STREAM_PLAYBACK];
+
                if (!pcm->chan[i] && pcm->compat) {
                        pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
                                substream);
