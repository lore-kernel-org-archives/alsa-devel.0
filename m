From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 5/5] ASoC: fix uninitialized variable warning
Date: Tue,  3 Aug 2010 15:20:26 -0400
Message-ID: <1280863226-6824-5-git-send-email-wfp5p@virginia.edu>
References: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
	[128.143.12.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E1B45243E3
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 21:20:27 +0200 (CEST)
In-Reply-To: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

quiet the warning about use of uninitialized fll_div in
wm8900_set_fll.  fll_div is initialized by fll_factors()

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 sound/soc/codecs/wm8900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 5da17a7..f1840c6 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -746,7 +746,7 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 	int fll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
-	struct _fll_div fll_div;
+	struct _fll_div uninitialized_var(fll_div);
 	unsigned int reg;
 
 	if (wm8900->fll_in == freq_in && wm8900->fll_out == freq_out)
-- 
1.7.2
