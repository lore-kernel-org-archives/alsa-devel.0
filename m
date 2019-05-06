From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: spdifrx: add some features
Date: Mon, 6 May 2019 14:44:03 +0200
Message-ID: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
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
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com
Cc: benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Update and add some features in STM32 SPDIFRX driver.
- pdate pcm hardware constraints
- change trace level on iec control
- add management of identification registers

Olivier Moysan (3):
  ASoC: stm32: spdifrx: update pcm hardware constraints
  ASoC: stm32: spdifrx: change trace level on iec control
  ASoC: stm32: spdifrx: manage identification registers

 sound/soc/stm/stm32_spdifrx.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.7.4
