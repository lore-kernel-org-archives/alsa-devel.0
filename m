From: Michael Stecklein <m-stecklein@ti.com>
Subject: [PATCH v2 0/2] Add support for TI TAS6424 digital
	amplifier
Date: Mon, 17 Jul 2017 11:25:45 -0500
Message-ID: <1500308747-27973-1-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id E81C1266D71
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:25:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Michael Stecklein <m-stecklein@ti.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This two-patch series adds the dt bindings, driver, and other related
changes for the TAS6424 digital amplifier. I am upstreaming this driver
on behalf of Andreas.

Regards,
Michael Stecklein <m-stecklein@ti.com>

Changes since v1:
 - rebased on 4.13-rc1

Original v1 patches:
 - https://patchwork.kernel.org/patch/9795235/
 - https://patchwork.kernel.org/patch/9795237/

Andreas Dannenberg (1):
  ASoC: add support for TAS6424 digital amplifier

Michael Stecklein (1):
  dt-bindings: sound: add bindings for TAS6424

 .../devicetree/bindings/sound/ti,tas6424.txt       |  31 +
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas6424.c                         | 755 +++++++++++++++++++++
 sound/soc/codecs/tas6424.h                         | 127 ++++
 5 files changed, 923 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h

-- 
2.7.4
