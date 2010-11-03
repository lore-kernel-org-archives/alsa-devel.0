From: <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 0/9] Add Omapl138-Hawkboard support
Date: Wed,  3 Nov 2010 12:14:30 -0600
Message-ID: <1288808070-2309-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

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

 arch/arm/mach-davinci/board-omapl138-hawk.c |  312 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c               |   22 ++-
 arch/arm/mach-davinci/include/mach/mux.h    |    4 +
 sound/soc/davinci/Kconfig                   |    5 +-
 sound/soc/davinci/davinci-evm.c             |    6 +-
 5 files changed, 344 insertions(+), 5 deletions(-)
