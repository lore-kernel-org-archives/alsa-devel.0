From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: DAPM - Clean up header information.
Date: Mon,  6 Feb 2012 16:05:29 +0000
Message-ID: <1328544329-10593-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DDC1103B76
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 17:05:34 +0100 (CET)
Received: by wera1 with SMTP id a1so4578877wer.10
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 08:05:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix some spelling mistakes in the header and remove the todo items. Most
todo items are now available as kcontrol options now anyway.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e2a9797..87732d5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -14,19 +14,13 @@
  *      dynamic configuration of codec internal audio paths and active
  *      DACs/ADCs.
  *    o Platform power domain - can support external components i.e. amps and
- *      mic/meadphone insertion events.
+ *      mic/headphone insertion events.
  *    o Automatic Mic Bias support
  *    o Jack insertion power event initiation - e.g. hp insertion will enable
  *      sinks, dacs, etc
- *    o Delayed powerdown of audio susbsystem to reduce pops between a quick
+ *    o Delayed power down of audio subsystem to reduce pops between a quick
  *      device reopen.
  *
- *  Todo:
- *    o DAPM power change sequencing - allow for configurable per
- *      codec sequences.
- *    o Support for analogue bias optimisation.
- *    o Support for reduced codec oversampling rates.
- *    o Support for reduced codec bias currents.
  */
 
 #include <linux/module.h>
-- 
1.7.5.4
