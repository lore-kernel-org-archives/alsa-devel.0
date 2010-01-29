From: jassisinghbrar@gmail.com
Subject: [PATCH] ASoC: AC97: SMDK-WM9713: Convert notes from
	cset to sset
Date: Fri, 29 Jan 2010 10:57:07 +0900
Message-ID: <1264730227-855-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A72B10388F
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 03:07:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

It's more robust when references are provided in control names
rather than numid.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/smdk_wm9713.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 6fa2c9d..24fd39f 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -29,24 +29,15 @@ static struct snd_soc_card smdk;
 
 /*
  Playback (HeadPhone):-
-	Headphone Playback Switch - On
-	$ amixer cset numid=4 1
-
-	Right Headphone Out Mux - Headphone
-	$ amixer cset numid=92 2
-	Left Headphone Out Mux - Headphone
-	$ amixer cset numid=93 2
-
-	Right HP Mixer PCM Playback Switch - On
-	$ amixer cset numid=75 1
-	Left HP Mixer PCM Playback Switch - On
-	$ amixer cset numid=81 1
+	$ amixer sset 'Headphone' unmute
+	$ amixer sset 'Right Headphone Out Mux' 'Headphone'
+	$ amixer sset 'Left Headphone Out Mux' 'Headphone'
+	$ amixer sset 'Right HP Mixer PCM' unmute
+	$ amixer sset 'Left HP Mixer PCM' unmute
 
  Capture (LineIn):-
-	Right Capture Source - Line
-	$ amixer cset numid=86 2
-	Left Capture Source - Line
-	$ amixer cset numid=87 2
+	$ amixer sset 'Right Capture Source' 'Line'
+	$ amixer sset 'Left Capture Source' 'Line'
 */
 
 static struct snd_soc_dai_link smdk_dai = {
-- 
1.6.2.5
