From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V3 0/2] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Sat,  9 Dec 2017 12:26:33 +0100
Message-ID: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 316A3266D09
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 12:27:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@martin.sperl.org, Matthias Reichl <hias@horus.com>, phil@raspberrypi.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This small series fixes the probing of bcm2835-i2s, which is broken
since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework").

Changes in V3:
* split up patch into dt-binding and functional part

Changes in V2:
* add Fixes, Reviewed-by and Tested-by tags

Stefan Wahren (2):
  dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
  ARM: dts: bcm283x: Fix probing of bcm2835-i2s

 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
 arch/arm/boot/dts/bcm283x.dtsi                               | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.7.4
