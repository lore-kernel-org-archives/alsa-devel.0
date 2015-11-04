From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V3 00/11] Add support for Imagination
	Technologies audio controllers
Date: Wed, 4 Nov 2015 14:40:46 +0000
Message-ID: <1446648057-373-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 47581260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:41:53 +0100 (CET)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add drivers and documentation for the following
Imagination Technologies audio controllers:

I2S Input Controller
I2S Output Controller
Parallel Output Controller
SPDIF Input Controller
SPDIF Output Controller

These controllers are used in Pistachio SoC

Changes in V3:
- Addressed comments from Mark Brown

Damien.Horsley (11):
  ASoC: img: Add binding document for I2S input controller
  ASoC: img: Add driver for I2S input controller
  ASoC: img: Add binding document for I2S output controller
  ASoC: img: Add driver for I2S output controller
  ASoC: img: Add binding document for parallel output controller
  ASoC: img: Add driver for parallel output controller
  ASoC: img: Add binding document for SPDIF input controller
  ASoC: img: Add driver for SPDIF input controller
  ASoC: img: Add documentation for SPDIF in controls
  ASoC: img: Add binding document for SPDIF output controller
  ASoC: img: Add driver for SPDIF output controller

 .../devicetree/bindings/sound/img,i2s-in.txt       |  47 ++
 .../devicetree/bindings/sound/img,i2s-out.txt      |  51 ++
 .../devicetree/bindings/sound/img,parallel-out.txt |  44 ++
 .../devicetree/bindings/sound/img,spdif-in.txt     |  41 ++
 .../devicetree/bindings/sound/img,spdif-out.txt    |  44 ++
 Documentation/sound/alsa/img,spdif-in.txt          |  49 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/img/Kconfig                              |  44 ++
 sound/soc/img/Makefile                             |   5 +
 sound/soc/img/img-i2s-in.c                         | 516 +++++++++++++
 sound/soc/img/img-i2s-out.c                        | 565 +++++++++++++++
 sound/soc/img/img-parallel-out.c                   | 327 +++++++++
 sound/soc/img/img-spdif-in.c                       | 806 +++++++++++++++++++++
 sound/soc/img/img-spdif-out.c                      | 441 +++++++++++
 15 files changed, 2982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-out.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,parallel-out.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-out.txt
 create mode 100644 Documentation/sound/alsa/img,spdif-in.txt
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/img-i2s-in.c
 create mode 100644 sound/soc/img/img-i2s-out.c
 create mode 100644 sound/soc/img/img-parallel-out.c
 create mode 100644 sound/soc/img/img-spdif-in.c
 create mode 100644 sound/soc/img/img-spdif-out.c

-- 
2.1.4
