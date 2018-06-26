From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/12] ASoC: qdsp6: Fix dt based module
	loading and minor fixes
Date: Tue, 26 Jun 2018 10:20:04 +0100
Message-ID: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 784372676B4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:22:23 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so14706118wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:22:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Recent discussion on https://lkml.org/lkml/2018/6/18/1282 suggested
that qdsp6 code is using less common of_platform apis which would
not give dt based module loading support.

Suggestion from Rob was to add compatible strings to the dais nodes
This patchset adds this. Also this patchset has 3 trivial fixes which
is removing redundant owner, remove unused struct member and fix a
error check in q6routing.

Changes since v1:
- Addressed few trivial comments from Niklas

Thanks,
srini

Srinivas Kandagatla (12):
  ASoC: q6adm: dt-bindings: add compatible string to routing
  ASoC: q6asm: dt-bindings: add compatible string to dais
  ASoC: q6afe: dt-bindings: add compatible string to dais
  ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe-dai: support dt based module loading
  ASoC: qdsp6: q6asm-dai: support dt based module loading
  ASoC: qdsp6: q6routing: support dt based module loading
  ASoC: qcom: apq8096: remove redundant owner assignment
  ASoC: qdsp6: q6routing: add proper error check
  ASoC: qdsp6: q6asm: remove unused struct q6asm member

 Documentation/devicetree/bindings/sound/qcom,q6adm.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt |  6 ++++++
 sound/soc/qcom/apq8096.c                               |  1 -
 sound/soc/qcom/qdsp6/q6adm.c                           | 16 ++--------------
 sound/soc/qcom/qdsp6/q6afe-dai.c                       |  7 +++++++
 sound/soc/qcom/qdsp6/q6afe.c                           | 16 ++--------------
 sound/soc/qcom/qdsp6/q6asm-dai.c                       |  7 +++++++
 sound/soc/qcom/qdsp6/q6asm.c                           | 17 ++---------------
 sound/soc/qcom/qdsp6/q6routing.c                       |  9 ++++++++-
 10 files changed, 46 insertions(+), 45 deletions(-)

-- 
2.16.2
