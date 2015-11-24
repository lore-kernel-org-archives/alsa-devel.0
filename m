From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 0/2] Add support for Texas Instruments pcm3168a
	codec
Date: Tue, 24 Nov 2015 14:43:42 +0000
Message-ID: <1448376224-23964-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 32960265AD0
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 15:43:58 +0100 (CET)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "Maciej S.
 Szmigiero" <mail@maciej.szmigiero.name>, Bard Liao <bardliao@realtek.com>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Charles Keepax <ckeepax@gmail.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, James Hartley <james.hartley@imgtec.com>, Thomas Niederprum <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add driver and binding docuemnt for Texas Instruments pcm3168a codec

Damien.Horsley (2):
  ASoC: pcm3168a: Add binding document for pcm3168a codec
  ASoC: pcm3168a: Add driver for pcm3168a codec

 .../devicetree/bindings/sound/ti,pcm3168a.txt      |  48 ++
 sound/soc/codecs/Kconfig                           |  17 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/pcm3168a-i2c.c                    |  66 ++
 sound/soc/codecs/pcm3168a-spi.c                    |  65 ++
 sound/soc/codecs/pcm3168a.c                        | 766 +++++++++++++++++++++
 sound/soc/codecs/pcm3168a.h                        | 111 +++
 7 files changed, 1079 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
 create mode 100644 sound/soc/codecs/pcm3168a-i2c.c
 create mode 100644 sound/soc/codecs/pcm3168a-spi.c
 create mode 100644 sound/soc/codecs/pcm3168a.c
 create mode 100644 sound/soc/codecs/pcm3168a.h

-- 
2.1.4
