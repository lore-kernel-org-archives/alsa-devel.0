From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/3] ASoC: max98090: Fix ill-defined sidetone
	route
Date: Mon, 24 Nov 2014 15:32:36 +0200
Message-ID: <1416835957-14153-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 12C3A260505
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 14:33:20 +0100 (CET)
In-Reply-To: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non
mixer/mux widgets") revealed ill-defined control in a route between
"STENL Mux" and DACs in max98090.c:

max98090 i2c-193C9890:00: Control not supported for path STENL Mux -> [NULL] -> DACL
max98090 i2c-193C9890:00: ASoC: no dapm match for STENL Mux --> NULL --> DACL
max98090 i2c-193C9890:00: ASoC: Failed to add route STENL Mux -> NULL -> DACL
max98090 i2c-193C9890:00: Control not supported for path STENL Mux -> [NULL] -> DACR
max98090 i2c-193C9890:00: ASoC: no dapm match for STENL Mux --> NULL --> DACR
max98090 i2c-193C9890:00: ASoC: Failed to add route STENL Mux -> NULL -> DACR

Since there is no control between "STENL Mux" and DACs the control name must
be NULL not "NULL".

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 19258a910974..331b3e473c51 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1397,8 +1397,8 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"STENL Mux", "Sidetone Left", "DMICL"},
 	{"STENR Mux", "Sidetone Right", "ADCR"},
 	{"STENR Mux", "Sidetone Right", "DMICR"},
-	{"DACL", "NULL", "STENL Mux"},
-	{"DACR", "NULL", "STENL Mux"},
+	{"DACL", NULL, "STENL Mux"},
+	{"DACR", NULL, "STENL Mux"},
 
 	{"AIFINL", NULL, "SHDN"},
 	{"AIFINR", NULL, "SHDN"},
-- 
2.1.3
