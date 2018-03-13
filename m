From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine_pcm: document process
	callback" to the asoc tree
Date: Tue, 13 Mar 2018 16:47:09 +0000 (GMT)
Message-ID: <20180313164709.D352C440079@finisterre.ee.mobilebroadband>
References: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10318266E77
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 17:47:15 +0100 (CET)
In-Reply-To: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, jsarha@ti.com, lgirdwood@gmail.com, broonie@kernel.org, rmk@arm.linux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine_pcm: document process callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2e78a5562ebc2e4bbdfd7f7729385b3acc94c36e Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 13 Mar 2018 17:27:08 +0100
Subject: [PATCH] ASoC: dmaengine_pcm: document process callback

Add missing description of process callback.

Fixes: 78648092ef46 ("ASoC: dmaengine_pcm: add processing support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 47ef486852ed..e3481eebdd98 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -118,6 +118,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
  * @compat_request_channel: Callback to request a DMA channel for platforms
  *   which do not use devicetree.
+ * @process: Callback used to apply processing on samples transferred from/to
+ *   user space.
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
-- 
2.16.2
