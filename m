From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Clean up tabs.
Date: Tue, 20 Nov 2007 09:25:33 +0000
Message-ID: <1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 536BC24A12
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:45:25 +0100 (CET)
In-Reply-To: <1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e8d7fae..4a5bd85 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1298,9 +1298,9 @@ int snd_soc_dapm_device_event(struct snd_soc_device *socdev, int event)
 	struct snd_soc_machine *machine = socdev->machine;
 
 	if (machine->dapm_event)
-				machine->dapm_event(machine, event);
+		machine->dapm_event(machine, event);
 	if (codec->dapm_event)
-				codec->dapm_event(codec, event);
+		codec->dapm_event(codec, event);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_device_event);
-- 
1.5.3.5
