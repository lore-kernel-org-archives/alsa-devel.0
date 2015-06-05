From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2] ASoC: dapm: fix prefixed stream name
	matching in snd_soc_dapm_link_dai_widgets
Date: Fri,  5 Jun 2015 18:38:25 +0200
Message-ID: <1433522305-10339-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id AC67A26688E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 18:38:48 +0200 (CEST)
Received: by wgme6 with SMTP id e6so61001117wgm.2
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2015 09:38:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

commit "ASoC: dapm: Modify widget stream name according to prefix"
fixed a part of the problem when dai_w->name and w->sname are equal
before being prefixed.

Remains the case where w->sname is only a sub string of dai_w->name.

For example, TLV320AIC3x codec defines the widget
	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0)

In snd_soc_dapm_link_dai_widgets, we will failed to match
	"[prefix] Left Playback"
with
	"[prefix] Playback".

Since dai_w and w necessarily belongs to the same dapm when strstr()
is called, they necessarily have the same prefix which allow us to
compare 'w->sname + prefix_len' with  'dai_w->name + prefix_len' directly
without length check.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/soc-dapm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e19a676..fc4408b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3392,6 +3392,9 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 
 	/* For each DAI widget... */
 	list_for_each_entry(dai_w, &card->widgets, list) {
+		const char *prefix = soc_dapm_prefix(dai_w->dapm);
+		size_t prefix_len = prefix ? strlen(prefix)+1 : 0;
+
 		switch (dai_w->id) {
 		case snd_soc_dapm_dai_in:
 		case snd_soc_dapm_dai_out:
@@ -3415,7 +3418,8 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname || !strstr(w->sname, dai_w->name))
+			if (!w->sname ||
+			    !strstr(w->sname + prefix_len, dai_w->name + prefix_len))
 				continue;
 
 			if (dai_w->id == snd_soc_dapm_dai_in) {
-- 
1.9.1
