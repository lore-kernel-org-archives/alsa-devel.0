From: <vm.rod25@gmail.com>
Subject: [PATCH v3 0/9] Add Omapl138-Hawkboard support
Date: Thu, 14 Oct 2010 12:21:32 -0500
Message-ID: <1287076892-4342-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id EED002412E
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 19:20:41 +0200 (CEST)
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
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
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
  davinci: USB-OHCI support for Omapl138-Hawkboard

 arch/arm/mach-davinci/board-omapl138-hawk.c |  300 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c               |   23 ++-
 arch/arm/mach-davinci/include/mach/mux.h    |    4 +
 sound/soc/davinci/Kconfig                   |    5 +-
 sound/soc/davinci/davinci-evm.c             |    6 +-
 5 files changed, 333 insertions(+), 5 deletions(-)
