From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH V2 0/2] ARM/ASoC: Davinci: Device Tree Update
Date: Fri, 4 Jan 2013 15:24:35 +0530
Message-ID: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id D4DC8261703
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 10:54:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, gururaja.hebbar@ti.com, rob@landley.net, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

1. Add pinctrl for McASP Module
2. Add DT support for Davinci machine platform

This patch-set is tested on Davinci platform (DA850 EVM). This series applies on
top of tag next-20130103 git tree
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

These patches cannot be tested directly on mainline kernel (DT based).
This is because dma is not yet completely ported to Davinci ASoC. I had to add
few hacks to get Audio working on Davinci DA850 platform.

For reference, I have placed the entire working tree @ 
Tree : https://gitorious.org/davinci-asoc-dt/davinci-asoc-dt
Branch : dev_next-20130103_davinci_asoc_dt

Changes in V2
	 - Remove reference to Linux & software details from DT binding

Hebbar, Gururaja (2):
  ASoC: davinci-mcasp: Add pinctrl support
  ASoC: Davinci: machine: Add device tree binding

 .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
 sound/soc/davinci/davinci-evm.c                    |  179 +++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.c                  |    7 +
 3 files changed, 219 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
