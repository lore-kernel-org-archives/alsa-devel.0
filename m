From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 0/7] ASoC: stm32: sai: misc fixes
Date: Fri, 16 Jun 2017 14:15:27 +0200
Message-ID: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6A5D22669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 14:16:05 +0200 (CEST)
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
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set gathers various fixes on STM32 SAI driver.

olivier moysan (7):
  dt-bindings: stm32: sai: fix DT example
  ASoC: stm32: change SAI configuration flag
  ASoC: stm32: sai: typo fixes
  ASoC: stm32: sai: remove spurious trace
  ASoC: stm32: sai: change stop sequence
  ASoC: stm32: sai: fix clock management
  ASoC: stm32: sai: manage master clock

 .../devicetree/bindings/sound/st,stm32-sai.txt     | 25 ++++------
 sound/soc/stm/Kconfig                              | 10 ++--
 sound/soc/stm/Makefile                             |  4 +-
 sound/soc/stm/stm32_sai.c                          |  2 +-
 sound/soc/stm/stm32_sai.h                          |  1 -
 sound/soc/stm/stm32_sai_sub.c                      | 57 +++++++++++++---------
 6 files changed, 54 insertions(+), 45 deletions(-)

-- 
1.9.1
