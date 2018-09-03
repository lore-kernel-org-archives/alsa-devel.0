From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: qdsp6: add compress offload support
Date: Mon,  3 Sep 2018 13:34:52 +0100
Message-ID: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 586BC2673F4
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 14:37:32 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so520819wrr.4
 for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2018 05:37:32 -0700 (PDT)
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

Srinivas Kandagatla (3):
  ASoC: q6asm-dai: dt-bindings: Add support to compress dais
  ASoC: qdsp6: q6asm: add support to MP3 format
  ASoC: qdsp6: q6asm-dai: Add support to compress offload

 .../devicetree/bindings/sound/qcom,q6asm.txt  |  27 ++
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 418 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 4 files changed, 450 insertions(+), 1 deletion(-)

-- 
2.18.0
