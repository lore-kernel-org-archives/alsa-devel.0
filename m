From: Andrew Jackson <andrew.jackson@arm.com>
Subject: [PATCH v3 0/5] ASoC: dwc: Add device tree support to
	designware I2S
Date: Fri, 19 Dec 2014 16:18:04 +0000
Message-ID: <cover.1418826016.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id C393C2604D4
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 17:18:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Changes v2->v3
  + Drop applied patch
  + Flush FIFOs in prepare rather than hw_params [Lars-Peter Clausen]

Changes v1->v2
  + Drop negative use count patch [Mark Brown]
  + Remove unnecessary debug print messages [Lars-Peter Clausen]
  + Rewrite iteration as for loop rather than do...while [Mark Brown]
  + Reorder patches to send fixes first [Mark Brown]
  + Simplify device tree code [Mark Brown]
  + Split device tree patch in two [Mark Brown]
  + Expand explanatory comment on channel configuration [Rajeev Kumar]

Arnd: I've not forgotten about updating the spear entries and
      will submit as a separate patch.

Andrew Jackson (5):
  ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap
  ASoC: dwc: Iterate over all channels
  ASoC: dwc: Reorder code in preparation for DT support
  ASoC: dwc: Add devicetree support for Designware I2S
  ASoC: dwc: Add documentation for I2S DT

 .../devicetree/bindings/sound/designware-i2s.txt   |   32 +++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  293 +++++++++++++++-----
 3 files changed, 258 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
