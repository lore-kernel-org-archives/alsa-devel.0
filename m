From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: i2s: add power management
Date: Fri, 8 Feb 2019 11:49:52 +0100
Message-ID: <1549622994-13810-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 9CE53267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 11:50:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add support of system low power modes to STM32 I2S driver:
Implement sleep PM suspend and resume callbacks,
to restore STM32 I2S registers after low power modes.

Add STM32 I2S peripheral and kernel clocks power management:
- Enable/disable kernel clock on audio stream startup/shutdown.
- Manage peripheral clock power through regmap services .

Olivier Moysan (2):
  ASoC: stm32: i2s: add power management
  SoC: stm32: i2s: manage clock power

 sound/soc/stm/stm32_i2s.c | 77 +++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

-- 
2.7.4
