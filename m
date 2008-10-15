From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Handle NULL jacks in snd_jack_report()
Date: Wed, 15 Oct 2008 17:07:47 +0100
Message-ID: <1224086867-23934-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D68F724153
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 18:08:06 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Facilitate drivers that wish to carry on if they can't create a jack
input device by handling attempts to report the state of a NULL jack,
removing the need to check for initialisation before use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/jack.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 8133a2b..bd2d9e6 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -147,6 +147,9 @@ EXPORT_SYMBOL(snd_jack_set_parent);
  */
 void snd_jack_report(struct snd_jack *jack, int status)
 {
+	if (!jack)
+		return;
+
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
-- 
1.5.6.5
