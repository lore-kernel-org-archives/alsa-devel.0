From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu,  1 Oct 2009 09:17:36 +0300
Message-ID: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id AADEB103889
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 08:18:54 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

codec->mutex seems required if widget->* values
are altered. Moreover, snd_soc_dapm_put_volsw()
may alter widget->saved_value. dapm_set_pga()
uses widget->saved_value in a for loop which now
has a distant chance of getting out of control.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/soc-dapm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f79711b..d6fb6c4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -349,6 +349,7 @@ static int dapm_set_pga(struct snd_soc_dapm_widget *widget, int power)
 		unsigned int mask = (1 << fls(max)) - 1;
 		unsigned int invert = mc->invert;
 
+		mutex_lock(&widget->codec->mutex);
 		if (power) {
 			int i;
 			/* power up has happended, increase volume to last level */
@@ -373,6 +374,7 @@ static int dapm_set_pga(struct snd_soc_dapm_widget *widget, int power)
 			}
 			widget->muted = 1;
 		}
+		mutex_unlock(&widget->codec->mutex);
 	}
 	return 0;
 }
-- 
1.6.0.4
