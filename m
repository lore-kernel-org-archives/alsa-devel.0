From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/3] ASoC: dmaengine_pcm: document process
	callback
Date: Tue, 13 Mar 2018 17:27:08 +0100
Message-ID: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D9D14267274
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 17:27:17 +0100 (CET)
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: jsarha@ti.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Add missing description of process callback.

Fixes: 78648092ef46 ("ASoC: dmaengine_pcm: add processing support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
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
1.9.1
