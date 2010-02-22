From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: core: On resume also check the soc
	device state
Date: Mon, 22 Feb 2010 13:27:13 +0200
Message-ID: <1266838033-8087-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 82AA91037F7
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 12:27:59 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Check the card->codec on soc_resume to detect if the soc
device is properly initialized.
If the card->codec is NULL, than do not continue the resume
operation, since the device is not initialized properly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

The soc_susbend code is checking, if the soc device is properly
initialized, but on soc_resume the check is missing, and it is
unlikely that the soc device is actually initialized between these
two calls.
This fixes a crash, when doing suspend on a system where a soc
device is not properly initialized.
The crash happens on resume path, since the suspend has been protected
against such a scenario.

 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1c0336..a03bac9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -963,6 +963,12 @@ static int soc_resume(struct device *dev)
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai *cpu_dai = card->dai_link[0].cpu_dai;
 
+	/* If the initialization of this soc device failed, there is no codec
+	 * associated with it. Just bail out in this case.
+	 */
+	if (!card->codec)
+		return 0;
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
-- 
1.7.0
