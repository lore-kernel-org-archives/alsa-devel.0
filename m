From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 4/4] SOUND: wm8900,
	use uninitialized_var(fll_div)
Date: Tue, 25 Aug 2009 22:59:37 +0200
Message-ID: <1251233977-5819-4-git-send-email-jirislaby@gmail.com>
References: <1251233977-5819-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server1.wserver.cz (server1.wserver.cz [82.113.45.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FF5D24442
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 22:59:39 +0200 (CEST)
In-Reply-To: <1251233977-5819-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Jiri Slaby <jirislaby@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

To avoid a wrong compiler warning, use unitialized_var(fll_div) in
wm8900_set_fll.

If fll_div members are unitialized, we return before their use due to
error.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/codecs/wm8900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 5e9c855..255210a 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -747,7 +747,7 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 	int fll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	struct wm8900_priv *wm8900 = codec->private_data;
-	struct _fll_div fll_div;
+	struct _fll_div uninitialized_var(fll_div);
 	unsigned int reg;
 
 	if (wm8900->fll_in == freq_in && wm8900->fll_out == freq_out)
-- 
1.6.3.3
