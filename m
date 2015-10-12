From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 00/10] Add support for Imagination
	Technologies audio controllers
Date: Mon, 12 Oct 2015 13:40:27 +0100
Message-ID: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DE3052614A9
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:41:32 +0200 (CEST)
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

Add drivers and binding documents for the following Imagination Technologies audio controllers:

I2S Input Controller
I2S Output Controller
Parallel Output Controller
SPDIF Input Controller
SPDIF Output Controller

These controllers are used in Pistachio SoC

Changes in V2:
- Sparse warnings fixed

Damien.Horsley (10):
  ASoC: img: Add binding document for I2S input controller
  ASoC: img: Add driver for I2S input controller
  ASoC: img: Add binding document for I2S output controller
  ASoC: img: Add driver for I2S output controller
  ASoC: img: Add binding document for parallel output controller
  ASoC: img: Add driver for parallel output controller
  ASoC: img: Add binding document for SPDIF input controller
  ASoC: img: Add driver for SPDIF input controller
  ASoC: img: Add binding document for SPDIF output controller
  ASoC: img: Add driver for SPDIF output controller

 .../devicetree/bindings/sound/img,i2s-in.txt       |  45 ++
 .../devicetree/bindings/sound/img,i2s-out.txt      |  49 ++
 .../devicetree/bindings/sound/img,parallel-out.txt |  44 ++
 .../devicetree/bindings/sound/img,spdif-in.txt     |  41 ++
 .../devicetree/bindings/sound/img,spdif-out.txt    |  44 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/img/Kconfig                              |  44 ++
 sound/soc/img/Makefile                             |   5 +
 sound/soc/img/img-i2s-in.c                         | 508 +++++++++++++
 sound/soc/img/img-i2s-out.c                        | 552 ++++++++++++++
 sound/soc/img/img-parallel-out.c                   | 373 ++++++++++
 sound/soc/img/img-spdif-in.c                       | 799 +++++++++++++++++++++
 sound/soc/img/img-spdif-out.c                      | 433 +++++++++++
 14 files changed, 2939 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-out.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,parallel-out.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-out.txt
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/img-i2s-in.c
 create mode 100644 sound/soc/img/img-i2s-out.c
 create mode 100644 sound/soc/img/img-parallel-out.c
 create mode 100644 sound/soc/img/img-spdif-in.c
 create mode 100644 sound/soc/img/img-spdif-out.c

-- 
2.1.4
