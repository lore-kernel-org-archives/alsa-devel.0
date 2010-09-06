From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add more jack button slots
Date: Mon,  6 Sep 2010 16:08:56 +0100
Message-ID: <1283785736-14470-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85B6C245CC
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 17:09:00 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some devices have more flexible microphone detection and can detect
a wider range of buttons.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/jack.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index d90b9fa..c140fc7 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -47,6 +47,9 @@ enum snd_jack_types {
 	SND_JACK_BTN_0		= 0x4000,
 	SND_JACK_BTN_1		= 0x2000,
 	SND_JACK_BTN_2		= 0x1000,
+	SND_JACK_BTN_3		= 0x0800,
+	SND_JACK_BTN_4		= 0x0400,
+	SND_JACK_BTN_5		= 0x0200,
 };
 
 struct snd_jack {
@@ -55,7 +58,7 @@ struct snd_jack {
 	int type;
 	const char *id;
 	char name[100];
-	unsigned int key[3];   /* Keep in sync with definitions above */
+	unsigned int key[6];   /* Keep in sync with definitions above */
 	void *private_data;
 	void (*private_free)(struct snd_jack *);
 };
-- 
1.7.1
