From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Fri,  6 Aug 2010 14:10:35 +0300
Message-ID: <1281093038-24247-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 11B4110399E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 13:10:46 +0200 (CEST)
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
Cc: jkrzyszt@tis.icnet.pl, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

Changes since v1:
- include plat/mcbsp.c in arch/arm/mach-omap1/devices.c
- Runtime port number configuration based on OMAP type (both omap1 and omap2)

Commit message from the first series:

The following series introduces some cleanups for OMAP platforms in
multi-component branch.

- Enable audio for OMAP1 class
- Registers only the available amount of omap-mcbsp-dai devices for OMAP2,3,
  and 4

Please do verify, if the chages are correct, especially the number of McBSP
ports on different devices.

Liam: in case you take this, you can squash this to the corresponding commit.

Since I do not have access at the moment to OMAP1 based board, the changes has
not been tested, but at least it should allow the audio (in theory)..

Peter

---
Peter Ujfalusi (3):
  ASoC: multi-comp: OMAP McBSP: use macro for platform_device
  ASoC: multi-comp: OMAP McBSP: Enable audio on OMAP1 platform
  ASoC: multi-comp: OMAP2,3,4 McBSP: register correct number of ports

 arch/arm/mach-omap1/devices.c           |   26 +++++++++++++++++
 arch/arm/mach-omap2/devices.c           |   46 ++++++++++++-------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 +++++
 3 files changed, 51 insertions(+), 28 deletions(-)

--
1.7.2
