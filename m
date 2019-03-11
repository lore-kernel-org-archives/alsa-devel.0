From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: i2s: add minor improvements
Date: Mon, 11 Mar 2019 16:26:27 +0100
Message-ID: <1552317990-24219-1-git-send-email-olivier.moysan@st.com>
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

Add following minor changes in STM32 I2S driver:
- Change trigger traces
- Improve channel capabilities handling
- Use default dai name

Olivier Moysan (3):
  ASoC: stm32: i2s: change trigger traces
  ASoC: stm32: i2s: improve channel capabilities handling
  ASoC: stm32: i2s: use default dai name

 sound/soc/stm/stm32_i2s.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

-- 
2.7.4
