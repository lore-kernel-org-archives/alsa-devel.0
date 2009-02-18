From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/11] ASoC: Fix WM8753 DAIs unregistering
Date: Wed, 18 Feb 2009 12:02:24 +0000
Message-ID: <1234958553-16049-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB6210388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:42 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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
Cc: Paul Fertser <fercerpav@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Paul Fertser <fercerpav@gmail.com>

WM8753 uses a tricky way to switch DAIs "on the fly", for that it
registers 2 dummy DAIs and substitutes them depending on mixer control.

List element of registered dummy DAIs should be preserved to allow
unregistering of DAIs on module unload.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 6f9e6be..dc6042c 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1451,30 +1451,35 @@ static void wm8753_set_dai_mode(struct snd_soc_codec *codec, unsigned int mode)
 	if (mode < 4) {
 		int playback_active, capture_active, codec_active, pop_wait;
 		void *private_data;
+		struct list_head list;
 
 		playback_active = wm8753_dai[0].playback.active;
 		capture_active = wm8753_dai[0].capture.active;
 		codec_active = wm8753_dai[0].active;
 		private_data = wm8753_dai[0].private_data;
 		pop_wait = wm8753_dai[0].pop_wait;
+		list = wm8753_dai[0].list;
 		wm8753_dai[0] = wm8753_all_dai[mode << 1];
 		wm8753_dai[0].playback.active = playback_active;
 		wm8753_dai[0].capture.active = capture_active;
 		wm8753_dai[0].active = codec_active;
 		wm8753_dai[0].private_data = private_data;
 		wm8753_dai[0].pop_wait = pop_wait;
+		wm8753_dai[0].list = list;
 
 		playback_active = wm8753_dai[1].playback.active;
 		capture_active = wm8753_dai[1].capture.active;
 		codec_active = wm8753_dai[1].active;
 		private_data = wm8753_dai[1].private_data;
 		pop_wait = wm8753_dai[1].pop_wait;
+		list = wm8753_dai[1].list;
 		wm8753_dai[1] = wm8753_all_dai[(mode << 1) + 1];
 		wm8753_dai[1].playback.active = playback_active;
 		wm8753_dai[1].capture.active = capture_active;
 		wm8753_dai[1].active = codec_active;
 		wm8753_dai[1].private_data = private_data;
 		wm8753_dai[1].pop_wait = pop_wait;
+		wm8753_dai[1].list = list;
 	}
 	wm8753_dai[0].codec = codec;
 	wm8753_dai[1].codec = codec;
-- 
1.5.6.3
