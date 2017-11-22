From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: sai: fixes related to synchro
	feature
Date: Wed, 22 Nov 2017 16:02:24 +0100
Message-ID: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 00B4F26721E
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 16:02:38 +0100 (CET)
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

Fix sai binding and simplify code related to synchro feature.
This change allows to remove stm32_sai_remove() function
and use devm_of_platform_populate().

Olivier Moysan (3):
  ASoC: stm32: fix sync property description in SAI bindings
  ASoC: stm32: sai: simplify sync modes management
  ASoC: stm32: sai: use devm_of_platform_populate()

 .../devicetree/bindings/sound/st,stm32-sai.txt     |  12 ++-
 sound/soc/stm/stm32_sai.c                          | 114 ++++-----------------
 2 files changed, 29 insertions(+), 97 deletions(-)

-- 
1.9.1
