From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v2 0/3] ASoc: TAS6424: Add support for mute,
	standby, and faster power on
Date: Fri, 27 Apr 2018 15:55:46 +0200
Message-ID: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E474926728A
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 15:55:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com, Jean-Jacques Hiblot <jjhiblot@ti.com>, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

mute and standby pins are available on the codec. If they are connected, they
should be managed by the driver, instead of relying on gpio hogs or on the
initial state of the GPIOs.

This series also includes a patch to improve the start-up time of the channels
by disabling built-in DC diagnostics. Those diagnosdtics basically serve to
detect :
- wires shorted together
- wire shorted to ground or vbat
- wire disconnected
This is not useful for all platforms and the addition to the startup time is
quite noticeable (230ms). The diagnostics can be enabled/disabled using a
dedicated ALSA control.


Changes in v2:
- use a ALSA control to enable/disable the auto diagnostics instead of
  relying on a DTS property.
- fixed typos
- use gpios (plural) instead of gpio in the documentation of the bindings


Jean-Jacques Hiblot (3):
  ASoC: tas6424: Add support for the standby pin
  ASoC: tas6424: Add support for the mute pin
  ASoC: tas6424: Allow disabling auto diagnostics for faster power-on

 .../devicetree/bindings/sound/ti,tas6424.txt       |  2 +
 sound/soc/codecs/tas6424.c                         | 78 +++++++++++++++++++++-
 sound/soc/codecs/tas6424.h                         |  4 ++
 3 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.7.4
