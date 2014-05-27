From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: jack: Clarify GPIO descriptor lookup in
	struct snd_soc_jack_gpio doc
Date: Tue, 27 May 2014 13:54:18 +0300
Message-ID: <1401188058-18129-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BE74265786
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 12:54:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Clarify struct snd_soc_jack_gpio documentation for the idx and name fields.
Because name is passed as connection ID to gpiod_get_index() when using GPIO
descriptor defined jack pins it is not only used as a label in debugfs but
also as function name lookup in systems that support functions names for
GPIOs.

Clarify also idx since the index is within the function of the GPIO consumer
device and not within the device itself only.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 include/sound/soc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 15ee2f71b92e..72e056529745 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -599,9 +599,11 @@ struct snd_soc_jack_zone {
  * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
  *
  * @gpio:         legacy gpio number
- * @idx:          gpio descriptor index within the GPIO consumer device
+ * @idx:          gpio descriptor index within the function of the GPIO
+ *                consumer device
  * @gpiod_dev     GPIO consumer device
- * @name:         gpio name
+ * @name:         gpio name. Also as connection ID for the GPIO consumer
+ *                device function name lookup
  * @report:       value to report when jack detected
  * @invert:       report presence in low state
  * @debouce_time: debouce time in ms
-- 
2.0.0.rc2
