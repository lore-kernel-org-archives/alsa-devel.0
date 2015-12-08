From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 0/3] Add support for Texas Instruments
	pcm3168a codec
Date: Tue, 8 Dec 2015 15:58:57 +0000
Message-ID: <1449590340-14682-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8438B260431
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:00:11 +0100 (CET)
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

Add SOC_DOUBLE_STS macro

Add driver and binding docuemnt for Texas Instruments pcm3168a codec

Changes in V2:
	Addressed comments from Mark Brown

Damien.Horsley (3):
  ASoC: Add SOC_DOUBLE_STS macro
  ASoC: pcm3168a: Add binding document for pcm3168a codec
  ASoC: pcm3168a: Add driver for pcm3168a codec

 .../devicetree/bindings/sound/ti,pcm3168a.txt      |  48 ++
 include/sound/soc.h                                |   8 +
 sound/soc/codecs/Kconfig                           |  17 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/pcm3168a-i2c.c                    |  66 ++
 sound/soc/codecs/pcm3168a-spi.c                    |  65 ++
 sound/soc/codecs/pcm3168a.c                        | 767 +++++++++++++++++++++
 sound/soc/codecs/pcm3168a.h                        | 100 +++
 8 files changed, 1077 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
 create mode 100644 sound/soc/codecs/pcm3168a-i2c.c
 create mode 100644 sound/soc/codecs/pcm3168a-spi.c
 create mode 100644 sound/soc/codecs/pcm3168a.c
 create mode 100644 sound/soc/codecs/pcm3168a.h

-- 
2.1.4
