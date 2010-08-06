From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Fri,  6 Aug 2010 10:39:12 +0300
Message-ID: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CA7310395F
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 09:39:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: jkrzyszt@tis.icnet.pl, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

The following series introduces some cleanups for OMAP platforms in
multi-component branch.

- Enable audio for OMAP1 class
- Registers only the available amount of omap-mcbsp-dai devices for OMAP2,3,
  and 4

Please do verify, if the chages are correct, especially the number of McBSP
ports on different devices.

Liam: in case you take this, you can squash this to the corresponding commit.

Peter

---
Peter Ujfalusi (3):
  ASoC: multi-comp: OMAP McBSP: use macro for platform_device
  ASoC: multi-comp: OMAP McBSP: Enable audio on OMAP1 platform
  ASoC: multi-comp: OMAP2,3,4 McBSP: register correct number of ports

 arch/arm/mach-omap1/devices.c           |   24 +++++++++++++++
 arch/arm/mach-omap2/devices.c           |   50 ++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 ++++
 3 files changed, 58 insertions(+), 23 deletions(-)

--
1.7.2
