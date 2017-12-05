From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 0/2] Add support for TI TAS6424 digital
	amplifier
Date: Tue, 5 Dec 2017 09:54:10 -0600
Message-ID: <20171205155412.20137-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id B9729266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 16:54:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This series adds support for the TAS6424 digital amplifier. A lot has
changed from the last time this upstreaming was attempted, I've taken
over this effort for Michael and I don't really have an exact change log
but hopefully I've addressed all comments from v3.

Thanks,
Andrew

Andreas Dannenberg (1):
  ASoC: Add support for TAS6424 digital amplifier

Michael Stecklein (1):
  dt-bindings: sound: add bindings for TAS6424

 .../devicetree/bindings/sound/ti,tas6424.txt       |  20 +
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas6424.c                         | 707 +++++++++++++++++++++
 sound/soc/codecs/tas6424.h                         | 144 +++++
 5 files changed, 881 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h

-- 
2.15.0
