From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add missing audio path between Mono Mixer and
	Mic PGAs.
Date: Tue, 18 Mar 2008 10:18:44 +0000
Message-ID: <1205835524-20225-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9803410381D
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 11:18:45 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Robert Jarzmik <rjarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

From: Robert Jarzmik <rjarzmik@free.fr>

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index e2949c5..172ca1a 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -500,6 +500,8 @@ static const char *audio_map[][3] = {
 	{"Mono Mixer", "Aux Playback Switch",     "Aux DAC"},
 	{"Mono Mixer", "Bypass Playback Switch",  "Line Mixer"},
 	{"Mono Mixer", "PCM Playback Switch",     "AC97 Mixer"},
+	{"Mono Mixer", "Mic 1 Sidetone Switch", "Mic A PGA"},
+	{"Mono Mixer", "Mic 2 Sidetone Switch", "Mic B PGA"},
 	{"Mono Mixer", NULL,  "Capture Mono Mux"},
 
 	/* DAC inv mux 1 */
-- 
1.5.4.4
