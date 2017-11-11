From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: sgio2audio: Improve a size
 determination in snd_sgio2audio_create()
Date: Sat, 11 Nov 2017 20:22:36 +0100
Message-ID: <f7ebb350-79c1-6ce2-eb15-bef62c631cb4@users.sourceforge.net>
References: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 9834E2671DF
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 20:22:41 +0100 (CET)
In-Reply-To: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 20:02:07 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/mips/sgio2audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 62715a01f507..9e175a184b66 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -840,7 +840,7 @@ static int snd_sgio2audio_create(struct snd_card *card,
 	if (!(readq(&mace->perif.audio.control) & AUDIO_CONTROL_CODEC_PRESENT))
 		return -ENOENT;
 
-	chip = kzalloc(sizeof(struct snd_sgio2audio), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
-- 
2.15.0
