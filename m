From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: hal2: Improve a size determination
	in hal2_create()
Date: Sat, 11 Nov 2017 19:13:15 +0100
Message-ID: <a7583868-cf4b-015c-ce6a-810be4780aa8@users.sourceforge.net>
References: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id AC25A266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 19:13:23 +0100 (CET)
In-Reply-To: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 18:34:04 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/mips/hal2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 30563d9aa5c8..675c3aba794e 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -814,7 +814,7 @@ static int hal2_create(struct snd_card *card, struct snd_hal2 **rchip)
 	struct hpc3_regs *hpc3 = hpc3c0;
 	int err;
 
-	hal2 = kzalloc(sizeof(struct snd_hal2), GFP_KERNEL);
+	hal2 = kzalloc(sizeof(*hal2), GFP_KERNEL);
 	if (!hal2)
 		return -ENOMEM;
 
-- 
2.15.0
