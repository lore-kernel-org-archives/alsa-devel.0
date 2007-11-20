From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add D1 power event to power down event sequence
Date: Tue, 20 Nov 2007 09:25:30 +0000
Message-ID: <1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 854C324A23
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:45:32 +0100 (CET)
In-Reply-To: <1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Liam Girdwood <liam@localhost.localdomain>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

---
 sound/soc/soc-core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 265bd55..f3e1b74 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -288,6 +288,14 @@ static void close_delayed_work(struct work_struct *work)
 		/* are we waiting on this codec DAI stream */
 		if (codec_dai->pop_wait == 1) {
 
+			/* power down the codec to D1 if no longer active */
+			if (codec->active == 0) {
+				dbg("pop wq D1 %s %s\n", codec->name,
+					codec_dai->playback.stream_name);
+				snd_soc_dapm_device_event(socdev,
+					SNDRV_CTL_POWER_D1);
+			}
+
 			codec_dai->pop_wait = 0;
 			snd_soc_dapm_stream_event(codec,
 				codec_dai->playback.stream_name,
-- 
1.5.3.5
