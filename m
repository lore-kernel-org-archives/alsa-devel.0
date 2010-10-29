From: <vm.rod25@gmail.com>
Subject: [PATCH v6 0/9] Add Omapl138-Hawkboard support
Date: Fri, 29 Oct 2010 10:10:36 -0500
Message-ID: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from victor-desktop (unknown [200.52.114.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A39C424490
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 17:10:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, sshtylyov@mvista.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, khasim@ti.com, caglarakyuz@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds
EMAC, EDMA, ASoC, SOUND, MMC/SD and USB OHCI
support for the Hawkboard-L138 system
It is under the machine name "omapl138_hawkboard".
This system is based on the da850 davinci CPU architecture.

Victor Rodriguez (9):
  davinci: EMAC support for Omapl138-Hawkboard
  davinci: EDMA support for Omapl138-Hawkboard
  davinci: ASoC support for Omapl138-Hawkboard
  davinci: McASP configuration for Omapl138-Hawkboard
  davinci: Audio support for Omapl138-Hawkboard
  davinci: MMC/SD and USB-OHCI configuration for Omapl138-Hawkboard
  davinci: MMC/SD support for Omapl138-Hawkboar
  davinci: USB clocks for Omapl138-Hawkboard
  davinci: USB1.1 support for Omapl138-Hawkboard

 arch/arm/mach-davinci/board-omapl138-hawk.c |  313 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c               |   22 ++-
 arch/arm/mach-davinci/include/mach/mux.h    |    4 +
 sound/soc/davinci/Kconfig                   |    5 +-
 sound/soc/davinci/davinci-evm.c             |    6 +-
 5 files changed, 345 insertions(+), 5 deletions(-)
