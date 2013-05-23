From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH] ASoC: cs42l52: fix default value for
	MASTERA_VOL.
Date: Thu, 23 May 2013 16:53:02 +0200
Message-ID: <1369320782-2371-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id CA09E262632
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 16:53:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org

The default register value for MASTERA_VOL is 0x00, the same as
MASTERB_VOL.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 8465c1fa..030f53c 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -86,7 +86,7 @@ static const struct reg_default cs42l52_reg_defaults[] = {
 	{ CS42L52_BEEP_VOL, 0x00 },	/* r1D Beep Volume off Time */
 	{ CS42L52_BEEP_TONE_CTL, 0x00 },	/* r1E Beep Tone Cfg. */
 	{ CS42L52_TONE_CTL, 0x00 },	/* r1F Tone Ctl */
-	{ CS42L52_MASTERA_VOL, 0x88 },	/* r20 Master A Volume */
+	{ CS42L52_MASTERA_VOL, 0x00 },	/* r20 Master A Volume */
 	{ CS42L52_MASTERB_VOL, 0x00 },	/* r21 Master B Volume */
 	{ CS42L52_HPA_VOL, 0x00 },	/* r22 Headphone A Volume */
 	{ CS42L52_HPB_VOL, 0x00 },	/* r23 Headphone B Volume */
-- 
1.7.10.4
