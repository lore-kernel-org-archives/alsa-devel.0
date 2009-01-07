From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ALSA: Add support for video out to the
	jack reporting API
Date: Wed,  7 Jan 2009 20:18:31 +0000
Message-ID: <1231359511-7240-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090107201131.GA6413@sirena.org.uk>
	<1231359511-7240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D0DC31037F0
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 21:18:45 +0100 (CET)
In-Reply-To: <1231359511-7240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jani Nikula <ext-jani.1.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add support for reporting new jack types SND_JACK_VIDEOOUT and
SND_JACK_AVOUT (a combination of LINEOUT and VIDEOOUT) to the jack
reporting API.

Also add the corresponding SW_VIDEOOUT_INSERT switch to the input system
header.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/input.h |    1 +
 include/sound/jack.h  |    2 ++
 sound/core/jack.c     |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 9a6355f..adc1332 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -661,6 +661,7 @@ struct input_absinfo {
 #define SW_DOCK			0x05  /* set = plugged into dock */
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
+#define SW_VIDEOOUT_INSERT	0x08  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 85266a2..6b013c6 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -40,6 +40,8 @@ enum snd_jack_types {
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
 	SND_JACK_LINEOUT	= 0x0004,
 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
+	SND_JACK_VIDEOOUT	= 0x0010,
+	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
 };
 
 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index b2da10c..43b10d6 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -28,6 +28,7 @@ static int jack_types[] = {
 	SW_MICROPHONE_INSERT,
 	SW_LINEOUT_INSERT,
 	SW_JACK_PHYSICAL_INSERT,
+	SW_VIDEOOUT_INSERT,
 };
 
 static int snd_jack_dev_free(struct snd_device *device)
-- 
1.5.6.3
