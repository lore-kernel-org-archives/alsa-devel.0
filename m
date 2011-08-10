From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: DAPM: Allow multiple mixer sources
	to be routed via the same switch
Date: Wed, 10 Aug 2011 05:52:41 +0200
Message-ID: <1312948364-2587-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-003.synserver.de (smtp-out-003.synserver.de
	[212.40.185.3]) by alsa0.perex.cz (Postfix) with SMTP id 4FB4D24473
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 05:54:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Currently it is only possible to route one source per switch into a mixer.
This patch modifies the code, so that it is possible to route multiple sources
into a mixer via the same switch. One use-case for this is routing a stereo
channel pair into a mono-mixer via the same switch.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c265311..170c4ff 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -443,6 +443,11 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
 
+			if (w->kcontrols[i]) {
+				path->kcontrol = w->kcontrols[i];
+				continue;
+			}
+
 			wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
 				    sizeof(struct snd_soc_dapm_widget *),
 			wlist = kzalloc(wlistsize, GFP_KERNEL);
@@ -1556,7 +1561,6 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		/* found, now check type */
 		found = 1;
 		path->connect = connect;
-		break;
 	}
 
 	if (found)
-- 
1.7.2.5
