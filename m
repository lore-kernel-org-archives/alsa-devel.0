From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/4] ALSA: hdspm - Set period_bytes_min to 32 *
	4 for new RME cards
Date: Fri, 12 Aug 2011 21:57:47 +0200
Message-ID: <1313179069-8432-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On newer RME cards like RayDAT and AIO, the lower bound is 32 samples
per period in contrast to 64 samples as seen on older cards.

We hence lower period_bytes_min to 32 * 4. Four bytes per sample.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 204e1ce..8dc2a89 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5703,7 +5703,7 @@ static struct snd_pcm_hardware snd_hdspm_playback_subinfo = {
 	.channels_max = HDSPM_MAX_CHANNELS,
 	.buffer_bytes_max =
 	    HDSPM_CHANNEL_BUFFER_BYTES * HDSPM_MAX_CHANNELS,
-	.period_bytes_min = (64 * 4),
+	.period_bytes_min = (32 * 4),
 	.period_bytes_max = (4096 * 4) * HDSPM_MAX_CHANNELS,
 	.periods_min = 2,
 	.periods_max = 512,
@@ -5728,7 +5728,7 @@ static struct snd_pcm_hardware snd_hdspm_capture_subinfo = {
 	.channels_max = HDSPM_MAX_CHANNELS,
 	.buffer_bytes_max =
 	    HDSPM_CHANNEL_BUFFER_BYTES * HDSPM_MAX_CHANNELS,
-	.period_bytes_min = (64 * 4),
+	.period_bytes_min = (32 * 4),
 	.period_bytes_max = (4096 * 4) * HDSPM_MAX_CHANNELS,
 	.periods_min = 2,
 	.periods_max = 512,
-- 
1.7.5.4
