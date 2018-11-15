From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] ASoC: qdsp6: add compress offload support
Date: Thu, 15 Nov 2018 18:13:19 +0000
Message-ID: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, srini@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Changes since v2 (//lkml.org/lkml/2018/9/26/461):
- Removed some unnecessary empty line adds.
- Added more info to snd_compr_set_runtime_buffer() commit message

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
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 372 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 6 files changed, 438 insertions(+), 4 deletions(-)

-- 
2.19.1
