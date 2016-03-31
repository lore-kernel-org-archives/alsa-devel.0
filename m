From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: qcom: fix static checker warnings.
Date: Thu, 31 Mar 2016 19:23:13 +0100
Message-ID: <1459448595-18620-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B1102666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:23:20 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id f198so12430050wme.0
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 11:23:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kwestfie@codeaurora.org
Cc: plai@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This patchset fixes 2 static checker warnings reported by Dan Carpenter.

Thanks,
srini

Srinivas Kandagatla (2):
  ASoC: qcom: Fix uninitialized symbol warning.
  ASoC: qcom: remove IS_ERR_VALUE usage on int.

 sound/soc/qcom/lpass-platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.5.0
