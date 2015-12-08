From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 0/2] Add support for Pistachio internal DAC
Date: Tue, 8 Dec 2015 17:05:22 +0000
Message-ID: <1449594324-2597-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A49260564
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 18:05:52 +0100 (CET)
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

Damien.Horsley (2):
  ASoC: img: Add binding document for Pistachio internal DAC
  ASoC: img: Add driver for Pistachio internal DAC

 .../bindings/sound/img,pistachio-internal-dac.txt  |  18 ++
 sound/soc/img/Kconfig                              |   8 +
 sound/soc/img/Makefile                             |   2 +
 sound/soc/img/pistachio-internal-dac.c             | 316 +++++++++++++++++++++
 4 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
 create mode 100644 sound/soc/img/pistachio-internal-dac.c

-- 
2.1.4
