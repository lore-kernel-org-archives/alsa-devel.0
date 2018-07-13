From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] ASoC: core: add support to card re-bind
	using component framework
Date: Fri, 13 Jul 2018 16:36:27 +0100
Message-ID: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 651F6267727
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 17:39:21 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so9754865wmf.3
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 08:39:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

During discussion regarding card re-binding when components unregister
and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
that component framework can be added into core to provide this feature.

With this new changes the card will re-bind once the dependent component
re-registers after unregistering. This works based on the match done
from component name using component framework.

I have tested this patch with qdsp start-stop and module-load-unload usecase
for more than 10000 times in loop on Qcom platforms.

Thanks,
srini

Changes since v1:
 - Added new flag to enable/disable auto bind at card level, It is useful
  if machine driver/module is really removed/unloaded. Also to help cleanup
  the master component. Without this we will endup with a memory leak if the
  machine driver and memory associated with card are removed.
 - removed unregister from unbind callback.
 - updated match function as suggested by Vinod.
 - Added qdsp6 cleanup patches to this series.

Srinivas Kandagatla (5):
  ASoC: core: add support to card re-bind using component framework
  ASoC: qdsp6: q6afe-dai: remove component fw related code
  ASoC: qdsp6: q6asm-dai: remove component framework related code
  ASoC: qdsp6: q6routing: remove component framework related code
  ASoC: qcom: apq8096: remove component framework related code

 include/sound/soc.h              |  7 ++++
 sound/soc/qcom/apq8096.c         | 75 ++++------------------------------------
 sound/soc/qcom/qdsp6/q6afe-dai.c | 34 +++---------------
 sound/soc/qcom/qdsp6/q6asm-dai.c | 35 +++----------------
 sound/soc/qcom/qdsp6/q6routing.c | 32 ++++-------------
 sound/soc/soc-core.c             | 62 +++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 156 deletions(-)

-- 
2.16.2
