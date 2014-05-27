From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH]  ASoC: fix snd_soc_jack_add_gpiods stub
Date: Tue, 27 May 2014 17:46:05 +0200
Message-ID: <7602265.lTCp4nNe4p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C5AB12659CD
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:46:13 +0200 (CEST)
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
Cc: broonie@kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

f025d3b9c64e1 ("ASoC: jack: Add support for GPIO descriptor defined jack
pins") added this new interface, but the stub function provided for
non-gpiolib builds was defined in the header file as a global function,
leading to lots of "multiple definition of `snd_soc_jack_add_gpiods'"
warnings.

This adds the obvious "static inline" annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 98dca42..559dc53 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -464,9 +464,9 @@ static inline int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 	return 0;
 }
 
-int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
-			    struct snd_soc_jack *jack,
-			    int count, struct snd_soc_jack_gpio *gpios)
+static inline int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
+					  struct snd_soc_jack *jack,
+					  int count, struct snd_soc_jack_gpio *gpios)
 {
 	return 0;
 }
