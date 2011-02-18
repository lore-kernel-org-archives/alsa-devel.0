From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add kerneldoc for jack_status_check
	callback
Date: Fri, 18 Feb 2011 00:42:46 +0000
Message-ID: <1297989766-1274-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <>
	<1297989766-1274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6433C24339
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 01:42:48 +0100 (CET)
In-Reply-To: <1297989766-1274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fb57c33..65d865f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -437,6 +437,9 @@ struct snd_soc_jack_zone {
  * @invert:       report presence in low state
  * @debouce_time: debouce time in ms
  * @wake:	  enable as wake source
+ * @jack_status_check: callback function which overrides the detection
+ *		       to provide more complex checks (eg, reading an
+ *		       ADC).
  */
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio {
-- 
1.7.2.3
