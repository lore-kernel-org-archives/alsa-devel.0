From: "Oskar Schirmer" <oskar@scara.com>
Subject: [PATCHv2] ASoC: fsl: imx-ssi: omit ssi counter to
	avoid harm in unbalanced situation
Date: 16 Nov 2013 07:52:25 +0000
Message-ID: <1384588345-22276-1-git-send-email-oskar@scara.com>
References: <1384533863-14288-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skyrme.org (skyrme.org [193.175.80.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 130C6262625
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 08:52:28 +0100 (CET)
Received: from p4ff18d8a.dip0.t-ipconnect.de ([79.241.141.138]
 helo=curry.scara.com)
 by skyrme.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.63) (envelope-from <oskar@curry.scara.com>)
 id 1Vhag8-00010r-6P
 for alsa-devel@alsa-project.org; Sat, 16 Nov 2013 07:52:28 +0000
In-Reply-To: <1384533863-14288-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org

Unbalanced calls to imx_ssi_trigger() may result in endless
SSI activity and thus provoke eternal sound. While on the first glance,
the switch statement looks pretty symmetric, the SUSPEND/RESUME
pair is not: the suspend case comes along snd_pcm_suspend_all(),
which for fsl/imx-pcm-fiq is called only at snd_soc_suspend(),
but the resume case originates straight from the SNDRV_PCM_IOCTL_RESUME.
This way userland may provoke an unbalanced resume, which might cause
the ssi->enabled counter to increase and never return to zero again,
so eventually SSI_SCR_SSIEN is never disabled.

As the information on whether to enable the SSI or not is contained
in the two bits for TE/RE, we save all the software mirroring of
hardware state here and simply use the hardware register itself
to keep the state of whether someone is currently playing or capturing.

This is essentially the same stuff as in sound/soc/fsl/imx-pcm-fiq.c
which I send a patch for three days ago. Astonishing enough this
highly fragile scheme is used twice in parallel to serve the very
same control function, synchronously: Once out of sync you are lost
until reboot.

Note, that these fixes wont prevent state machine distortion on alsa
level to cut sound or the like. It just makes sure we have a chance
to synchronise again later on.

Signed-off-by: Oskar Schirmer <oskar@scara.com>
---
v2: drop all software flag handling in favour of hardware registers

 sound/soc/fsl/imx-ssi.c |    5 ++---
 sound/soc/fsl/imx-ssi.h |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index f5f248c..2eb2691 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -304,8 +304,7 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			scr |= SSI_SCR_RE;
 		sier |= sier_bits;
 
-		if (++ssi->enabled == 1)
-			scr |= SSI_SCR_SSIEN;
+		scr |= SSI_SCR_SSIEN;
 
 		break;
 
@@ -318,7 +317,7 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			scr &= ~SSI_SCR_RE;
 		sier &= ~sier_bits;
 
-		if (--ssi->enabled == 0)
+		if (!(scr & (SSI_SCR_TE | SSI_SCR_RE)))
 			scr &= ~SSI_SCR_SSIEN;
 
 		break;
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index 560c40f..be65623 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -213,7 +213,6 @@ struct imx_ssi {
 
 	int fiq_init;
 	int dma_init;
-	int enabled;
 };
 
 #endif /* _IMX_SSI_H */
-- 
1.7.9.5
