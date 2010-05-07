From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tpa6130a2: Use the core to set the
	gain limit
Date: Fri,  7 May 2010 14:24:09 +0300
Message-ID: <1273231451-6697-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9591C10388D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 13:24:50 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

Core will receive support for limiting the volume on controls, so
the custom way of doing it in the tpa driver is no longer needed.
There was also a problem within the tpa driver when custom limit
has been configured. The second patch fixes that.

The combination of the snd_soc_limit_volume, and this series works
really nicely together.

---
Peter Ujfalusi (2):
  Revert "ASoC: tpa6130a2: Support for limiting gain"
  ASoC: tpa6130a2: Fix for the custom kcontrol functions

 include/sound/tpa6130a2-plat.h |    1 -
 sound/soc/codecs/tpa6130a2.c   |   90 +++++++--------------------------------
 2 files changed, 16 insertions(+), 75 deletions(-)
