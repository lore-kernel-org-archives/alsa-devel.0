From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: arizona: Use auto disable muxes for
	routing
Date: Thu, 30 Apr 2015 11:38:52 +0100
Message-ID: <1430390332-14037-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1430390332-14037-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32EBE265CB5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:46:52 +0200 (CEST)
In-Reply-To: <1430390332-14037-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The mixer core on the Arizona devices is powered up whenever any routing
is non-zero. This patch saves a little power and avoids a few difficult
corner cases (around the mixer core being powered whilst there is no
clock available), by using the autodisable mux functionality to only
write out the settings for the muxes when they are powered up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 11ff899..bacc296 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -107,8 +107,8 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 			     arizona_mixer_tlv)
 
 #define ARIZONA_MUX_ENUM_DECL(name, reg) \
-	SOC_VALUE_ENUM_SINGLE_DECL(name, reg, 0, 0xff,			\
-				   arizona_mixer_texts, arizona_mixer_values)
+	SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL( \
+		name, reg, 0, 0xff, arizona_mixer_texts, arizona_mixer_values)
 
 #define ARIZONA_MUX_CTL_DECL(name) \
 	const struct snd_kcontrol_new name##_mux =	\
-- 
1.7.2.5
