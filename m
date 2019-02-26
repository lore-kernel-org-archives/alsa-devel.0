From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/7] ASoC: stm32: i2s: miscellaneous fixes
Date: Tue, 26 Feb 2019 14:51:03 +0100
Message-ID: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set is a collection of fixes for STM32 I2S driver.

Olivier Moysan (7):
  ASoC: stm32: i2s: fix IRQ clearing
  ASoC: stm32: i2s: fix 16 bit format support
  ASoC: stm32: i2s: fix stream count management
  ASoC: stm32: i2s: fix dma configuration
  ASoC: stm32: i2s: remove useless callback
  ASoC: stm32: i2s: fix race condition in irq handler
  ASoC: stm32: i2s: skip useless write in slave mode

 sound/soc/stm/stm32_i2s.c | 73 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

-- 
2.7.4
