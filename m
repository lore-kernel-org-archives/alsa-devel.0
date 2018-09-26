From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] ASoC: qdsp6: add compress offload
	support
Date: Wed, 26 Sep 2018 11:23:44 +0100
Message-ID: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 088C2267730
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 12:25:56 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so22781991wrh.7
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 03:25:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds support to very basic MP3 playback compress offload
support via QDSP ASM module.

Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
tinycompress library.

Adding other codec support should be trivial w.r.t qdsp6 side, however
there are other dependencies like compress UAPI header changes and
FastRPC which are being worked in parallel. Once ready will post them!

thanks,
srini

Changes since v1 (https://patchwork.kernel.org/cover/10585805/)
- added support to snd_compr_set_runtime_buffer()
- make use of generic copy function
- few trivial cleanups suggested by Vinod Koul

Srinivas Kandagatla (5):
  ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
  ALSA: compress: make use of runtime buffer for copy
  ASoC: q6asm-dai: dt-bindings: Add support to compress dais
  ASoC: qdsp6: q6asm: add support to MP3 format
  ASoC: qdsp6: q6asm-dai: Add support to compress offload

 .../devicetree/bindings/sound/qcom,q6asm.txt  |  27 ++
 include/sound/compress_driver.h               |  19 +
 sound/core/compress_offload.c                 |  18 +-
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 377 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 6 files changed, 443 insertions(+), 4 deletions(-)

-- 
2.19.0
