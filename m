From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 0/5] ASoC: dwc: Add device tree support to
	designware I2S
Date: Wed, 03 Dec 2014 16:38:36 +0000
Message-ID: <547F3C8C.5000607@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A8826047A
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 17:38:38 +0100 (CET)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Andrew Jackson (5):
  ASoC: dwc: Allocate resources with devm_ioremap_resource
  ASoC: dwc: Don't allow negative use counts
  ASoC: dwc: Iterate over all channels
  ASoC: dwc: Add devicetree support for Designware I2S
  ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap

 .../devicetree/bindings/sound/designware-i2s.txt   |   32 ++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  313 ++++++++++++++------
 3 files changed, 260 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
