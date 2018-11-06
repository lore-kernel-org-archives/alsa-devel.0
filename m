From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: qdsp6: few routing fixes
Date: Tue,  6 Nov 2018 11:38:55 +0000
Message-ID: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Jimmy and Rohit found a issue w.r.t backend dais being powered
on all the time on there device. Looks like there was a bug in
the driver since start. This patchset fixes it and also fixes
another bug where asm routes are added each time at dai probe.

Thanks,
srini


Srinivas Kandagatla (2):
  ASoC: qdsp6: q6asm-dai: Only add routing once.
  ASoC: qdsp6: q6afe-dai: Fix the dai widgets

 sound/soc/qcom/qdsp6/q6afe-dai.c | 208 +++++++++++++++----------------
 sound/soc/qcom/qdsp6/q6asm-dai.c |  33 -----
 sound/soc/qcom/qdsp6/q6routing.c |  19 +++
 3 files changed, 123 insertions(+), 137 deletions(-)

-- 
2.19.1
