From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V3 0/2] Add support for Pistachio internal DAC
Date: Wed, 9 Dec 2015 16:30:07 +0000
Message-ID: <1449678609-5592-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A1CC2605B7
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 17:31:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add binding document and driver for Pistachio internal DAC

Changes in V3:
	Mute control definition changed to SOC_SINGLE
	Codec driver probe function added to associate regmap with codec

Damien.Horsley (2):
  ASoC: img: Add binding document for Pistachio internal DAC
  ASoC: img: Add driver for Pistachio internal DAC

 .../bindings/sound/img,pistachio-internal-dac.txt  |  18 ++
 sound/soc/img/Kconfig                              |   8 +
 sound/soc/img/Makefile                             |   2 +
 sound/soc/img/pistachio-internal-dac.c             | 287 +++++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
 create mode 100644 sound/soc/img/pistachio-internal-dac.c

-- 
2.1.4
