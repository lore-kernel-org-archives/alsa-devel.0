From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/7] ASoC: cs42l51: add some features
Date: Wed, 3 Apr 2019 15:23:30 +0200
Message-ID: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
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
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.com
List-Id: alsa-devel@alsa-project.org

This patchset add support of following features to Cirrus CS42L51 audio codec driver:
- reset
- regulators
- master mode
- power management
- adc volume control

Olivier Moysan (7):
  ASoC: dt-bindings: update cs42l51 bindings
  ASoC: cs42l51: add regulator management
  ASoC: cs42l51: add reset management
  ASoC: cs42l51: add support of master mode
  ASoC: cs42l51: change mic bias DAPM
  ASoC: cs42l51: add power management
  ASoC: cs42l51: add adc volume control

 .../devicetree/bindings/sound/cs42l51.txt          |  16 ++
 sound/soc/codecs/cs42l51-i2c.c                     |  13 +-
 sound/soc/codecs/cs42l51.c                         | 217 ++++++++++++++++++++-
 sound/soc/codecs/cs42l51.h                         |   3 +
 4 files changed, 242 insertions(+), 7 deletions(-)

-- 
2.7.4
